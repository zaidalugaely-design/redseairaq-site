-- ═══════════════════════════════════════════════════════════════════════
-- Phase 2 Migration — add needs_review column to fish_cards
-- Run in: Supabase Dashboard → SQL Editor
-- Safe to re-run (uses IF NOT EXISTS)
-- ═══════════════════════════════════════════════════════════════════════

ALTER TABLE fish_cards
  ADD COLUMN IF NOT EXISTS needs_review boolean DEFAULT NULL;

-- ═══════════════════════════════════════════════════════════════════════
-- Done. All existing cards will have needs_review = NULL,
-- meaning "not yet processed by Phase 2 enrichment".
-- ═══════════════════════════════════════════════════════════════════════
