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

