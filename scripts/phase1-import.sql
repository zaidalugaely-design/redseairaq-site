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

-- Anemonefish & Clownfish (28 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-31a34cb834', 'fam-anemonefish-clownfish', 'Skunk Striped Fish', 'Amphiprion akallopisos', true, '2026-05-20T20:20:51.508Z'),
  ('fish-32f009389a', 'fam-anemonefish-clownfish', 'Clarck''s Fish (Pacific)', 'Amphiprion clarkii', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ded37e11b1', 'fam-anemonefish-clownfish', 'Clarck''s Fish (Ocean)', 'Amphiprion clarkii', true, '2026-05-20T20:20:51.508Z'),
  ('fish-7201c4f14b', 'fam-anemonefish-clownfish', 'Red Sadleback Fish', 'Amphiprion ephippium', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1983a8286e', 'fam-anemonefish-clownfish', 'Red Dusky Fish', 'Amphiprion melanopus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-83bc40db22', 'fam-anemonefish-clownfish', 'Clown Fish', 'Amphiprion ocellaris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-06bba0751c', 'fam-anemonefish-clownfish', 'Black Storm Clown Fish', 'Amphiprion ocellaris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c68101564a', 'fam-anemonefish-clownfish', 'Gold Nugget Clown Fish', 'Amphiprion ocellaris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-3ae1758f93', 'fam-anemonefish-clownfish', 'Lighting Maroon Clown Fish', 'Amphiprion ocellaris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-cb22357970', 'fam-anemonefish-clownfish', 'Polkadot Maroon Clown Fish', 'Amphiprion ocellaris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-657c570e27', 'fam-anemonefish-clownfish', 'Premium Lighting Maroon Clown Fish', 'Amphiprion ocellaris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1d3db3fe34', 'fam-anemonefish-clownfish', 'Percula Clown Fish', 'Amphiprion percula', true, '2026-05-20T20:20:51.508Z'),
  ('fish-006f46cb83', 'fam-anemonefish-clownfish', 'Pink Skunk Striped Fish', 'Amphiprion perideraion', true, '2026-05-20T20:20:51.508Z'),
  ('fish-9881e386fa', 'fam-anemonefish-clownfish', 'Saddle Back Fish', 'Amphiprion polymnus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-7beffbd352', 'fam-anemonefish-clownfish', 'Orange Fish', 'Amphiprion sandaracinos', true, '2026-05-20T20:20:51.508Z'),
  ('fish-96379059ed', 'fam-anemonefish-clownfish', 'Seba''s Fish', 'Amphiprion sebae', true, '2026-05-20T20:20:51.508Z'),
  ('fish-94092b95d6', 'fam-anemonefish-clownfish', 'Black Ice Clown Fish', 'Amphiprion ocellaris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1e14323a6f', 'fam-anemonefish-clownfish', 'Onyx Clown Fish', 'Amphiprion ocellaris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1ae02ac67e', 'fam-anemonefish-clownfish', 'Black Poton Clown Fish', 'Amphiprion ocellaris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1feb8a2c71', 'fam-anemonefish-clownfish', 'Frosbite Clown Fish', 'Amphiprion ocellaris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f7636c7c66', 'fam-anemonefish-clownfish', 'Half Black Clown Fish', 'Amphiprion ocellaris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-fc14b1b732', 'fam-anemonefish-clownfish', 'Picasso Clown Fish', 'Amphiprion ocellaris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-dd01f76526', 'fam-anemonefish-clownfish', 'Platinum Clown Fish', 'Amphiprion ocellaris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-9dc93ac11c', 'fam-anemonefish-clownfish', 'Premium Ligthing Maroon Clown Fish', 'Amphiprion ocellaris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ef9c9defa4', 'fam-anemonefish-clownfish', 'Snowflake Clown Fish', 'Amphiprion ocellaris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-9facec8e43', 'fam-anemonefish-clownfish', 'Orange Fish (Breeding)', 'Amphiprion sandaracinos', true, '2026-05-20T20:20:51.508Z'),
  ('fish-6391b5c588', 'fam-anemonefish-clownfish', 'Spinecheek Fish', 'Premnas biaculeatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-aad9aaf741', 'fam-anemonefish-clownfish', 'Goldstripe Maroon Fish', 'Premnas epigramma', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Angelfish (33 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-0672490029', 'fam-angelfish', 'Three spot Angelfish', 'Apolemichthys trimaculatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f457393da9', 'fam-angelfish', 'Golden Angelfish', 'Centropyge aurantius', true, '2026-05-20T20:20:51.508Z'),
  ('fish-9adb3bda6a', 'fam-angelfish', 'Bicolor Angelfish', 'Centropyge bicolor', true, '2026-05-20T20:20:51.508Z'),
  ('fish-9d822b9b88', 'fam-angelfish', 'Coral Beauty Angelfish', 'Centropyge bispinosus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f9d65d5efc', 'fam-angelfish', 'Eibl''s Angelfish', 'Centropyge eiblii', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f1dc77cd74', 'fam-angelfish', 'White Tail Angelfish', 'Centropyge flavicauda', true, '2026-05-20T20:20:51.508Z'),
  ('fish-140697c15d', 'fam-angelfish', 'Banded Pygmy Angelfish', 'Centropyge multifasciatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2f9fc15869', 'fam-angelfish', 'Midnight Angelfish', 'Centropyge nox', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c7e9bfd76e', 'fam-angelfish', 'Keyhole Angelfish', 'Centropyge tibicen', true, '2026-05-20T20:20:51.508Z'),
  ('fish-8314e43229', 'fam-angelfish', 'Pearl-scaled Angelfish', 'Centropyge vroliki', true, '2026-05-20T20:20:51.508Z'),
  ('fish-bdf93d4a5d', 'fam-angelfish', 'Black Velvet Angelfish', 'Chaetodontoplus melanosoma', true, '2026-05-20T20:20:51.508Z'),
  ('fish-927985b328', 'fam-angelfish', 'Yellow Tail Vermiculated Angelfish', 'Chaetodontoplus mesoleucus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c07625b176', 'fam-angelfish', 'Belus Swallowtail Angelfish (Female)', 'Genicanthus bellus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-6d56e968cb', 'fam-angelfish', 'Belus Swallowtail Angelfish (Male)', 'Genicanthus bellus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c23cf1d848', 'fam-angelfish', 'Red Sea Swallowtail Angelfish (Female)', 'Genicanthus caudovittatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-3be6e68631', 'fam-angelfish', 'Red Sea Swallowtail Angelfish (Male)', 'Genicanthus caudovittatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-85b27d95ad', 'fam-angelfish', 'Lamarck Swallowtail Angelfish (Female)', 'Genicanthus lamarcki', true, '2026-05-20T20:20:51.508Z'),
  ('fish-0b0a579af4', 'fam-angelfish', 'Black Spot Lyretail Angelfish (Female)', 'Genicanthus melanotilus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-93e8c59724', 'fam-angelfish', 'Black Spot Lyretail Angelfish (Male)', 'Genicanthus melanotilus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-de64b3fd80', 'fam-angelfish', 'Blue Ring Angelfish (Adult)', 'Pomacanthus annularis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-164d63d475', 'fam-angelfish', 'Blue Ring Angelfish (Juv)', 'Pomacanthus annularis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-46813da01c', 'fam-angelfish', 'Emperor Angelfish (Adult)', 'Pomacanthus imperator', true, '2026-05-20T20:20:51.508Z'),
  ('fish-472540690c', 'fam-angelfish', 'Emperor Angelfish (Juv)', 'Pomacanthus imperator', true, '2026-05-20T20:20:51.508Z'),
  ('fish-3ace17e789', 'fam-angelfish', 'Blue Girdled Angelfish (Adult)', 'Pomacanthus navarchus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-9c340a790d', 'fam-angelfish', 'Blue Girdled Angelfish (Juv)', 'Pomacanthus navarchus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-8d499f7e34', 'fam-angelfish', 'Koran Angelfish (Adult)', 'Pomacanthus semicirculatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-5d6e084ac2', 'fam-angelfish', 'Koran Angelfish (Juv)', 'Pomacanthus semicirculatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-a9e9439d46', 'fam-angelfish', 'Six Barred Angelfish (Adult)', 'Pomacanthus sextriatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-9d1674da81', 'fam-angelfish', 'Yellow Face Angelfish (Adult)', 'Pomacanthus xanthometapon', true, '2026-05-20T20:20:51.508Z'),
  ('fish-6b166ae2a9', 'fam-angelfish', 'Yellow Face Angelfish (Juv)', 'Pomacanthus xanthometapon', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f7527ad816', 'fam-angelfish', 'Six Barred Angelfish (Juv)', 'Pomacanthus sexstriatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-5ec83453a9', 'fam-angelfish', 'Regal Angelfish', 'Pygoplites diacanthus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c774e7283f', 'fam-angelfish', 'Indian Regal Angelfish', 'Pygoplites diacanthus', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Anthias & Basslets (17 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-85ddd2dfe7', 'fam-anthias-basslets', 'Gold Blotch Seaperch Anthias', 'Odontanthias borbonius', true, '2026-05-20T20:20:51.508Z'),
  ('fish-9c1ceafb6b', 'fam-anthias-basslets', 'Yellow Backed Anthias', 'Pseudanthias bicolor', true, '2026-05-20T20:20:51.508Z'),
  ('fish-68c6072f74', 'fam-anthias-basslets', 'Twinspot Anthias', 'Pseudanthias bimaculatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-e5b6b07a71', 'fam-anthias-basslets', 'Peach Anthias', 'Pseudanthias dispar', true, '2026-05-20T20:20:51.508Z'),
  ('fish-7e640ad6bc', 'fam-anthias-basslets', 'Red Striped Anthias (Female)', 'Pseudanthias fasciatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-d6046641ca', 'fam-anthias-basslets', 'Red Striped Anthias (Male)', 'Pseudanthias fasciatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-64c1813924', 'fam-anthias-basslets', 'Saddleback Anthias', 'Pseudanthias flavoguttattus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-effd1c2cca', 'fam-anthias-basslets', 'Green Anthias', 'Pseudanthias hutchi', true, '2026-05-20T20:20:51.508Z'),
  ('fish-38bce18f9a', 'fam-anthias-basslets', 'Sunset Anthias', 'Pseudanthias parvirostris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-07a60cc1dc', 'fam-anthias-basslets', 'Randal''s Anthias', 'Pseudanthias randalli', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ae22efab1d', 'fam-anthias-basslets', 'Indonesia Lyretail Anthias (Female)', 'Pseudanthias squamipinnis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f232784c65', 'fam-anthias-basslets', 'Indian Lyretail Anthias (Female)', 'Pseudanthias squamipinnis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-57b323254f', 'fam-anthias-basslets', 'Indian Lyretail Anthias (Male)', 'Pseudanthias squamipinnis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2b7fc4d4d4', 'fam-anthias-basslets', 'Purple Queen Anthias (Female)', 'Pseudanthias tuka', true, '2026-05-20T20:20:51.508Z'),
  ('fish-e5b08ed2a7', 'fam-anthias-basslets', 'Purple Queen Anthias (Male)', 'Pseudanthias tuka', true, '2026-05-20T20:20:51.508Z'),
  ('fish-4dff8f2eaa', 'fam-anthias-basslets', 'Square Spot Anthias (Female)', 'Pseudanthias pleurotaenia', true, '2026-05-20T20:20:51.508Z'),
  ('fish-61435bee9e', 'fam-anthias-basslets', 'Square Spot Anthias (Male)', 'Pseudanthias pleurotaenia', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Batfish (3 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-daeb7bca63', 'fam-batfish', 'Orbiculate Batfish', 'Platax orbicularis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-13301c01d6', 'fam-batfish', 'Longfinned Batfish', 'Platax pinnatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-52d4954d4f', 'fam-batfish', 'Round Faced Batfish', 'Platax teira', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Blennies (15 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-d6003bfdba', 'fam-blennies', 'Red Strip Goby', 'Amblygobius rainfordi', true, '2026-05-20T20:20:51.508Z'),
  ('fish-e34579db59', 'fam-blennies', 'Black Algae Blenny', 'Atrosalarias fuscus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-736b675531', 'fam-blennies', 'Two Colored Blenny', 'Ecsenius bicolor', true, '2026-05-20T20:20:51.508Z'),
  ('fish-57582bccad', 'fam-blennies', 'Leopard Blenny', 'Exallias brevis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b86ff9e5a2', 'fam-blennies', 'Rock Skipper Blenny', 'Istiblenius sp', true, '2026-05-20T20:20:51.508Z'),
  ('fish-89f10a3095', 'fam-blennies', 'Poison One Striped Fang Blenny', 'Meiacanthus smithii', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2c9c2b4320', 'fam-blennies', 'Grammistes Blenny', 'Meiacanthus grammistes', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ecf906c195', 'fam-blennies', 'Weever Blenny', 'Parapercis sp', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b1b034eed1', 'fam-blennies', 'Mimic Fang Blenny', 'Plagiotremus rhinorhynchos', true, '2026-05-20T20:20:51.508Z'),
  ('fish-cfbd596ff1', 'fam-blennies', 'Jewelled Rock Blenny', 'Salarias fasciatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-84a1e7eeda', 'fam-blennies', 'Ocellated Dragonet', 'Synchiropus ocellatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-20b1b7044c', 'fam-blennies', 'Psychedelic Dragonet', 'Synchiropus picturatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-6169bd0a2f', 'fam-blennies', 'Indonesia Mandarin Dragonet', 'Synchiropus splendidus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-4b986e1311', 'fam-blennies', 'Indonesia Mandarin Dragonet (Orange)', 'Synchiropus splendidus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c257b9b1b0', 'fam-blennies', 'Red Starry Dragonet', 'Synchiropus stellatus', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Butterflyfish (38 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-5ac8effe46', 'fam-butterflyfish', 'Panda Butterflyfish', 'Chaetodon adiergastos', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1bafb57580', 'fam-butterflyfish', 'Threadfin Butterflyfish', 'Chaetodon auriga', true, '2026-05-20T20:20:51.508Z'),
  ('fish-19f27e7251', 'fam-butterflyfish', 'Bennet''s Butterflyfish', 'Chaetodon benneti', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c4b054d38c', 'fam-butterflyfish', 'Burgess''s Butterflyfish', 'Chaetodon burgessi', true, '2026-05-20T20:20:51.508Z'),
  ('fish-4026a95037', 'fam-butterflyfish', 'Speckled Butterflyfish', 'Chaetodon citrinellus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f2538ffcf6', 'fam-butterflyfish', 'Red Tailed Butterflyfish', 'Chaetodon collare', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1b620e2954', 'fam-butterflyfish', 'Black Finned Butterflyfish', 'Chaetodon decussatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-a48ea255d2', 'fam-butterflyfish', 'Saddleback Butterflyfish', 'Chaetodon ephippium', true, '2026-05-20T20:20:51.508Z'),
  ('fish-9349f1c19f', 'fam-butterflyfish', 'Indian Saddleback Butterflyfish', 'Chaetodon falcula', true, '2026-05-20T20:20:51.508Z'),
  ('fish-6cbe35127b', 'fam-butterflyfish', 'Peppered Blue Butterflyfish', 'Chaetodon guttatissimus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-11643fdd8b', 'fam-butterflyfish', 'Klein''s Butterflyfish', 'Chaetodon kleini', true, '2026-05-20T20:20:51.508Z'),
  ('fish-de7c4bc514', 'fam-butterflyfish', 'Lined Butterflyfish', 'Chaetodon lineolatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c6affbc314', 'fam-butterflyfish', 'Raccoon Butterflyfish', 'Chaetodon lunula', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b4b9333b99', 'fam-butterflyfish', 'Pacific Pinstriped Butterflyfish', 'Chaetodon lunulatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-112c5a8b3f', 'fam-butterflyfish', 'Black Back Butterflyfish', 'Chaetodon melannotus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2c686e169d', 'fam-butterflyfish', 'Merten''s Butterflyfish', 'Chaetodon mertensii', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f23df59c31', 'fam-butterflyfish', 'Meyer''s Butterflyfish', 'Chaetodon meyeri', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b7af6e060d', 'fam-butterflyfish', 'Eight Striped Butterflyfish', 'Chaetodon octofasciatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-3bacc68a1e', 'fam-butterflyfish', 'Ornate''s Butterflyfish', 'Chaetodon ornatissimus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-3ab72f13b6', 'fam-butterflyfish', 'Spot Banded Butterflyfish', 'Chaetodon punctatofasciatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-a135fe3e7f', 'fam-butterflyfish', 'Raffle''s Butterflyfish', 'Chaetodon rafflesi', true, '2026-05-20T20:20:51.508Z'),
  ('fish-9befef0d58', 'fam-butterflyfish', 'Decorated Butterflyfish', 'Chaetodon semeion', true, '2026-05-20T20:20:51.508Z'),
  ('fish-7419dade0d', 'fam-butterflyfish', 'Oval Spot Butterflyfish', 'Chaetodon speculum', true, '2026-05-20T20:20:51.508Z'),
  ('fish-cac8f15f10', 'fam-butterflyfish', 'Triangle Butterflyfish', 'Chaetodon triangulum', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ec1b134762', 'fam-butterflyfish', 'Chevron Butterflyfish', 'Chaetodon trifascialis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1ecc288d0b', 'fam-butterflyfish', 'Pacific Saddleback Butterflyfish', 'Chaetodon ulietensis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ca4a234735', 'fam-butterflyfish', 'Pacific Teardrop Butterflyfish', 'Chaetodon unimaculatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c176ad5e37', 'fam-butterflyfish', 'Vagabond''s Butterflyfish', 'Chaetodon vagabundus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-33460b861f', 'fam-butterflyfish', 'Philippine Chevron Butterflyfish', 'Chaetodon xanthurus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-e9fbdf6035', 'fam-butterflyfish', 'Copperband Butterflyfish', 'Chelmon rostratus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-96f0abad1b', 'fam-butterflyfish', 'High Fin Coralfish', 'Coradion altivelis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-a943ca9925', 'fam-butterflyfish', 'Yellow Long Nose Butterflyfish', 'Forcipiger flavissimus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-928a21f246', 'fam-butterflyfish', 'Sky Butterflyfish', 'Hemitaurichthys polylepis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-7421d55de4', 'fam-butterflyfish', 'Brown & White Butterflyfish', 'Hemitaurichthys zoster', true, '2026-05-20T20:20:51.508Z'),
  ('fish-57c13d6511', 'fam-butterflyfish', 'Longfin Bannerfish', 'Heniochus acuminatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-69e5db7e32', 'fam-butterflyfish', 'Threeband Pennant Bannerfish', 'Heniochus chrysostomus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-4b9ccb0a7f', 'fam-butterflyfish', 'Singular Bannerfish', 'Heniochus singularis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-3edf1ae98e', 'fam-butterflyfish', 'Humphead Bannerfish', 'Heniochus varius', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Cardinalfish (5 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-f22efe04a7', 'fam-cardinalfish', 'Gold Striped Cardinalfish', 'Apogon cyanosoma', true, '2026-05-20T20:20:51.508Z'),
  ('fish-49bd5a29bf', 'fam-cardinalfish', 'Blue Streak Cardinalfish', 'Apogon liptacanthus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-da3e6e6bb4', 'fam-cardinalfish', 'Banggai Cardinalfish', 'Pterapogon kauderni', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ec9af13a94', 'fam-cardinalfish', 'Pajama Cardinalfish', 'Sphaeramia nematoptera', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ed6c470d31', 'fam-cardinalfish', 'Orbicular Cardinalfish', 'Sphaeramia orbicularis', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Damselfish (32 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-13ddc9293f', 'fam-damselfish', 'Stripe Tail Sergeant Damsel', 'Abudefduf sexfasciatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-23803b2b19', 'fam-damselfish', 'Indopacific Sergeant Damsel', 'Abudefduf vaigiensis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-bd4479c7b0', 'fam-damselfish', 'Staghorn Damsel', 'Amblyglyphidodon kuracao', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2ac5eca9e1', 'fam-damselfish', 'Golden Damsel', 'Amblyglyphidodon aureus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-21ab7b6d8a', 'fam-damselfish', 'Bicolor Chromis', 'Chromis margaritifer', true, '2026-05-20T20:20:51.508Z'),
  ('fish-5078b60bf4', 'fam-damselfish', 'Black-bar Chromis', 'Chromis retrofasciata', true, '2026-05-20T20:20:51.508Z'),
  ('fish-50aa0f5c5e', 'fam-damselfish', 'Blue Green Chromis', 'Chromis viridis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c0ca51d7ee', 'fam-damselfish', 'Surge Damselfish', 'Chrysiptera brownriggii', true, '2026-05-20T20:20:51.508Z'),
  ('fish-49ee5c0655', 'fam-damselfish', 'Blue Devil Demoiselle (Female)', 'Chrysiptera cyanea', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ffa93210ce', 'fam-damselfish', 'Blue Devil Demoiselle Orange Tailed', 'Chrysiptera cyanea', true, '2026-05-20T20:20:51.508Z'),
  ('fish-8cbf94dae8', 'fam-damselfish', 'Azure Demoiselle', 'Chrysiptera hemicyanea', true, '2026-05-20T20:20:51.508Z'),
  ('fish-0e79a2af9b', 'fam-damselfish', 'Yellow Tail Demoiselle', 'Chrysiptera parasema', true, '2026-05-20T20:20:51.508Z'),
  ('fish-5b3e7fa955', 'fam-damselfish', 'Springer''s Demoiselle', 'Chrysiptera springeri', true, '2026-05-20T20:20:51.508Z'),
  ('fish-07e8fce214', 'fam-damselfish', 'Talbot''s Demoiselle', 'Chrysiptera talboti', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2e1dbcf518', 'fam-damselfish', 'Gold Tail Demoiselle', 'Chrysiptera parasema', true, '2026-05-20T20:20:51.508Z'),
  ('fish-52069db837', 'fam-damselfish', 'White Tailed Damsel', 'Dascyllus aruanus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-d3aa2ace96', 'fam-damselfish', 'Blacktail Humbug', 'Dascyllus melanurus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-8ccb7f35a5', 'fam-damselfish', 'Three Spot Damsel', 'Dascyllus trimaculatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-84ad60d3ee', 'fam-damselfish', 'Reticulated Dascyllus', 'Dascyllus reticulatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b9e7d98316', 'fam-damselfish', 'White Damsel', 'Dischistodus perspicillatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-9eb05e2ca8', 'fam-damselfish', 'Cross''s Damselfish', 'Neoglyphidodon crossi', true, '2026-05-20T20:20:51.508Z'),
  ('fish-cfb728a9da', 'fam-damselfish', 'Coral Demoiselle', 'Neopomacentrus nemurus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-5e73325e10', 'fam-damselfish', 'Jewel Damsel', 'Plectroglyphidodon lacrymatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-6d4fb811f4', 'fam-damselfish', 'Yellow Backed Damsel', 'Paraglyphidodon melas', true, '2026-05-20T20:20:51.508Z'),
  ('fish-d04176deff', 'fam-damselfish', 'Black-mouth Damsel', 'Paraglyphidodon nigroris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1c877bfc1f', 'fam-damselfish', 'Blue Streak Damsel', 'Paraglyphidodon oxyodon', true, '2026-05-20T20:20:51.508Z'),
  ('fish-217a2b62f2', 'fam-damselfish', 'Black Barred Damsel', 'Plectroglyphidodon dickii', true, '2026-05-20T20:20:51.508Z'),
  ('fish-a875aff3f2', 'fam-damselfish', 'Allen''s Damsel', 'Pomacentrus alleni', true, '2026-05-20T20:20:51.508Z'),
  ('fish-4db6ce7a7c', 'fam-damselfish', 'Speckled Damsel', 'Pomacentrus bankanensis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-eba95e365e', 'fam-damselfish', 'Blue Stripe Damsel', 'Pomacentrus caeruleus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1b69e9c87d', 'fam-damselfish', 'Blue Damsel Fish', 'Pomacentrus coelestis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2444053bcb', 'fam-damselfish', 'Molucca Damsel', 'Pomacentrus moluccensis', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Dottybacks (8 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-ab66c512f3', 'fam-dottybacks', 'Dusky Brotulid Dottyback', 'Brotulina fusca', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b3ecc2fc4b', 'fam-dottybacks', 'Marine Betta Comet', 'Calloplesiops altivelis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-611ed5f0c5', 'fam-dottybacks', 'Giant Dottyback', 'Labracinus cyclophthalmus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-436aef4c0e', 'fam-dottybacks', 'Golden Dottyback', 'Pseudochromis aureus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2f32950f57', 'fam-dottybacks', 'Blue Stripped Dottyback (Female)', 'Pseudochromis cyanotaenia', true, '2026-05-20T20:20:51.508Z'),
  ('fish-3a7384b380', 'fam-dottybacks', 'Blue Stripped Dottyback (Male)', 'Pseudochromis cyanotaenia', true, '2026-05-20T20:20:51.508Z'),
  ('fish-8a9b5c6710', 'fam-dottybacks', 'Royal Dottyback', 'Pseudochromis paccagnellae', true, '2026-05-20T20:20:51.508Z'),
  ('fish-e8067e307b', 'fam-dottybacks', 'Strawberry Dottyback', 'Pseudochromis porphyreus', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Eels (11 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-9a62c11dc6', 'fam-eels', 'Snowflake Moray Eel', 'Echidna nebulosa', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1e4d6628fd', 'fam-eels', 'Yellow Spotted Moray', 'Echidna xanthospilos', true, '2026-05-20T20:20:51.508Z'),
  ('fish-63c1a0a25f', 'fam-eels', 'Splendid Garden Eel', 'Gorgasia preclara', true, '2026-05-20T20:20:51.508Z'),
  ('fish-3de32ac05c', 'fam-eels', 'Zebra Moray Eel', 'Gymnomuraena zebra', true, '2026-05-20T20:20:51.508Z'),
  ('fish-12f6638e7f', 'fam-eels', 'Honeycomb Moray Eel', 'Gymnothorax favagineus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1b2cd2a317', 'fam-eels', 'Giant Moray Eel', 'Gymnothorax javanicus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-5e50e4fbeb', 'fam-eels', 'Spotted Garden Eel', 'Heteroconger hassi', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f22d2f3f6f', 'fam-eels', 'Coloured Moray Eel', 'Muraena sp', true, '2026-05-20T20:20:51.508Z'),
  ('fish-a3e1169949', 'fam-eels', 'White Ribbon Eel', 'Pseudechidna brummeri', true, '2026-05-20T20:20:51.508Z'),
  ('fish-03104d4301', 'fam-eels', 'Blue Ribbon Eel (Male)', 'Rhinomuraena quaesita', true, '2026-05-20T20:20:51.508Z'),
  ('fish-fbd942075e', 'fam-eels', 'Black Ribbon Eel (Juv)', 'Rhinomuraena quaesita', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Filefish (6 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-2c286d4625', 'fam-filefish', 'Sea Grass Filefish', 'Acreichthys tomentosus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-4ebd725e8e', 'fam-filefish', 'Scribbled Filefish', 'Aluterus scriptus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-3c0c0689ba', 'fam-filefish', 'Prickly Leather Filefish', 'Chaetodermis peniciligerus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2c107697f7', 'fam-filefish', 'Harlequin Filefish', 'Oxymonacanthus longirostris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-a57f5e78cb', 'fam-filefish', 'Orange Tail Filefish', 'Pervagor aspricaudus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-4f3b64b0d4', 'fam-filefish', 'Redtailed Filefish', 'Pervagor melanocephalus', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Frogfish (13 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-23c0971d11', 'fam-frogfish', 'Scarlet Frogfish', 'Antennarius coccineus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-da3db9c3c6', 'fam-frogfish', 'Common Giant Frogfish', 'Antennarius commerson', true, '2026-05-20T20:20:51.508Z'),
  ('fish-30cb71f894', 'fam-frogfish', 'Black Giant Frogfish', 'Antennarius commerson', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ab9f7f208d', 'fam-frogfish', 'Orange Giant Frogfish', 'Antennarius commerson', true, '2026-05-20T20:20:51.508Z'),
  ('fish-7e5f1af0b0', 'fam-frogfish', 'Coloured Giant Frogfish', 'Antennarius commerson', true, '2026-05-20T20:20:51.508Z'),
  ('fish-e879724b4d', 'fam-frogfish', 'Painted Frogfish', 'Antennarius pictus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-275ed8702d', 'fam-frogfish', 'Painted Frogfish (Black)', 'Antennarius pictus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-937eed8549', 'fam-frogfish', 'Painted Frogfish (Yellow)', 'Antennarius pictus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b40f1603b2', 'fam-frogfish', 'Painted Frogfish (Red)', 'Antennarius pictus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-9942ce2af2', 'fam-frogfish', 'Painted Frogfish (Coloured)', 'Antennarius pictus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-e43b7e9aad', 'fam-frogfish', 'Rare Warty Frogfish', 'Antennarius maculatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c1ed88a4f8', 'fam-frogfish', 'Oriental Flying Gurnard', 'Dactyloptena orientalis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-964fa6d055', 'fam-frogfish', 'Sargassum Frogfish', 'Histrio histrio', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Fusiliers (1 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-5bf58532ae', 'fam-fusiliers', 'Yellow Back Fusilier', 'Caesio teres', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Goatfish (2 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-65462f4aae', 'fam-goatfish', 'Yellow Saddle Goatfish', 'Parupeneus cyclostomus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b9617d0585', 'fam-goatfish', 'Black Striped Goatfish', 'Parupeneus tragula', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Gobies (26 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-e448f163d2', 'fam-gobies', 'Pink Bar Prawn Goby', 'Amblyeleotris aurora', true, '2026-05-20T20:20:51.508Z'),
  ('fish-727d3ef349', 'fam-gobies', 'Orange Spotted Prawn Goby', 'Amblyeleotris guttata', true, '2026-05-20T20:20:51.508Z'),
  ('fish-3647f68b93', 'fam-gobies', 'Randall''s Prawn Goby', 'Amblyeleotris randalli', true, '2026-05-20T20:20:51.508Z'),
  ('fish-a14fd91f92', 'fam-gobies', 'Steinitz''s Prawn Goby', 'Amblyeleotris steinitzi', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1a9f249f0d', 'fam-gobies', 'Wheeler''s Prawn Goby', 'Amblyeleotris wheeleri', true, '2026-05-20T20:20:51.508Z'),
  ('fish-e59b183aaf', 'fam-gobies', 'Banded Goby', 'Amblygobius phalaena', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2e2f0c7ab1', 'fam-gobies', 'Yellow Watchman Prawn Goby', 'Cryptocentrus cinctus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-8ff4e1fc29', 'fam-gobies', 'Pink & Blue Spotted Prawn Goby', 'Cryptocentrus leptocephalus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b8bca4ebd3', 'fam-gobies', 'Tangaroa Prawn Goby', 'Ctenogobiops tangaroai', true, '2026-05-20T20:20:51.508Z'),
  ('fish-cd48a46af1', 'fam-gobies', 'Green Spotted Coral Goby', 'Gobiodon histrio', true, '2026-05-20T20:20:51.508Z'),
  ('fish-de8f815aa9', 'fam-gobies', 'Yellow Clown Goby', 'Gobiodon okinawae', true, '2026-05-20T20:20:51.508Z'),
  ('fish-e1db36f825', 'fam-gobies', 'Decorated Dart Goby', 'Nemateleotris decora', true, '2026-05-20T20:20:51.508Z'),
  ('fish-0ccf155286', 'fam-gobies', 'Fire Fish', 'Nemateleotris magnifica', true, '2026-05-20T20:20:51.508Z'),
  ('fish-916838ff09', 'fam-gobies', 'Blackfin Dart Goby', 'Ptereleotris evides', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2253e29804', 'fam-gobies', 'Spot Tail Dart Goby', 'Ptereleotris heteroptera', true, '2026-05-20T20:20:51.508Z'),
  ('fish-7b46a686c5', 'fam-gobies', 'Pearly Dart Goby', 'Ptereleotris microlepis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-7356360c3b', 'fam-gobies', 'Zebra Dart Goby', 'Ptereleotris zebra', true, '2026-05-20T20:20:51.508Z'),
  ('fish-15b2118cf3', 'fam-gobies', 'Two Spot Goby', 'Signigobius biocellatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c685f733d6', 'fam-gobies', 'White Rayed Antenna Prawn Goby', 'Stonogobiops yasha', true, '2026-05-20T20:20:51.508Z'),
  ('fish-5b64767011', 'fam-gobies', 'Black Rayed Antenna Prawn Goby', 'Stonogobiops nematodes', true, '2026-05-20T20:20:51.508Z'),
  ('fish-32434433f1', 'fam-gobies', 'Two Stripe Sleeper Goby', 'Valenciennea helsdingenii', true, '2026-05-20T20:20:51.508Z'),
  ('fish-a37c66a2d3', 'fam-gobies', 'Long Finned Goby', 'Valenciennea longipinnis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f6c95f7283', 'fam-gobies', 'Mural Sleeper Goby', 'Valenciennea muralis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-0f8b4a70bc', 'fam-gobies', 'Pretty Prawn Goby', 'Valenciennea puellaris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f5942f627d', 'fam-gobies', 'Six Spotted Sleeper Goby', 'Valenciennea sexguttata', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c7f3911d34', 'fam-gobies', 'Golden Head Sleeper Goby', 'Valenciennea strigata', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Groupers (3 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-6142d750c8', 'fam-groupers', 'Harlequin Grouper', 'Cephalopholis polleni', true, '2026-05-20T20:20:51.508Z'),
  ('fish-37b364d0d1', 'fam-groupers', 'Panther Grouper', 'Cromileptes altivelis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b5f49da6cb', 'fam-groupers', 'Blue & Yellow Grouper', 'Epinephelus flavocoeruleus', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Hawkfish (2 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-c65a35d785', 'fam-hawkfish', 'Threadfin Hawkfish', 'Cirrhitichthys aprinus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-97367fa464', 'fam-hawkfish', 'Long Nose Hawkfish', 'Oxycirrhites typus', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Invertebrates (60 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-0d14cff5f6', 'fam-invertebrates', 'Fire Anemone', 'Actinodendron plumosum', true, '2026-05-20T20:20:51.508Z'),
  ('fish-3f3500e985', 'fam-invertebrates', 'Randall''s Snapping Shrimp', 'Alpheus randalli', true, '2026-05-20T20:20:51.508Z'),
  ('fish-7f362d5766', 'fam-invertebrates', 'Flying Sea Hare', 'Aplysia sp', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1372efd9bd', 'fam-invertebrates', 'White Sand Shifting Sea Star', 'Archaster typicus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-64ac4f0808', 'fam-invertebrates', 'Red-White Feather-duster Tube Worm', 'Bispira sp', true, '2026-05-20T20:20:51.508Z'),
  ('fish-e61bcd00f3', 'fam-invertebrates', 'Electric Blue Knuckle Hermit Crab', 'Calcinus elegans', true, '2026-05-20T20:20:51.508Z'),
  ('fish-6e5d4187c4', 'fam-invertebrates', 'Tube Anemone Orange', 'Cerianthus membranaceus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1425e27bf5', 'fam-invertebrates', 'Anna''s Chromodoris Nudibranch', 'Chromodoris annae', true, '2026-05-20T20:20:51.508Z'),
  ('fish-07ba20cc9e', 'fam-invertebrates', 'Helmet Urchin', 'Colobocentrotus atratus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-27099d016d', 'fam-invertebrates', 'Whitespotted Hermit Crab', 'Dardanus megistos', true, '2026-05-20T20:20:51.508Z'),
  ('fish-0c2be664a7', 'fam-invertebrates', 'Long-spined Sea Urchin', 'Diadema setosum', true, '2026-05-20T20:20:51.508Z'),
  ('fish-78d1a89ac4', 'fam-invertebrates', 'Wedge Sea Hare', 'Dolabella auricularia', true, '2026-05-20T20:20:51.508Z'),
  ('fish-aabeba9c95', 'fam-invertebrates', 'Burrowing Sea Urchin', 'Echinometra mathaei', true, '2026-05-20T20:20:51.508Z'),
  ('fish-442b893926', 'fam-invertebrates', 'Debelius Reef Lobster', 'Enoplometopus debelius', true, '2026-05-20T20:20:51.508Z'),
  ('fish-7576828a59', 'fam-invertebrates', 'Corn Anemone Green', 'Entacmea quadricolor', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b44e082ba3', 'fam-invertebrates', 'Corn Anemone Red Metallic', 'Entacmea quadricolor', true, '2026-05-20T20:20:51.508Z'),
  ('fish-04f72a50bb', 'fam-invertebrates', 'Peppermint Sea Star (Assorted)', 'Fromia monilis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-fc79328235', 'fam-invertebrates', 'Bumble Bee Shrimp', 'Gnathophyllum americanum', true, '2026-05-20T20:20:51.508Z'),
  ('fish-879fbf492e', 'fam-invertebrates', 'Sand Anemone Brown', 'Heteractis crispa', true, '2026-05-20T20:20:51.508Z'),
  ('fish-147f8782af', 'fam-invertebrates', 'Sand Anemone Purple', 'Heteractis crispa', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f6e094c822', 'fam-invertebrates', 'Clown Anemone', 'Heteractis magnifica', true, '2026-05-20T20:20:51.508Z'),
  ('fish-03299e4d08', 'fam-invertebrates', 'Clown Anemone Metallic', 'Heteractis magnifica', true, '2026-05-20T20:20:51.508Z'),
  ('fish-952cf8453b', 'fam-invertebrates', 'Clown Anemone Violet Tip', 'Heteractis magnifica', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b5fd324b92', 'fam-invertebrates', 'Ordinary Base Anemone White Milk', 'Heteractis malu', true, '2026-05-20T20:20:51.508Z'),
  ('fish-979394382d', 'fam-invertebrates', 'Black Long Sea Cucumber', 'Holothuria leucospilota', true, '2026-05-20T20:20:51.508Z'),
  ('fish-33eb13f4e2', 'fam-invertebrates', 'Harlequin Shrimp', 'Hymenocera picta', true, '2026-05-20T20:20:51.508Z'),
  ('fish-59e95dbe20', 'fam-invertebrates', 'Hypselodoris Nudibranch (Assorted)', 'Hypselodoris sp', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f3121e41fe', 'fam-invertebrates', 'Comet Linckia Sea Star', 'Linckia guildingi', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1f8f968fcc', 'fam-invertebrates', 'Blue Linckia Sea Star', 'Linckia laevigata', true, '2026-05-20T20:20:51.508Z'),
  ('fish-7bad390de8', 'fam-invertebrates', 'Boxer Crab', 'Lybia tesselata', true, '2026-05-20T20:20:51.508Z'),
  ('fish-d33ce6ee38', 'fam-invertebrates', 'Peppermint Cleaner Shrimp', 'Lysmata vittata', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b64cbf885b', 'fam-invertebrates', 'Kuekenthali''s Cleaner Shrimp', 'Lysmata kuekenthali', true, '2026-05-20T20:20:51.508Z'),
  ('fish-087744d7e9', 'fam-invertebrates', 'Long Tentacle Anemone Green', 'Macrodactyla doreensis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-830af3c67b', 'fam-invertebrates', 'Long Tentacle Anemone Purple', 'Macrodactyla doreensis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1d83c483e3', 'fam-invertebrates', 'Globe Sea Urchin (Brown Spines)', 'Mespilia globulus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-810a144e59', 'fam-invertebrates', 'Globe Sea Urchin (Red Spines)', 'Mespilia globulus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-26881c582f', 'fam-invertebrates', 'Tongan Nassarius Snail', 'Nassarius distortus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-8c4c8095bc', 'fam-invertebrates', 'Anemone Crab', 'Neopetrolisthes ohshimai', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c7c2fde3a9', 'fam-invertebrates', 'Zebra Brittle Sea Star', 'Ophiolepis superba', true, '2026-05-20T20:20:51.508Z'),
  ('fish-19b311ad40', 'fam-invertebrates', 'Chain-link Brittle Sea Star', 'Ophiomastix annulosa', true, '2026-05-20T20:20:51.508Z'),
  ('fish-425bf4823b', 'fam-invertebrates', 'Scarlet Reef Hermit Crab', 'Paguristes cadenati', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b54b520bf6', 'fam-invertebrates', 'Knobbly Sea Star', 'Protoreaster nodosus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-3560019d13', 'fam-invertebrates', 'Bumble Bee Snail', 'Pusiostoma mendicaria', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ef6fb4553f', 'fam-invertebrates', 'Camel Shrimp', 'Rhynchocinetes durbanensis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-0d40508c94', 'fam-invertebrates', 'Common Feather-duster Tube Worm', 'Sabellastarte spectabilis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ed3c698dd5', 'fam-invertebrates', 'Yellow Feather-duster Tube Worm', 'Sabellastarte spectabilis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-d2061ff280', 'fam-invertebrates', 'Saron Shrimp', 'Saron marmoratus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ff65c4ce87', 'fam-invertebrates', 'Banded Coral Shrimp', 'Stenopus hispidus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-96a72b016c', 'fam-invertebrates', 'Gold Banded Coral Shrimp', 'Stenopus zanzibaricus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-af4692080f', 'fam-invertebrates', 'Purple Banded Coral Shrimp', 'Stenopus zanzibaricus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1be2c527c8', 'fam-invertebrates', 'Carpet Anemone Brown', 'Stichodactyla haddoni', true, '2026-05-20T20:20:51.508Z'),
  ('fish-e5927141f9', 'fam-invertebrates', 'Orange Carpet Anemone', 'Stichodactyla gigantea', true, '2026-05-20T20:20:51.508Z'),
  ('fish-8807edef9f', 'fam-invertebrates', 'Carpet Anemone White', 'Stichodactyla haddoni', true, '2026-05-20T20:20:51.508Z'),
  ('fish-eed0b2e632', 'fam-invertebrates', 'Little Pitcher Conch (Assorted)', 'Strombus urceus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-4010611f47', 'fam-invertebrates', 'Turban Algae Shell', 'Tectus fenestratus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-9c4945cb8d', 'fam-invertebrates', 'Sexy Anemone Shrimp', 'Thor amboinensis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1240bdfc14', 'fam-invertebrates', 'White Collector Sea Urchin', 'Tripneustes gratilla', true, '2026-05-20T20:20:51.508Z'),
  ('fish-53a4695edf', 'fam-invertebrates', 'Multicolor Collector Sea Urchin', 'Tripneustes gratilla', true, '2026-05-20T20:20:51.508Z'),
  ('fish-4816c8888f', 'fam-invertebrates', 'Assorted Red Banded Algae Snail', 'Trochus histrio', true, '2026-05-20T20:20:51.508Z'),
  ('fish-52255c0923', 'fam-invertebrates', 'Dwarf Turban Snail (Assorted)', 'Turbo bruneus', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Moorish Idol (1 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-b1ee18a245', 'fam-moorish-idol', 'Moorish Idol', 'Zanclus cornutus', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Other Reef Fish (3 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-ceaf1887d5', 'fam-other-reef-fish', 'Eye Flounder', 'Bothus sp', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ac828bb297', 'fam-other-reef-fish', 'Striped Catfish', 'Plotosus lineatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-3aca72bb74', 'fam-other-reef-fish', 'Bridled Monocle Bream', 'Scolopsis bilineatus', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Pufferfish & Boxfish (14 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-f8baf0634c', 'fam-pufferfish-boxfish', 'Stars & Stripes Pufferfish', 'Arothron hispidus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-201b601c82', 'fam-pufferfish-boxfish', 'Striped Pufferfish', 'Arothron manilensis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-54839b2440', 'fam-pufferfish-boxfish', 'Map Pufferfish', 'Arothron mappa', true, '2026-05-20T20:20:51.508Z'),
  ('fish-74e9e94bba', 'fam-pufferfish-boxfish', 'Black Spotted Pufferfish (Grey)', 'Arothron nigropunctatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1ac05e27dd', 'fam-pufferfish-boxfish', 'Star Pufferfish', 'Arothron stellatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c880fb4a87', 'fam-pufferfish-boxfish', 'Bennett''s Toby', 'Canthigaster bennetti', true, '2026-05-20T20:20:51.508Z'),
  ('fish-3b1cf9774e', 'fam-pufferfish-boxfish', 'Spotted Toby', 'Canthigaster solandri', true, '2026-05-20T20:20:51.508Z'),
  ('fish-8459d7b510', 'fam-pufferfish-boxfish', 'Black Saddled Toby', 'Canthigaster valentini', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f652b1014b', 'fam-pufferfish-boxfish', 'Black Blotched Porcupine Fish', 'Diodon liturosus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-0824c43f1b', 'fam-pufferfish-boxfish', 'Longhorned Cowfish', 'Lactoria cornuta', true, '2026-05-20T20:20:51.508Z'),
  ('fish-5112841860', 'fam-pufferfish-boxfish', 'Yellow Black Spotted Boxfish', 'Ostracion cubicus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f32e186475', 'fam-pufferfish-boxfish', 'Blue Spotted Boxfish (Male)', 'Ostracion meleagris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-043f31596c', 'fam-pufferfish-boxfish', 'Black Spotted Boxfish (Female)', 'Ostracion meleagris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b253815408', 'fam-pufferfish-boxfish', 'Horn Nosed Boxfish', 'Ostracion rhinorhynchos', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Rabbitfish (7 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-52531984db', 'fam-rabbitfish', 'White Spotted Rabbitfish', 'Siganus canaliculatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c0ed1999da', 'fam-rabbitfish', 'Indian Coral Rabbitfish', 'Siganus corallinus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-61091c491d', 'fam-rabbitfish', 'Magnificent Rabbitfish', 'Siganus magnificus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f689034778', 'fam-rabbitfish', 'Chin Strap Rabbitfish', 'Siganus puelloides', true, '2026-05-20T20:20:51.508Z'),
  ('fish-62f17a66aa', 'fam-rabbitfish', 'Golden Masked Rabbitfish', 'Siganus puellus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-6825f89b33', 'fam-rabbitfish', 'Double Barred Rabbitfish', 'Siganus virgatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-14bc515541', 'fam-rabbitfish', 'Foxface Rabbitfish', 'Siganus vulpinus', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Sandtilefish (6 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-2add94e3ab', 'fam-sandtilefish', 'Green Sandtilefish', 'Hoplolatilus cuniculus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-49665fe401', 'fam-sandtilefish', 'Yellow Sandtilefish', 'Hoplolatilus luteus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-49e54e3c8a', 'fam-sandtilefish', 'Red Stripe Sandtilefish', 'Hoplolatilus marcosi', true, '2026-05-20T20:20:51.508Z'),
  ('fish-6b31a9aca7', 'fam-sandtilefish', 'Purple Sandtilefish', 'Hoplolatilus purpureus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c487099cb6', 'fam-sandtilefish', 'Purple Headed Sandtilefish', 'Hoplolatilus starcki', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f7ab9b0e91', 'fam-sandtilefish', 'Striped Blanquillo', 'Malacanthus latovittatus', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Scorpionfish & Lionfish (12 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-0fb57dab76', 'fam-scorpionfish-lionfish', 'Cockatoo Waspfish', 'Ablabys taenianotus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c2b3e6dbbd', 'fam-scorpionfish-lionfish', 'Twinspot Lionfish', 'Dendrochirus biocellatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-6c0fa8172b', 'fam-scorpionfish-lionfish', 'Shortfin Lionfish', 'Dendrochirus brachypterus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-02a7ce6ae4', 'fam-scorpionfish-lionfish', 'Zebra Lionfish', 'Dendrochirus zebra', true, '2026-05-20T20:20:51.508Z'),
  ('fish-9f34047784', 'fam-scorpionfish-lionfish', 'Spotfin Lionfish', 'Pterois antennata', true, '2026-05-20T20:20:51.508Z'),
  ('fish-03d4aaca37', 'fam-scorpionfish-lionfish', 'Tailbar Lionfish', 'Pterois radiata', true, '2026-05-20T20:20:51.508Z'),
  ('fish-37930fb424', 'fam-scorpionfish-lionfish', 'Goose Scorpionfish (Yellow)', 'Rhinopias frondosa', true, '2026-05-20T20:20:51.508Z'),
  ('fish-44c85a0454', 'fam-scorpionfish-lionfish', 'Goose Scorpionfish (Red)', 'Rhinopias frondosa', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c8427f83bd', 'fam-scorpionfish-lionfish', 'Goose Scorpionfish (Purple)', 'Rhinopias frondosa', true, '2026-05-20T20:20:51.508Z'),
  ('fish-e6585580eb', 'fam-scorpionfish-lionfish', 'Sailfin/Leaf Scorpionfish', 'Taenianotus triacanthos', true, '2026-05-20T20:20:51.508Z'),
  ('fish-8cc8548ef1', 'fam-scorpionfish-lionfish', 'Sailfin/Leaf Scorpionfish Yellow', 'Taenianotus triacanthos', true, '2026-05-20T20:20:51.508Z'),
  ('fish-8653c968ea', 'fam-scorpionfish-lionfish', 'Sailfin/Leaf Scorpionfish Red/Purple', 'Taenianotus triacanthos', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Seahorses & Pipefish (6 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-ea257024bd', 'fam-seahorses-pipefish', 'Shrimp Fish', 'Aeoliscus strigatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-81e816702d', 'fam-seahorses-pipefish', 'Messmate Pipefish', 'Corythoichthys intestinalis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-8a43f47f26', 'fam-seahorses-pipefish', 'Banded Pipefish', 'Doryhamphus dactyliophorus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2d9ee6b076', 'fam-seahorses-pipefish', 'Janss Pipefish', 'Doryhamphus janssi', true, '2026-05-20T20:20:51.508Z'),
  ('fish-da94283e8b', 'fam-seahorses-pipefish', 'Many Banded Pipefish', 'Doryhamphus multiannulatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1375c0ee89', 'fam-seahorses-pipefish', 'Alligator Pipefish', 'Syngnathoides biaculeatus', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Snappers & Seabream (5 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-a607a635f9', 'fam-snappers-seabream', 'Blue Lined Snapper', 'Lutjanus kasmira', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ca1476726f', 'fam-snappers-seabream', 'Emperor Snapper', 'Lutjanus sebae', true, '2026-05-20T20:20:51.508Z'),
  ('fish-7a1e82ea6c', 'fam-snappers-seabream', 'Malabar Blood Snapper', 'Lutjanus malabaricus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-79c476a561', 'fam-snappers-seabream', 'Black Beauty Snapper', 'Macolor niger', true, '2026-05-20T20:20:51.508Z'),
  ('fish-e49d71d182', 'fam-snappers-seabream', 'Blue Lined Seabream', 'Symphorichthys spilurus', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Soapfish (1 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-484ccf2fdd', 'fam-soapfish', 'Sixstripe Soapfish', 'Grammistes sexlineatus', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Soldierfish & Squirrelfish (2 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-db75ccc7d8', 'fam-soldierfish-squirrelfish', 'White Edge Soldierfish', 'Myripristis axillaris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-db0007cbc4', 'fam-soldierfish-squirrelfish', 'Soldierfish', 'Myripristis sp', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Surgeonfish & Tangs (32 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-25d1702fc7', 'fam-surgeonfish-tangs', 'Black Spot Surgeonfish', 'Acanthurus bariene', true, '2026-05-20T20:20:51.508Z'),
  ('fish-a9271df480', 'fam-surgeonfish-tangs', 'Horse Shoe Surgeonfish', 'Acanthurus fowleri', true, '2026-05-20T20:20:51.508Z'),
  ('fish-d3c0223a98', 'fam-surgeonfish-tangs', 'Mustard Surgeonfish', 'Acanthurus guttatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-683e5b6dea', 'fam-surgeonfish-tangs', 'White Faced Surgeonfish', 'Acanthurus japonicus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c2aaac26f7', 'fam-surgeonfish-tangs', 'Powder Blue Surgeonfish', 'Acanthurus leucosternon', true, '2026-05-20T20:20:51.508Z'),
  ('fish-83e8505a56', 'fam-surgeonfish-tangs', 'Lined Clown Surgeonfish', 'Acanthurus lineatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ebfb8712a0', 'fam-surgeonfish-tangs', 'Black Eared Spot Faced Surgeonfish', 'Acanthurus maculiceps', true, '2026-05-20T20:20:51.508Z'),
  ('fish-8a1b6851ad', 'fam-surgeonfish-tangs', 'Yellow Eyed Surgeonfish', 'Acanthurus mata', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c0dd109c6a', 'fam-surgeonfish-tangs', 'Gold Rimmed Surgeonfish', 'Acanthurus nigricans', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1a593aaf90', 'fam-surgeonfish-tangs', 'Eye Line Surgeonfish', 'Acanthurus nigricaudus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-0bd0759c4f', 'fam-surgeonfish-tangs', 'Dusky Red Surgeonfish', 'Acanthurus nigrofuscus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-6c0eb7a03e', 'fam-surgeonfish-tangs', 'Orange Blotch Surgeonfish (Adult)', 'Acanthurus olivaceus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-aa697de4f1', 'fam-surgeonfish-tangs', 'Orange Blotch Surgeonfish (Juv)', 'Acanthurus olivaceus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-abc457115a', 'fam-surgeonfish-tangs', 'Yellow Mimic Surgeonfish (Juv)', 'Acanthurus pyroferus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ce95f3f28e', 'fam-surgeonfish-tangs', 'Yellow Mimic Surgeonfish (Adult)', 'Acanthurus pyroferus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2690342fa0', 'fam-surgeonfish-tangs', 'Lieutenant Surgeonfish', 'Acanthurus tennenti', true, '2026-05-20T20:20:51.508Z'),
  ('fish-38229aa037', 'fam-surgeonfish-tangs', 'Convict Surgeonfish', 'Acanthurus triostegus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-6628287416', 'fam-surgeonfish-tangs', 'Yellow Mask Surgeonfish', 'Acanthurus xanthopterus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1ce4516da1', 'fam-surgeonfish-tangs', 'Indonesian Powder Blue Surgeonfish', 'Acanthurus leucosternon', true, '2026-05-20T20:20:51.508Z'),
  ('fish-12a7bbc7c8', 'fam-surgeonfish-tangs', 'Two Spot Bristletooth Surgeonfish', 'Ctenochaetus binotatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1fe145174a', 'fam-surgeonfish-tangs', 'Striped Bristletooth Surgeonfish', 'Ctenochaetus striatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b5a728fb6c', 'fam-surgeonfish-tangs', 'Tomini Bristletooth', 'Ctenochaetus tominiensis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-38ab212d82', 'fam-surgeonfish-tangs', 'Indian Orange Spine Unicornfish', 'Naso elegans', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1ec382535f', 'fam-surgeonfish-tangs', 'Pacific Orange Spine Unicornfish', 'Naso lituratus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-30b9dcb08a', 'fam-surgeonfish-tangs', 'Blue Spine Unicornfish', 'Naso unicornis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-fd49546a8c', 'fam-surgeonfish-tangs', 'Vlaming''s Unicornfish', 'Naso vlamingii', true, '2026-05-20T20:20:51.508Z'),
  ('fish-58df7c8af4', 'fam-surgeonfish-tangs', 'Blue Surgeonfish', 'Paracanthurus hepatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c078cdcc1f', 'fam-surgeonfish-tangs', 'Sawtail Fish', 'Prionurus chrysurus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-9b9d0fa96b', 'fam-surgeonfish-tangs', 'Desjardin''s Sailfin Tang', 'Zebrasoma desjardinii', true, '2026-05-20T20:20:51.508Z'),
  ('fish-35eb2561e6', 'fam-surgeonfish-tangs', 'Brown Sailfin Tang', 'Zebrasoma scopas', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b283782fcf', 'fam-surgeonfish-tangs', 'Koi/Aberrant Tang', 'Zebrasoma scopas', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b36b69755e', 'fam-surgeonfish-tangs', 'Pacific Sailfin Tang', 'Zebrasoma veliferum', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Sweetlips (4 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-23cd4bd5c9', 'fam-sweetlips', 'Harlequin Sweetlip', 'Plectorhynchus chaetodonoides', true, '2026-05-20T20:20:51.508Z'),
  ('fish-95f22e5304', 'fam-sweetlips', 'Lined Sweetlip', 'Plectorhynchus lineatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2288a3c19c', 'fam-sweetlips', 'Oriental Sweetlip', 'Plectorhynchus orientalis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-869843ecce', 'fam-sweetlips', 'Painted Sweetlip', 'Plectorhynchus pictus', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Trevally & Relatives (3 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-3f92d6780b', 'fam-trevally-relatives', 'African Pompano', 'Alectis ciliaris', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2c0ff92686', 'fam-trevally-relatives', 'Lined Shark Suckers', 'Echeneis naucrates', true, '2026-05-20T20:20:51.508Z'),
  ('fish-3ddcb92547', 'fam-trevally-relatives', 'Golden Trevally', 'Gnathanodon speciosus', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Triggerfish (12 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-de968d3f71', 'fam-triggerfish', 'Orange Striped Triggerfish', 'Balistapus undulatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-fc9c5d0165', 'fam-triggerfish', 'Clown Triggerfish', 'Balistoides conspicillum', true, '2026-05-20T20:20:51.508Z'),
  ('fish-abd8e0d96a', 'fam-triggerfish', 'Black Triggerfish', 'Melichthys niger', true, '2026-05-20T20:20:51.508Z'),
  ('fish-3525b302a1', 'fam-triggerfish', 'Pinktail Triggerfish', 'Melichthys vidua', true, '2026-05-20T20:20:51.508Z'),
  ('fish-70dc7df5bc', 'fam-triggerfish', 'Redtooth Triggerfish', 'Odonus niger', true, '2026-05-20T20:20:51.508Z'),
  ('fish-cd0219768a', 'fam-triggerfish', 'Blue & Gold Triggerfish', 'Pseudobalistes fuscus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b3dee7affe', 'fam-triggerfish', 'Picasso Triggerfish/Humu-humu', 'Rhinecanthus aculeatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-345302472a', 'fam-triggerfish', 'Rectangle Triggerfish', 'Rhinecanthus rectangulus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-24c6dea7b1', 'fam-triggerfish', 'Black Belly Triggerfish', 'Rhinecanthus verrucosus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-de698fc2c8', 'fam-triggerfish', 'Half Moon Triggerfish', 'Sufflamen chrysopterus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b677d12074', 'fam-triggerfish', 'Guilded Triggerfish (Female)', 'Xanthichthys auromarginatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-8aa3f85ad1', 'fam-triggerfish', 'Guilded Triggerfish (Male)', 'Xanthichthys auromarginatus', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- Wrasses & Parrotfish (56 cards)
INSERT INTO fish_cards
  (id, family_id, common_name_en, scientific_name, is_visible, created_at)
VALUES
  ('fish-f230b56594', 'fam-wrasses-parrotfish', 'Yellow Tail Tamarin Wrasse', 'Anampses meleagrides', true, '2026-05-20T20:20:51.508Z'),
  ('fish-23ff2e58df', 'fam-wrasses-parrotfish', 'Twospot Hogfish', 'Bodianus bimaculatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-837ab33fe1', 'fam-wrasses-parrotfish', 'Diana''s Hogfish', 'Bodianus diana', true, '2026-05-20T20:20:51.508Z'),
  ('fish-475371e802', 'fam-wrasses-parrotfish', 'Eclipse Hogfish', 'Bodianus mesothorax', true, '2026-05-20T20:20:51.508Z'),
  ('fish-d41195fc1c', 'fam-wrasses-parrotfish', 'Bicolor Parrotfish', 'Bolbometopon bicolor', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2b43c29650', 'fam-wrasses-parrotfish', 'Banded Maori Wrasse', 'Cheilinus fasciatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b9fe36b53c', 'fam-wrasses-parrotfish', 'Yellow Cheek Tuskfish', 'Choerodon anchorago', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2a50484ebc', 'fam-wrasses-parrotfish', 'Blue-Sided Fairy Wrasse', 'Cirrhilabrus cyanopleura', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ff8a9f3094', 'fam-wrasses-parrotfish', 'Exquisite Fairy Wrasse', 'Cirrhilabrus exquisitus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-daa1cb8376', 'fam-wrasses-parrotfish', 'Black Tail Filament Fairy Wrasse', 'Cirrhilabrus filamentosus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-5e2ff0f015', 'fam-wrasses-parrotfish', 'Yellow Fin Fairy Wrasse (Female)', 'Cirrhilabrus flavidorsalis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-dc611ca9af', 'fam-wrasses-parrotfish', 'Lubbok''s Fairy Wrasse (Female)', 'Cirrhilabrus lubbocki', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f59ee8129d', 'fam-wrasses-parrotfish', 'Naoko''s Fairy Wrasse (Female)', 'Cirrhilabrus naokoae', true, '2026-05-20T20:20:51.508Z'),
  ('fish-777e7fb58c', 'fam-wrasses-parrotfish', 'Naoko''s Fairy Wrasse (Male)', 'Cirrhilabrus naokoae', true, '2026-05-20T20:20:51.508Z'),
  ('fish-5d0dc27c92', 'fam-wrasses-parrotfish', 'Red Eye Fairy Wrasse', 'Cirrhilabrus solorensis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-566c64f368', 'fam-wrasses-parrotfish', 'Blue Stripe Fairy Wrasse', 'Cirrhilabrus temminckii', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f30055ed6e', 'fam-wrasses-parrotfish', 'Tono'' Wrasse (Female)', 'Cirrhilabrus tonozukai', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1abd95c235', 'fam-wrasses-parrotfish', 'Tono'' Wrasse (Male)', 'Cirrhilabrus tonozukai', true, '2026-05-20T20:20:51.508Z'),
  ('fish-a0c3e7a7c7', 'fam-wrasses-parrotfish', 'Red Finned Fairy Wrasse', 'Cirrhilabrus adornatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-51d6a04666', 'fam-wrasses-parrotfish', 'Orange Back Fairy Wrasse', 'Cirrhilabrus aurantidorsalis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-cb9d3fad01', 'fam-wrasses-parrotfish', 'Rose-Brand Fairy Wrasse', 'Cirrhilabrus roseafascia', true, '2026-05-20T20:20:51.508Z'),
  ('fish-4da15a4aac', 'fam-wrasses-parrotfish', 'Gaimard Rainbow Wrasse (Yellow Tail)', 'Coris gaimard', true, '2026-05-20T20:20:51.508Z'),
  ('fish-566a10955c', 'fam-wrasses-parrotfish', 'Gaimard Rainbow Wrasse', 'Coris gaimard', true, '2026-05-20T20:20:51.508Z'),
  ('fish-809782be6d', 'fam-wrasses-parrotfish', 'Yellow Tail Tubelip Wrasse', 'Diproctacanthus xanthurus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-02e91b7d1a', 'fam-wrasses-parrotfish', 'Slingjaw Wrasse', 'Epibulus insidiator', true, '2026-05-20T20:20:51.508Z'),
  ('fish-440ed331b0', 'fam-wrasses-parrotfish', 'Blue/Green Birdfish (Male)', 'Gomphosus coeruleus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-55f4a6eb14', 'fam-wrasses-parrotfish', 'Brown Birdfish (Female)', 'Gomphosus varius', true, '2026-05-20T20:20:51.508Z'),
  ('fish-279f8a525f', 'fam-wrasses-parrotfish', 'Argus Rainbow Wrasse', 'Halichoeres argus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2d424a1e38', 'fam-wrasses-parrotfish', 'Green Rainbow Wrasse', 'Halichoeres chloropterus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ae566e7940', 'fam-wrasses-parrotfish', 'Yellow Rainbow Wrasse', 'Halichoeres chrysus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-580f86df4a', 'fam-wrasses-parrotfish', 'Checkerboard Rainbow Wrasse', 'Halichoeres hortulanus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-42183e4b49', 'fam-wrasses-parrotfish', 'Dusky Rainbow Wrasse', 'Halichoeres marginatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-e4b0c08fb0', 'fam-wrasses-parrotfish', 'Orange Tipped Rainbow Wrasse', 'Halichoeres melanurus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c775641328', 'fam-wrasses-parrotfish', 'Purple Headed Rainbow Wrasse', 'Halichoeres prosopeion', true, '2026-05-20T20:20:51.508Z'),
  ('fish-4ee8283843', 'fam-wrasses-parrotfish', 'Red Headed Rainbow Wrasse', 'Halichoeres rubricephalus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-1dd1117e3e', 'fam-wrasses-parrotfish', 'Golden Rainbow Fish', 'Halichoeres trispilus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2196ab6d3e', 'fam-wrasses-parrotfish', 'Barred Thicklip Wrasse (Adult)', 'Hemigymnus fasciatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-c6803042d9', 'fam-wrasses-parrotfish', 'Half And Half Thicklip Wrasse', 'Hemigymnus melapterus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-fcc78bf44e', 'fam-wrasses-parrotfish', 'Bicolor Cleaner Wrasse (Juv)', 'Labroides bicolor', true, '2026-05-20T20:20:51.508Z'),
  ('fish-3bce70450e', 'fam-wrasses-parrotfish', 'Bluestreak Cleaner Wrasse', 'Labroides dimidiatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-04fbf046a9', 'fam-wrasses-parrotfish', 'False Bluesteak Wrasse', 'Labroides pectoralis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-4955c5853d', 'fam-wrasses-parrotfish', 'Black Leopard Wrasse', 'Macropharyngodon negrosensis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-f9f1f3d5e5', 'fam-wrasses-parrotfish', 'Ornate Leopard Wrasse', 'Macropharyngodon ornatus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-62eed2b147', 'fam-wrasses-parrotfish', 'Dragon Wrasse', 'Novaculichthys taeniourus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-488662bdf4', 'fam-wrasses-parrotfish', 'Carpenter''s Flasher Wrasse (Female)', 'Paracheilinus carpenteri', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b0074c9029', 'fam-wrasses-parrotfish', 'Common Flasher Wrasse (Female)', 'Paracheilinus filamentosus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-dcae73ced0', 'fam-wrasses-parrotfish', 'Pink Streaked Wrasse', 'Pseudocheilinops ataenia', true, '2026-05-20T20:20:51.508Z'),
  ('fish-b2cdc7f627', 'fam-wrasses-parrotfish', 'Disappearing Wrasse', 'Pseudocheilinus evanidus', true, '2026-05-20T20:20:51.508Z'),
  ('fish-ed0ea0dd6f', 'fam-wrasses-parrotfish', 'Sixlined Wrasse', 'Pseudocheilinus hexataenia', true, '2026-05-20T20:20:51.508Z'),
  ('fish-fc992ac81a', 'fam-wrasses-parrotfish', 'Dusky Parrotfish', 'Scarus niger', true, '2026-05-20T20:20:51.508Z'),
  ('fish-9367af443e', 'fam-wrasses-parrotfish', 'Quoi''s Parrotfish', 'Scarus quoyi', true, '2026-05-20T20:20:51.508Z'),
  ('fish-261c8931ac', 'fam-wrasses-parrotfish', 'Red Spot Ribbon Wrasse (Female)', 'Stethojulis bandanensis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-71b732b262', 'fam-wrasses-parrotfish', 'Red Spot Ribbon Wrasse (Male)', 'Stethojulis bandanensis', true, '2026-05-20T20:20:51.508Z'),
  ('fish-0a5631dd07', 'fam-wrasses-parrotfish', 'Cut Ribbon Wrasse (Female)', 'Stethojulis interrupta', true, '2026-05-20T20:20:51.508Z'),
  ('fish-a5e034efa7', 'fam-wrasses-parrotfish', 'Blue Ribbon Wrasse (Female)', 'Stethojulis trilineata', true, '2026-05-20T20:20:51.508Z'),
  ('fish-2bd627a5d5', 'fam-wrasses-parrotfish', 'Blue Ribbon Wrasse (Male)', 'Stethojulis trilineata', true, '2026-05-20T20:20:51.508Z')
ON CONFLICT (id) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════════
-- Done.  Expected result: 33 families + 467 fish cards inserted.
-- ═══════════════════════════════════════════════════════════════════════
