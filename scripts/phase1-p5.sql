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

