#!/usr/bin/env node
'use strict';

/**
 * One-time migration: uploads base64 data-URI product images to Supabase
 * storage and updates the image column with the public https URL.
 *
 * Run with:
 *   SB_SERVICE_KEY=your_key node scripts/migrate-base64-images.js
 *
 * Only touches rows where image LIKE 'data:%'.
 * Safe to re-run — storage uploads use upsert.
 */

const https = require('https');

const SB_URL = 'https://glhmmrovxyijtzjaldtf.supabase.co';
const BUCKET = 'products';
const SB_KEY = process.env.SB_SERVICE_KEY;

if (!SB_KEY) {
  console.error('ERROR: SB_SERVICE_KEY env var is required.');
  console.error('Run: SB_SERVICE_KEY=your_key node scripts/migrate-base64-images.js');
  process.exit(1);
}

/* ── HTTP helper ─────────────────────────────────────────── */

function request(method, path, body, extraHeaders = {}) {
  return new Promise((resolve, reject) => {
    const url  = new URL(SB_URL + path);
    const data = Buffer.isBuffer(body) ? body
               : body                  ? Buffer.from(JSON.stringify(body))
               : null;

    const req = https.request({
      hostname: url.hostname,
      path:     url.pathname + url.search,
      method,
      headers: {
        apikey:        SB_KEY,
        Authorization: `Bearer ${SB_KEY}`,
        ...extraHeaders,
        ...(data ? { 'Content-Length': data.length } : {})
      }
    }, (res) => {
      const chunks = [];
      res.on('data', c => chunks.push(c));
      res.on('end', () => resolve({ status: res.statusCode, body: Buffer.concat(chunks).toString('utf8') }));
    });
    req.on('error', reject);
    if (data) req.write(data);
    req.end();
  });
}

/* ── Helpers ─────────────────────────────────────────────── */

function parseDataUri(uri) {
  // data:[mime][;base64],<payload>
  const m = uri.match(/^data:([^;,]+)(?:[^,]*)?,(.+)$/s);
  if (!m) return null;
  const mime    = m[1].toLowerCase();
  const isB64   = uri.startsWith(`data:${m[1]};base64,`) || uri.includes(';base64,');
  const buffer  = isB64 ? Buffer.from(m[2], 'base64')
                        : Buffer.from(decodeURIComponent(m[2]));
  return { mime, buffer };
}

function ext(mime) {
  return { 'image/jpeg': 'jpg', 'image/jpg': 'jpg', 'image/png': 'png',
           'image/webp': 'webp', 'image/gif': 'gif', 'image/avif': 'avif',
           'image/svg+xml': 'svg' }[mime] || 'jpg';
}

/* ── Supabase calls ──────────────────────────────────────── */

async function fetchBase64Products() {
  const r = await request('GET',
    '/rest/v1/products?select=id,image&image=like.data:%25&limit=1000',
    null, { Accept: 'application/json' });
  if (r.status !== 200) throw new Error(`Fetch failed ${r.status}: ${r.body.slice(0,200)}`);
  return JSON.parse(r.body);
}

async function upload(storagePath, buffer, mime) {
  const r = await request('PUT',
    `/storage/v1/object/${BUCKET}/${storagePath}`,
    buffer, { 'Content-Type': mime, 'x-upsert': 'true' });
  if (r.status !== 200 && r.status !== 201)
    throw new Error(`Upload failed ${r.status}: ${r.body.slice(0,200)}`);
  return `${SB_URL}/storage/v1/object/public/${BUCKET}/${storagePath}`;
}

async function updateImage(id, url) {
  const r = await request('PATCH',
    `/rest/v1/products?id=eq.${encodeURIComponent(id)}`,
    { image: url },
    { 'Content-Type': 'application/json', Prefer: 'return=minimal' });
  if (r.status !== 200 && r.status !== 204)
    throw new Error(`Update failed ${r.status}: ${r.body.slice(0,200)}`);
}

/* ── Main ────────────────────────────────────────────────── */

async function main() {
  console.log('Fetching products with base64 data-URI images…');
  const products = await fetchBase64Products();
  console.log(`Found ${products.length} products to migrate.\n`);

  let ok = 0;
  const failed = [];

  for (const p of products) {
    try {
      const parsed = parseDataUri(p.image);
      if (!parsed) throw new Error('Could not parse data URI');

      const { mime, buffer } = parsed;
      const storagePath = `og-migrated/${p.id}.${ext(mime)}`;
      const publicUrl   = await upload(storagePath, buffer, mime);
      await updateImage(p.id, publicUrl);

      console.log(`✓ ${p.id}: ${buffer.length} bytes (${mime}) → ${publicUrl}`);
      ok++;
    } catch (e) {
      console.error(`✗ ${p.id}: ${e.message}`);
      failed.push(p.id);
    }
  }

  console.log(`\nMigrated ${ok} of ${products.length} images. Failures: ${failed.length}`);
  if (failed.length) console.log('Failed IDs:', failed.join(', '));
}

main().catch(e => { console.error('Fatal:', e.message); process.exit(1); });
