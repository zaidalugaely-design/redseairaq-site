-- ═══════════════════════════════════════════════════════════════════════
-- Phase 1 Part 4/5 — Groupers → Seahorses
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

