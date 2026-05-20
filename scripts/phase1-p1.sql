-- ═══════════════════════════════════════════════════════════════════════
-- Phase 1 — Marine creature database import
-- Generated: 2026-05-20T20:20:51.508Z
-- Families: 33  |  Cards: 467
-- Run in: Supabase Dashboard → SQL Editor
-- Safe to re-run (uses INSERT ... ON CONFLICT DO NOTHING)
-- ═══════════════════════════════════════════════════════════════════════

-- ─────────────────────────────────────────────────────────────────────────
-- STEP 1: Migration — add is_visible column (idempotent)
-- ─────────────────────────────────────────────────────────────────────────

ALTER TABLE fish_cards
  ADD COLUMN IF NOT EXISTS is_visible boolean NOT NULL DEFAULT true;

-- Also drop NOT NULL from optional columns if they were created with it
ALTER TABLE fish_cards
  ALTER COLUMN care_level DROP NOT NULL,
  ALTER COLUMN diet       DROP NOT NULL,
  ALTER COLUMN reef_safe  DROP NOT NULL;

-- ─────────────────────────────────────────────────────────────────────────
-- STEP 2: Fish families (33 rows)
-- ─────────────────────────────────────────────────────────────────────────

INSERT INTO fish_families (id, name_en, name_ar, name_ku, created_at)
VALUES
  ('fam-anemonefish-clownfish', 'Anemonefish & Clownfish', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-angelfish', 'Angelfish', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-anthias-basslets', 'Anthias & Basslets', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-batfish', 'Batfish', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-blennies', 'Blennies', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-butterflyfish', 'Butterflyfish', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-cardinalfish', 'Cardinalfish', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-damselfish', 'Damselfish', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-dottybacks', 'Dottybacks', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-eels', 'Eels', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-filefish', 'Filefish', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-frogfish', 'Frogfish', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-fusiliers', 'Fusiliers', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-goatfish', 'Goatfish', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-gobies', 'Gobies', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-groupers', 'Groupers', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-hawkfish', 'Hawkfish', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-invertebrates', 'Invertebrates', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-moorish-idol', 'Moorish Idol', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-other-reef-fish', 'Other Reef Fish', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-pufferfish-boxfish', 'Pufferfish & Boxfish', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-rabbitfish', 'Rabbitfish', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-sandtilefish', 'Sandtilefish', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-scorpionfish-lionfish', 'Scorpionfish & Lionfish', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-seahorses-pipefish', 'Seahorses & Pipefish', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-snappers-seabream', 'Snappers & Seabream', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-soapfish', 'Soapfish', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-soldierfish-squirrelfish', 'Soldierfish & Squirrelfish', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-surgeonfish-tangs', 'Surgeonfish & Tangs', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-sweetlips', 'Sweetlips', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-trevally-relatives', 'Trevally & Relatives', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-triggerfish', 'Triggerfish', '', '', '2026-05-20T20:20:51.508Z'),
  ('fam-wrasses-parrotfish', 'Wrasses & Parrotfish', '', '', '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────
-- STEP 3: Fish cards (467 rows) — grouped by family
-- ─────────────────────────────────────────────────────────────────────────
