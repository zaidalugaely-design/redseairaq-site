-- ═══════════════════════════════════════════════════════════════════════
-- Phase 1 — File A/2: Fish cards (238 cards)
-- Families: Anemonefish & Clownfish → Gobies
-- Run AFTER phase1-p1.sql
-- Safe to re-run (ON CONFLICT DO NOTHING)
-- ═══════════════════════════════════════════════════════════════════════



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


-- ═══════════════════════════════════════════════════════════════════════
-- Phase 1 Part 3/5 — Butterflyfish → Gobies
-- ═══════════════════════════════════════════════════════════════════════

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
