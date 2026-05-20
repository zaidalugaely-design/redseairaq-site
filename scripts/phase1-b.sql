-- ═══════════════════════════════════════════════════════════════════════
-- Phase 1 — File B/2: Fish cards (229 cards)
-- Families: Groupers → Wrasses & Parrotfish
-- Run AFTER File A
-- Safe to re-run (ON CONFLICT DO NOTHING)
-- ═══════════════════════════════════════════════════════════════════════

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


-- ═══════════════════════════════════════════════════════════════════════
-- Phase 1 Part 5/5 — Snappers → Wrasses & Parrotfish (run last)
-- ═══════════════════════════════════════════════════════════════════════

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

