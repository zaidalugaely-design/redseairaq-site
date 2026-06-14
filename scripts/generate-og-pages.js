#!/usr/bin/env node
'use strict';

const https = require('https');
const fs    = require('fs');
const path  = require('path');

const SB_URL = 'https://glhmmrovxyijtzjaldtf.supabase.co';
const SB_KEY = 'sb_publishable_hzVe29KIzQ2h72PuHBLZ5Q_M6BLVkaI';
const SITE   = 'https://redseairaq.com';
const OUT    = path.join(__dirname, '..', 'p');

function esc(str) {
  return String(str || '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#x27;');
}

function safeImage(url) {
  if (typeof url === 'string' && url.startsWith('https://')) return url;
  return `${SITE}/logo.jpg`;
}

function fetchProducts() {
  return new Promise((resolve, reject) => {
    const reqUrl = new URL(
      `${SB_URL}/rest/v1/products?select=id,name,description,image&limit=1000`
    );
    https.get(
      { hostname: reqUrl.hostname, path: reqUrl.pathname + reqUrl.search,
        headers: { apikey: SB_KEY, Authorization: `Bearer ${SB_KEY}`, Accept: 'application/json' } },
      (res) => {
        let raw = '';
        res.on('data', c => raw += c);
        res.on('end', () => {
          try { resolve(JSON.parse(raw)); }
          catch (e) { reject(new Error(`JSON parse failed: ${e.message}\nBody: ${raw.slice(0, 200)}`)); }
        });
      }
    ).on('error', reject);
  });
}

function page(p) {
  const id      = p.id;
  const title   = esc(p.name || 'Red Sea Iraq');
  const desc    = esc((p.description || 'منتج Red Sea الأصلي — الوكيل الحصري في العراق').slice(0, 160));
  const image   = esc(safeImage(p.image));
  const ogUrl   = `${SITE}/p/${encodeURIComponent(id)}.html`;
  const hashUrl = `${SITE}/#/product/${encodeURIComponent(id)}`;
  const hashRel = `/#/product/${encodeURIComponent(id)}`;

  return `<!DOCTYPE html><html lang="ar"><head>
<meta charset="utf-8">
<meta property="og:type" content="product">
<meta property="og:title" content="${title}">
<meta property="og:description" content="${desc}">
<meta property="og:image" content="${image}">
<meta property="og:url" content="${ogUrl}">
<meta property="og:site_name" content="Red Sea Iraq">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="${title}">
<meta name="twitter:description" content="${desc}">
<meta name="twitter:image" content="${image}">
<meta http-equiv="refresh" content="0;url=${hashUrl}">
<title>${title} | Red Sea Iraq</title>
</head>
<body><p>&#x62C;&#x627;&#x631;&#x64A; &#x627;&#x644;&#x62A;&#x62D;&#x648;&#x64A;&#x644;&#x2026;</p>
<script>location.replace('${hashRel}');</script>
</body></html>`;
}

async function main() {
  console.log('Fetching products from Supabase...');
  let products;
  try {
    products = await fetchProducts();
  } catch (e) {
    console.error('ERROR fetching products:', e.message);
    process.exit(1);
  }

  if (!Array.isArray(products)) {
    console.error('Unexpected response (not an array):', JSON.stringify(products).slice(0, 200));
    process.exit(1);
  }

  if (!fs.existsSync(OUT)) fs.mkdirSync(OUT, { recursive: true });

  let count = 0;
  for (const p of products) {
    if (!p.id) continue;
    fs.writeFileSync(path.join(OUT, `${p.id}.html`), page(p), 'utf8');
    count++;
  }

  console.log(`Generated ${count} OG pages → /p/`);
}

main();
