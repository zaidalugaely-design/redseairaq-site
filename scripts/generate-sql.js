#!/usr/bin/env node
// Generates scripts/phase1-import.sql from the DATA array in phase1-import.js
// Usage: node scripts/generate-sql.js > scripts/phase1-import.sql
'use strict';

const crypto = require('crypto');
const fs     = require('fs');
const path   = require('path');

// ── Inline ID helpers (same as phase1-import.js) ─────────────────────────────

function toSlug(str) {
  return str.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '');
}
function makeFamilyId(name) {
  return 'fam-' + toSlug(name).slice(0, 38);
}
function makeCardId(familyName, commonName) {
  const slug = toSlug(familyName);
  const hash = crypto.createHash('md5')
    .update(slug + '|' + commonName.toLowerCase())
    .digest('hex').slice(0, 10);
  return `fish-${hash}`;
}

// ── Load DATA from phase1-import.js without executing the whole file ─────────

const src = fs.readFileSync(path.join(__dirname, 'phase1-import.js'), 'utf8');
const dataMatch = src.match(/const DATA = (\[[\s\S]*?\n\];)/);
if (!dataMatch) { process.stderr.write('Could not find DATA array\n'); process.exit(1); }
const DATA = eval(dataMatch[1]); // safe — local file, no network calls

// ── SQL escape helper ─────────────────────────────────────────────────────────

function esc(s) {
  return s.replace(/'/g, "''");
}

// ── Build SQL ─────────────────────────────────────────────────────────────────

const lines = [];
const now = new Date().toISOString();

lines.push(`-- ═══════════════════════════════════════════════════════════════════════`);
lines.push(`-- Phase 1 — Marine creature database import`);
lines.push(`-- Generated: ${now}`);
lines.push(`-- Families: ${DATA.length}  |  Cards: ${DATA.reduce((s,f)=>s+f.cards.length,0)}`);
lines.push(`-- Run in: Supabase Dashboard → SQL Editor`);
lines.push(`-- Safe to re-run (uses INSERT ... ON CONFLICT DO NOTHING)`);
lines.push(`-- ═══════════════════════════════════════════════════════════════════════`);
lines.push(``);

// ── Step 1: Migration ─────────────────────────────────────────────────────────
lines.push(`-- ─────────────────────────────────────────────────────────────────────────`);
lines.push(`-- STEP 1: Migration — add is_visible column (idempotent)`);
lines.push(`-- ─────────────────────────────────────────────────────────────────────────`);
lines.push(``);
lines.push(`ALTER TABLE fish_cards`);
lines.push(`  ADD COLUMN IF NOT EXISTS is_visible boolean NOT NULL DEFAULT true;`);
lines.push(``);
lines.push(`-- Drop NOT NULL from optional columns if they were created with it`);
lines.push(`ALTER TABLE fish_cards`);
lines.push(`  ALTER COLUMN care_level DROP NOT NULL,`);
lines.push(`  ALTER COLUMN diet       DROP NOT NULL,`);
lines.push(`  ALTER COLUMN reef_safe  DROP NOT NULL;`);
lines.push(``);
lines.push(`-- Set default '' on translation columns so omitted values don't violate NOT NULL`);
lines.push(`ALTER TABLE fish_cards`);
lines.push(`  ALTER COLUMN common_name_ar SET DEFAULT '',`);
lines.push(`  ALTER COLUMN common_name_ku SET DEFAULT '';`);
lines.push(``);

// ── Step 2: Families ──────────────────────────────────────────────────────────
lines.push(`-- ─────────────────────────────────────────────────────────────────────────`);
lines.push(`-- STEP 2: Fish families (33 rows)`);
lines.push(`-- ─────────────────────────────────────────────────────────────────────────`);
lines.push(``);
lines.push(`INSERT INTO fish_families (id, name_en, name_ar, name_ku, created_at)`);
lines.push(`VALUES`);

const famRows = DATA.map((f, i) => {
  const id = makeFamilyId(f.family);
  const comma = i < DATA.length - 1 ? ',' : '';
  return `  ('${esc(id)}', '${esc(f.family)}', '', '', '${now}')${comma}`;
});
lines.push(...famRows);
lines.push(`ON CONFLICT (id) DO NOTHING;`);
lines.push(``);

// ── Step 3: Cards ─────────────────────────────────────────────────────────────
lines.push(`-- ─────────────────────────────────────────────────────────────────────────`);
lines.push(`-- STEP 3: Fish cards (467 rows) — grouped by family`);
lines.push(`-- ─────────────────────────────────────────────────────────────────────────`);
lines.push(``);

for (const f of DATA) {
  const famId = makeFamilyId(f.family);
  lines.push(`-- ${f.family} (${f.cards.length} cards)`);
  lines.push(`INSERT INTO fish_cards`);
  lines.push(`  (id, family_id, common_name_en, common_name_ar, scientific_name, is_visible, created_at)`);
  lines.push(`VALUES`);

  f.cards.forEach((c, i) => {
    const id    = makeCardId(f.family, c.common_name);
    const comma = i < f.cards.length - 1 ? ',' : '';
    lines.push(`  ('${esc(id)}', '${esc(famId)}', '${esc(c.common_name)}', '', '${esc(c.scientific_name)}', true, '${now}')${comma}`);
  });

  lines.push(`ON CONFLICT (id) DO NOTHING;`);
  lines.push(``);
}

lines.push(`-- ═══════════════════════════════════════════════════════════════════════`);
lines.push(`-- Done.  Expected result: 33 families + 467 fish cards inserted.`);
lines.push(`-- ═══════════════════════════════════════════════════════════════════════`);

process.stdout.write(lines.join('\n') + '\n');
