#!/usr/bin/env node
// ─────────────────────────────────────────────────────────────────────────────
// PHASE 1 — Import fish families & cards into Supabase
//
// Usage:
//   export SB_SERVICE_KEY=eyJhbGci...   # service_role key from Supabase Dashboard
//   node scripts/phase1-import.js
//
// What it does:
//   1. Checks that fish_cards.is_visible column exists (prints ALTER TABLE if not)
//   2. Upserts each family into fish_families (name_en, name_ar='', name_ku='')
//   3. Upserts each card into fish_cards with scientific_name + common_name_en;
//      care_level / diet / reef_safe / image_url left NULL for Phase 2
//   4. Skips rows that already exist (idempotent — safe to re-run)
//
// Requires Node 18+ (built-in fetch). No npm install needed.
// ─────────────────────────────────────────────────────────────────────────────
'use strict';

const crypto = require('crypto');

// ── Environment ──────────────────────────────────────────────────────────────

const SB_URL = process.env.SUPABASE_URL || 'https://glhmmrovxyijtzjaldtf.supabase.co';
const SB_SERVICE_KEY = process.env.SB_SERVICE_KEY;

if (!SB_SERVICE_KEY) {
  console.error('\n❌  SB_SERVICE_KEY is required.');
  console.error('    Get it from: Supabase Dashboard → Project Settings → API → service_role secret');
  console.error('    Then run:  export SB_SERVICE_KEY=eyJhbGci...');
  process.exit(1);
}

// ── Supabase REST helpers ─────────────────────────────────────────────────────
// Same pattern as netlify/functions/api.js sb() function.

async function sbPost(path, body) {
  const res = await fetch(`${SB_URL}/rest/v1${path}`, {
    method: 'POST',
    headers: {
      'apikey':        SB_SERVICE_KEY,
      'Authorization': `Bearer ${SB_SERVICE_KEY}`,
      'Content-Type':  'application/json',
      'Prefer':        'resolution=merge-duplicates,return=minimal',
    },
    body: JSON.stringify(body),
  });
  if (!res.ok) {
    const err = await res.json().catch(() => ({}));
    throw new Error(err?.message || err?.hint || `Supabase ${res.status}: ${JSON.stringify(err)}`);
  }
}

async function sbSelect(path) {
  const res = await fetch(`${SB_URL}/rest/v1${path}`, {
    headers: {
      'apikey':        SB_SERVICE_KEY,
      'Authorization': `Bearer ${SB_SERVICE_KEY}`,
    },
  });
  if (!res.ok) {
    const err = await res.json().catch(() => ({}));
    throw Object.assign(new Error(err?.message || `Supabase ${res.status}`), { supabaseErr: err });
  }
  return res.json();
}

// ── ID helpers ───────────────────────────────────────────────────────────────

function toSlug(str) {
  return str.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '');
}

// Deterministic family ID — re-running always produces the same ID.
function makeFamilyId(familyName) {
  return 'fam-' + toSlug(familyName).slice(0, 38);
}

// Deterministic card ID — based on family + common_name (handles variants like Adult/Juv).
function makeCardId(familySlug, commonName) {
  const hash = crypto.createHash('md5')
    .update(familySlug + '|' + commonName.toLowerCase())
    .digest('hex')
    .slice(0, 10);
  return `fish-${hash}`;
}

// ── is_visible column check ───────────────────────────────────────────────────

async function ensureIsVisibleColumn() {
  try {
    await sbSelect('/fish_cards?select=is_visible&limit=0');
    console.log('✓  fish_cards.is_visible column exists\n');
  } catch (e) {
    const msg = e.supabaseErr?.message || e.message || '';
    if (msg.includes('is_visible') || msg.includes('column')) {
      console.log('\n┌─────────────────────────────────────────────────────────┐');
      console.log('│  ⚠️   MIGRATION REQUIRED before continuing               │');
      console.log('└─────────────────────────────────────────────────────────┘');
      console.log('\nRun this SQL in Supabase Dashboard → SQL Editor:\n');
      console.log('  ALTER TABLE fish_cards');
      console.log('    ADD COLUMN IF NOT EXISTS is_visible boolean NOT NULL DEFAULT true;\n');
      console.log('Then re-run this script.\n');
      process.exit(1);
    }
    // Unknown error — surface it
    throw e;
  }
}

// ── JSON Data ─────────────────────────────────────────────────────────────────
// 33 families, 470 cards (last family truncated in source — see TODO below).

const DATA = [
  {
    "family": "Anemonefish & Clownfish",
    "cards": [
      {"common_name": "Skunk Striped Fish",                    "scientific_name": "Amphiprion akallopisos"},
      {"common_name": "Clarck's Fish (Pacific)",               "scientific_name": "Amphiprion clarkii"},
      {"common_name": "Clarck's Fish (Ocean)",                 "scientific_name": "Amphiprion clarkii"},
      {"common_name": "Red Sadleback Fish",                    "scientific_name": "Amphiprion ephippium"},
      {"common_name": "Red Dusky Fish",                        "scientific_name": "Amphiprion melanopus"},
      {"common_name": "Clown Fish",                            "scientific_name": "Amphiprion ocellaris"},
      {"common_name": "Black Storm Clown Fish",                "scientific_name": "Amphiprion ocellaris"},
      {"common_name": "Gold Nugget Clown Fish",                "scientific_name": "Amphiprion ocellaris"},
      {"common_name": "Lighting Maroon Clown Fish",            "scientific_name": "Amphiprion ocellaris"},
      {"common_name": "Polkadot Maroon Clown Fish",            "scientific_name": "Amphiprion ocellaris"},
      {"common_name": "Premium Lighting Maroon Clown Fish",    "scientific_name": "Amphiprion ocellaris"},
      {"common_name": "Percula Clown Fish",                    "scientific_name": "Amphiprion percula"},
      {"common_name": "Pink Skunk Striped Fish",               "scientific_name": "Amphiprion perideraion"},
      {"common_name": "Saddle Back Fish",                      "scientific_name": "Amphiprion polymnus"},
      {"common_name": "Orange Fish",                           "scientific_name": "Amphiprion sandaracinos"},
      {"common_name": "Seba's Fish",                           "scientific_name": "Amphiprion sebae"},
      {"common_name": "Black Ice Clown Fish",                  "scientific_name": "Amphiprion ocellaris"},
      {"common_name": "Onyx Clown Fish",                       "scientific_name": "Amphiprion ocellaris"},
      {"common_name": "Black Poton Clown Fish",                "scientific_name": "Amphiprion ocellaris"},
      {"common_name": "Frosbite Clown Fish",                   "scientific_name": "Amphiprion ocellaris"},
      {"common_name": "Half Black Clown Fish",                 "scientific_name": "Amphiprion ocellaris"},
      {"common_name": "Picasso Clown Fish",                    "scientific_name": "Amphiprion ocellaris"},
      {"common_name": "Platinum Clown Fish",                   "scientific_name": "Amphiprion ocellaris"},
      {"common_name": "Premium Ligthing Maroon Clown Fish",    "scientific_name": "Amphiprion ocellaris"},
      {"common_name": "Snowflake Clown Fish",                  "scientific_name": "Amphiprion ocellaris"},
      {"common_name": "Orange Fish (Breeding)",                "scientific_name": "Amphiprion sandaracinos"},
      {"common_name": "Spinecheek Fish",                       "scientific_name": "Premnas biaculeatus"},
      {"common_name": "Goldstripe Maroon Fish",                "scientific_name": "Premnas epigramma"}
    ]
  },
  {
    "family": "Angelfish",
    "cards": [
      {"common_name": "Three spot Angelfish",                  "scientific_name": "Apolemichthys trimaculatus"},
      {"common_name": "Golden Angelfish",                      "scientific_name": "Centropyge aurantius"},
      {"common_name": "Bicolor Angelfish",                     "scientific_name": "Centropyge bicolor"},
      {"common_name": "Coral Beauty Angelfish",                "scientific_name": "Centropyge bispinosus"},
      {"common_name": "Eibl's Angelfish",                      "scientific_name": "Centropyge eiblii"},
      {"common_name": "White Tail Angelfish",                  "scientific_name": "Centropyge flavicauda"},
      {"common_name": "Banded Pygmy Angelfish",                "scientific_name": "Centropyge multifasciatus"},
      {"common_name": "Midnight Angelfish",                    "scientific_name": "Centropyge nox"},
      {"common_name": "Keyhole Angelfish",                     "scientific_name": "Centropyge tibicen"},
      {"common_name": "Pearl-scaled Angelfish",                "scientific_name": "Centropyge vroliki"},
      {"common_name": "Black Velvet Angelfish",                "scientific_name": "Chaetodontoplus melanosoma"},
      {"common_name": "Yellow Tail Vermiculated Angelfish",    "scientific_name": "Chaetodontoplus mesoleucus"},
      {"common_name": "Belus Swallowtail Angelfish (Female)",  "scientific_name": "Genicanthus bellus"},
      {"common_name": "Belus Swallowtail Angelfish (Male)",    "scientific_name": "Genicanthus bellus"},
      {"common_name": "Red Sea Swallowtail Angelfish (Female)","scientific_name": "Genicanthus caudovittatus"},
      {"common_name": "Red Sea Swallowtail Angelfish (Male)",  "scientific_name": "Genicanthus caudovittatus"},
      {"common_name": "Lamarck Swallowtail Angelfish (Female)","scientific_name": "Genicanthus lamarcki"},
      {"common_name": "Black Spot Lyretail Angelfish (Female)","scientific_name": "Genicanthus melanotilus"},
      {"common_name": "Black Spot Lyretail Angelfish (Male)",  "scientific_name": "Genicanthus melanotilus"},
      {"common_name": "Blue Ring Angelfish (Adult)",           "scientific_name": "Pomacanthus annularis"},
      {"common_name": "Blue Ring Angelfish (Juv)",             "scientific_name": "Pomacanthus annularis"},
      {"common_name": "Emperor Angelfish (Adult)",             "scientific_name": "Pomacanthus imperator"},
      {"common_name": "Emperor Angelfish (Juv)",               "scientific_name": "Pomacanthus imperator"},
      {"common_name": "Blue Girdled Angelfish (Adult)",        "scientific_name": "Pomacanthus navarchus"},
      {"common_name": "Blue Girdled Angelfish (Juv)",          "scientific_name": "Pomacanthus navarchus"},
      {"common_name": "Koran Angelfish (Adult)",               "scientific_name": "Pomacanthus semicirculatus"},
      {"common_name": "Koran Angelfish (Juv)",                 "scientific_name": "Pomacanthus semicirculatus"},
      {"common_name": "Six Barred Angelfish (Adult)",          "scientific_name": "Pomacanthus sextriatus"},
      {"common_name": "Yellow Face Angelfish (Adult)",         "scientific_name": "Pomacanthus xanthometapon"},
      {"common_name": "Yellow Face Angelfish (Juv)",           "scientific_name": "Pomacanthus xanthometapon"},
      {"common_name": "Six Barred Angelfish (Juv)",            "scientific_name": "Pomacanthus sexstriatus"},
      {"common_name": "Regal Angelfish",                       "scientific_name": "Pygoplites diacanthus"},
      {"common_name": "Indian Regal Angelfish",                "scientific_name": "Pygoplites diacanthus"}
    ]
  },
  {
    "family": "Anthias & Basslets",
    "cards": [
      {"common_name": "Gold Blotch Seaperch Anthias",          "scientific_name": "Odontanthias borbonius"},
      {"common_name": "Yellow Backed Anthias",                 "scientific_name": "Pseudanthias bicolor"},
      {"common_name": "Twinspot Anthias",                      "scientific_name": "Pseudanthias bimaculatus"},
      {"common_name": "Peach Anthias",                         "scientific_name": "Pseudanthias dispar"},
      {"common_name": "Red Striped Anthias (Female)",          "scientific_name": "Pseudanthias fasciatus"},
      {"common_name": "Red Striped Anthias (Male)",            "scientific_name": "Pseudanthias fasciatus"},
      {"common_name": "Saddleback Anthias",                    "scientific_name": "Pseudanthias flavoguttattus"},
      {"common_name": "Green Anthias",                         "scientific_name": "Pseudanthias hutchi"},
      {"common_name": "Sunset Anthias",                        "scientific_name": "Pseudanthias parvirostris"},
      {"common_name": "Randal's Anthias",                      "scientific_name": "Pseudanthias randalli"},
      {"common_name": "Indonesia Lyretail Anthias (Female)",   "scientific_name": "Pseudanthias squamipinnis"},
      {"common_name": "Indian Lyretail Anthias (Female)",      "scientific_name": "Pseudanthias squamipinnis"},
      {"common_name": "Indian Lyretail Anthias (Male)",        "scientific_name": "Pseudanthias squamipinnis"},
      {"common_name": "Purple Queen Anthias (Female)",         "scientific_name": "Pseudanthias tuka"},
      {"common_name": "Purple Queen Anthias (Male)",           "scientific_name": "Pseudanthias tuka"},
      {"common_name": "Square Spot Anthias (Female)",          "scientific_name": "Pseudanthias pleurotaenia"},
      {"common_name": "Square Spot Anthias (Male)",            "scientific_name": "Pseudanthias pleurotaenia"}
    ]
  },
  {
    "family": "Batfish",
    "cards": [
      {"common_name": "Orbiculate Batfish",                    "scientific_name": "Platax orbicularis"},
      {"common_name": "Longfinned Batfish",                    "scientific_name": "Platax pinnatus"},
      {"common_name": "Round Faced Batfish",                   "scientific_name": "Platax teira"}
    ]
  },
  {
    "family": "Blennies",
    "cards": [
      {"common_name": "Red Strip Goby",                        "scientific_name": "Amblygobius rainfordi"},
      {"common_name": "Black Algae Blenny",                    "scientific_name": "Atrosalarias fuscus"},
      {"common_name": "Two Colored Blenny",                    "scientific_name": "Ecsenius bicolor"},
      {"common_name": "Leopard Blenny",                        "scientific_name": "Exallias brevis"},
      {"common_name": "Rock Skipper Blenny",                   "scientific_name": "Istiblenius sp"},
      {"common_name": "Poison One Striped Fang Blenny",        "scientific_name": "Meiacanthus smithii"},
      {"common_name": "Grammistes Blenny",                     "scientific_name": "Meiacanthus grammistes"},
      {"common_name": "Weever Blenny",                         "scientific_name": "Parapercis sp"},
      {"common_name": "Mimic Fang Blenny",                     "scientific_name": "Plagiotremus rhinorhynchos"},
      {"common_name": "Jewelled Rock Blenny",                  "scientific_name": "Salarias fasciatus"},
      {"common_name": "Ocellated Dragonet",                    "scientific_name": "Synchiropus ocellatus"},
      {"common_name": "Psychedelic Dragonet",                  "scientific_name": "Synchiropus picturatus"},
      {"common_name": "Indonesia Mandarin Dragonet",           "scientific_name": "Synchiropus splendidus"},
      {"common_name": "Indonesia Mandarin Dragonet (Orange)",  "scientific_name": "Synchiropus splendidus"},
      {"common_name": "Red Starry Dragonet",                   "scientific_name": "Synchiropus stellatus"}
    ]
  },
  {
    "family": "Butterflyfish",
    "cards": [
      {"common_name": "Panda Butterflyfish",                   "scientific_name": "Chaetodon adiergastos"},
      {"common_name": "Threadfin Butterflyfish",               "scientific_name": "Chaetodon auriga"},
      {"common_name": "Bennet's Butterflyfish",                "scientific_name": "Chaetodon benneti"},
      {"common_name": "Burgess's Butterflyfish",               "scientific_name": "Chaetodon burgessi"},
      {"common_name": "Speckled Butterflyfish",                "scientific_name": "Chaetodon citrinellus"},
      {"common_name": "Red Tailed Butterflyfish",              "scientific_name": "Chaetodon collare"},
      {"common_name": "Black Finned Butterflyfish",            "scientific_name": "Chaetodon decussatus"},
      {"common_name": "Saddleback Butterflyfish",              "scientific_name": "Chaetodon ephippium"},
      {"common_name": "Indian Saddleback Butterflyfish",       "scientific_name": "Chaetodon falcula"},
      {"common_name": "Peppered Blue Butterflyfish",           "scientific_name": "Chaetodon guttatissimus"},
      {"common_name": "Klein's Butterflyfish",                 "scientific_name": "Chaetodon kleini"},
      {"common_name": "Lined Butterflyfish",                   "scientific_name": "Chaetodon lineolatus"},
      {"common_name": "Raccoon Butterflyfish",                 "scientific_name": "Chaetodon lunula"},
      {"common_name": "Pacific Pinstriped Butterflyfish",      "scientific_name": "Chaetodon lunulatus"},
      {"common_name": "Black Back Butterflyfish",              "scientific_name": "Chaetodon melannotus"},
      {"common_name": "Merten's Butterflyfish",                "scientific_name": "Chaetodon mertensii"},
      {"common_name": "Meyer's Butterflyfish",                 "scientific_name": "Chaetodon meyeri"},
      {"common_name": "Eight Striped Butterflyfish",           "scientific_name": "Chaetodon octofasciatus"},
      {"common_name": "Ornate's Butterflyfish",                "scientific_name": "Chaetodon ornatissimus"},
      {"common_name": "Spot Banded Butterflyfish",             "scientific_name": "Chaetodon punctatofasciatus"},
      {"common_name": "Raffle's Butterflyfish",                "scientific_name": "Chaetodon rafflesi"},
      {"common_name": "Decorated Butterflyfish",               "scientific_name": "Chaetodon semeion"},
      {"common_name": "Oval Spot Butterflyfish",               "scientific_name": "Chaetodon speculum"},
      {"common_name": "Triangle Butterflyfish",                "scientific_name": "Chaetodon triangulum"},
      {"common_name": "Chevron Butterflyfish",                 "scientific_name": "Chaetodon trifascialis"},
      {"common_name": "Pacific Saddleback Butterflyfish",      "scientific_name": "Chaetodon ulietensis"},
      {"common_name": "Pacific Teardrop Butterflyfish",        "scientific_name": "Chaetodon unimaculatus"},
      {"common_name": "Vagabond's Butterflyfish",              "scientific_name": "Chaetodon vagabundus"},
      {"common_name": "Philippine Chevron Butterflyfish",      "scientific_name": "Chaetodon xanthurus"},
      {"common_name": "Copperband Butterflyfish",              "scientific_name": "Chelmon rostratus"},
      {"common_name": "High Fin Coralfish",                    "scientific_name": "Coradion altivelis"},
      {"common_name": "Yellow Long Nose Butterflyfish",        "scientific_name": "Forcipiger flavissimus"},
      {"common_name": "Sky Butterflyfish",                     "scientific_name": "Hemitaurichthys polylepis"},
      {"common_name": "Brown & White Butterflyfish",           "scientific_name": "Hemitaurichthys zoster"},
      {"common_name": "Longfin Bannerfish",                    "scientific_name": "Heniochus acuminatus"},
      {"common_name": "Threeband Pennant Bannerfish",          "scientific_name": "Heniochus chrysostomus"},
      {"common_name": "Singular Bannerfish",                   "scientific_name": "Heniochus singularis"},
      {"common_name": "Humphead Bannerfish",                   "scientific_name": "Heniochus varius"}
    ]
  },
  {
    "family": "Cardinalfish",
    "cards": [
      {"common_name": "Gold Striped Cardinalfish",             "scientific_name": "Apogon cyanosoma"},
      {"common_name": "Blue Streak Cardinalfish",              "scientific_name": "Apogon liptacanthus"},
      {"common_name": "Banggai Cardinalfish",                  "scientific_name": "Pterapogon kauderni"},
      {"common_name": "Pajama Cardinalfish",                   "scientific_name": "Sphaeramia nematoptera"},
      {"common_name": "Orbicular Cardinalfish",                "scientific_name": "Sphaeramia orbicularis"}
    ]
  },
  {
    "family": "Damselfish",
    "cards": [
      {"common_name": "Stripe Tail Sergeant Damsel",           "scientific_name": "Abudefduf sexfasciatus"},
      {"common_name": "Indopacific Sergeant Damsel",           "scientific_name": "Abudefduf vaigiensis"},
      {"common_name": "Staghorn Damsel",                       "scientific_name": "Amblyglyphidodon kuracao"},
      {"common_name": "Golden Damsel",                         "scientific_name": "Amblyglyphidodon aureus"},
      {"common_name": "Bicolor Chromis",                       "scientific_name": "Chromis margaritifer"},
      {"common_name": "Black-bar Chromis",                     "scientific_name": "Chromis retrofasciata"},
      {"common_name": "Blue Green Chromis",                    "scientific_name": "Chromis viridis"},
      {"common_name": "Surge Damselfish",                      "scientific_name": "Chrysiptera brownriggii"},
      {"common_name": "Blue Devil Demoiselle (Female)",        "scientific_name": "Chrysiptera cyanea"},
      {"common_name": "Blue Devil Demoiselle Orange Tailed",   "scientific_name": "Chrysiptera cyanea"},
      {"common_name": "Azure Demoiselle",                      "scientific_name": "Chrysiptera hemicyanea"},
      {"common_name": "Yellow Tail Demoiselle",                "scientific_name": "Chrysiptera parasema"},
      {"common_name": "Springer's Demoiselle",                 "scientific_name": "Chrysiptera springeri"},
      {"common_name": "Talbot's Demoiselle",                   "scientific_name": "Chrysiptera talboti"},
      {"common_name": "Gold Tail Demoiselle",                  "scientific_name": "Chrysiptera parasema"},
      {"common_name": "White Tailed Damsel",                   "scientific_name": "Dascyllus aruanus"},
      {"common_name": "Blacktail Humbug",                      "scientific_name": "Dascyllus melanurus"},
      {"common_name": "Three Spot Damsel",                     "scientific_name": "Dascyllus trimaculatus"},
      {"common_name": "Reticulated Dascyllus",                 "scientific_name": "Dascyllus reticulatus"},
      {"common_name": "White Damsel",                          "scientific_name": "Dischistodus perspicillatus"},
      {"common_name": "Cross's Damselfish",                    "scientific_name": "Neoglyphidodon crossi"},
      {"common_name": "Coral Demoiselle",                      "scientific_name": "Neopomacentrus nemurus"},
      {"common_name": "Jewel Damsel",                          "scientific_name": "Plectroglyphidodon lacrymatus"},
      {"common_name": "Yellow Backed Damsel",                  "scientific_name": "Paraglyphidodon melas"},
      {"common_name": "Black-mouth Damsel",                    "scientific_name": "Paraglyphidodon nigroris"},
      {"common_name": "Blue Streak Damsel",                    "scientific_name": "Paraglyphidodon oxyodon"},
      {"common_name": "Black Barred Damsel",                   "scientific_name": "Plectroglyphidodon dickii"},
      {"common_name": "Allen's Damsel",                        "scientific_name": "Pomacentrus alleni"},
      {"common_name": "Speckled Damsel",                       "scientific_name": "Pomacentrus bankanensis"},
      {"common_name": "Blue Stripe Damsel",                    "scientific_name": "Pomacentrus caeruleus"},
      {"common_name": "Blue Damsel Fish",                      "scientific_name": "Pomacentrus coelestis"},
      {"common_name": "Molucca Damsel",                        "scientific_name": "Pomacentrus moluccensis"}
    ]
  },
  {
    "family": "Dottybacks",
    "cards": [
      {"common_name": "Dusky Brotulid Dottyback",              "scientific_name": "Brotulina fusca"},
      {"common_name": "Marine Betta Comet",                    "scientific_name": "Calloplesiops altivelis"},
      {"common_name": "Giant Dottyback",                       "scientific_name": "Labracinus cyclophthalmus"},
      {"common_name": "Golden Dottyback",                      "scientific_name": "Pseudochromis aureus"},
      {"common_name": "Blue Stripped Dottyback (Female)",      "scientific_name": "Pseudochromis cyanotaenia"},
      {"common_name": "Blue Stripped Dottyback (Male)",        "scientific_name": "Pseudochromis cyanotaenia"},
      {"common_name": "Royal Dottyback",                       "scientific_name": "Pseudochromis paccagnellae"},
      {"common_name": "Strawberry Dottyback",                  "scientific_name": "Pseudochromis porphyreus"}
    ]
  },
  {
    "family": "Eels",
    "cards": [
      {"common_name": "Snowflake Moray Eel",                   "scientific_name": "Echidna nebulosa"},
      {"common_name": "Yellow Spotted Moray",                  "scientific_name": "Echidna xanthospilos"},
      {"common_name": "Splendid Garden Eel",                   "scientific_name": "Gorgasia preclara"},
      {"common_name": "Zebra Moray Eel",                       "scientific_name": "Gymnomuraena zebra"},
      {"common_name": "Honeycomb Moray Eel",                   "scientific_name": "Gymnothorax favagineus"},
      {"common_name": "Giant Moray Eel",                       "scientific_name": "Gymnothorax javanicus"},
      {"common_name": "Spotted Garden Eel",                    "scientific_name": "Heteroconger hassi"},
      {"common_name": "Coloured Moray Eel",                    "scientific_name": "Muraena sp"},
      {"common_name": "White Ribbon Eel",                      "scientific_name": "Pseudechidna brummeri"},
      {"common_name": "Blue Ribbon Eel (Male)",                "scientific_name": "Rhinomuraena quaesita"},
      {"common_name": "Black Ribbon Eel (Juv)",                "scientific_name": "Rhinomuraena quaesita"}
    ]
  },
  {
    "family": "Filefish",
    "cards": [
      {"common_name": "Sea Grass Filefish",                    "scientific_name": "Acreichthys tomentosus"},
      {"common_name": "Scribbled Filefish",                    "scientific_name": "Aluterus scriptus"},
      {"common_name": "Prickly Leather Filefish",              "scientific_name": "Chaetodermis peniciligerus"},
      {"common_name": "Harlequin Filefish",                    "scientific_name": "Oxymonacanthus longirostris"},
      {"common_name": "Orange Tail Filefish",                  "scientific_name": "Pervagor aspricaudus"},
      {"common_name": "Redtailed Filefish",                    "scientific_name": "Pervagor melanocephalus"}
    ]
  },
  {
    "family": "Frogfish",
    "cards": [
      {"common_name": "Scarlet Frogfish",                      "scientific_name": "Antennarius coccineus"},
      {"common_name": "Common Giant Frogfish",                 "scientific_name": "Antennarius commerson"},
      {"common_name": "Black Giant Frogfish",                  "scientific_name": "Antennarius commerson"},
      {"common_name": "Orange Giant Frogfish",                 "scientific_name": "Antennarius commerson"},
      {"common_name": "Coloured Giant Frogfish",               "scientific_name": "Antennarius commerson"},
      {"common_name": "Painted Frogfish",                      "scientific_name": "Antennarius pictus"},
      {"common_name": "Painted Frogfish (Black)",              "scientific_name": "Antennarius pictus"},
      {"common_name": "Painted Frogfish (Yellow)",             "scientific_name": "Antennarius pictus"},
      {"common_name": "Painted Frogfish (Red)",                "scientific_name": "Antennarius pictus"},
      {"common_name": "Painted Frogfish (Coloured)",           "scientific_name": "Antennarius pictus"},
      {"common_name": "Rare Warty Frogfish",                   "scientific_name": "Antennarius maculatus"},
      {"common_name": "Oriental Flying Gurnard",               "scientific_name": "Dactyloptena orientalis"},
      {"common_name": "Sargassum Frogfish",                    "scientific_name": "Histrio histrio"}
    ]
  },
  {
    "family": "Fusiliers",
    "cards": [
      {"common_name": "Yellow Back Fusilier",                  "scientific_name": "Caesio teres"}
    ]
  },
  {
    "family": "Goatfish",
    "cards": [
      {"common_name": "Yellow Saddle Goatfish",                "scientific_name": "Parupeneus cyclostomus"},
      {"common_name": "Black Striped Goatfish",                "scientific_name": "Parupeneus tragula"}
    ]
  },
  {
    "family": "Gobies",
    "cards": [
      {"common_name": "Pink Bar Prawn Goby",                   "scientific_name": "Amblyeleotris aurora"},
      {"common_name": "Orange Spotted Prawn Goby",             "scientific_name": "Amblyeleotris guttata"},
      {"common_name": "Randall's Prawn Goby",                  "scientific_name": "Amblyeleotris randalli"},
      {"common_name": "Steinitz's Prawn Goby",                 "scientific_name": "Amblyeleotris steinitzi"},
      {"common_name": "Wheeler's Prawn Goby",                  "scientific_name": "Amblyeleotris wheeleri"},
      {"common_name": "Banded Goby",                           "scientific_name": "Amblygobius phalaena"},
      {"common_name": "Yellow Watchman Prawn Goby",            "scientific_name": "Cryptocentrus cinctus"},
      {"common_name": "Pink & Blue Spotted Prawn Goby",        "scientific_name": "Cryptocentrus leptocephalus"},
      {"common_name": "Tangaroa Prawn Goby",                   "scientific_name": "Ctenogobiops tangaroai"},
      {"common_name": "Green Spotted Coral Goby",              "scientific_name": "Gobiodon histrio"},
      {"common_name": "Yellow Clown Goby",                     "scientific_name": "Gobiodon okinawae"},
      {"common_name": "Decorated Dart Goby",                   "scientific_name": "Nemateleotris decora"},
      {"common_name": "Fire Fish",                             "scientific_name": "Nemateleotris magnifica"},
      {"common_name": "Blackfin Dart Goby",                    "scientific_name": "Ptereleotris evides"},
      {"common_name": "Spot Tail Dart Goby",                   "scientific_name": "Ptereleotris heteroptera"},
      {"common_name": "Pearly Dart Goby",                      "scientific_name": "Ptereleotris microlepis"},
      {"common_name": "Zebra Dart Goby",                       "scientific_name": "Ptereleotris zebra"},
      {"common_name": "Two Spot Goby",                         "scientific_name": "Signigobius biocellatus"},
      {"common_name": "White Rayed Antenna Prawn Goby",        "scientific_name": "Stonogobiops yasha"},
      {"common_name": "Black Rayed Antenna Prawn Goby",        "scientific_name": "Stonogobiops nematodes"},
      {"common_name": "Two Stripe Sleeper Goby",               "scientific_name": "Valenciennea helsdingenii"},
      {"common_name": "Long Finned Goby",                      "scientific_name": "Valenciennea longipinnis"},
      {"common_name": "Mural Sleeper Goby",                    "scientific_name": "Valenciennea muralis"},
      {"common_name": "Pretty Prawn Goby",                     "scientific_name": "Valenciennea puellaris"},
      {"common_name": "Six Spotted Sleeper Goby",              "scientific_name": "Valenciennea sexguttata"},
      {"common_name": "Golden Head Sleeper Goby",              "scientific_name": "Valenciennea strigata"}
    ]
  },
  {
    "family": "Groupers",
    "cards": [
      {"common_name": "Harlequin Grouper",                     "scientific_name": "Cephalopholis polleni"},
      {"common_name": "Panther Grouper",                       "scientific_name": "Cromileptes altivelis"},
      {"common_name": "Blue & Yellow Grouper",                 "scientific_name": "Epinephelus flavocoeruleus"}
    ]
  },
  {
    "family": "Hawkfish",
    "cards": [
      {"common_name": "Threadfin Hawkfish",                    "scientific_name": "Cirrhitichthys aprinus"},
      {"common_name": "Long Nose Hawkfish",                    "scientific_name": "Oxycirrhites typus"}
    ]
  },
  {
    "family": "Invertebrates",
    "cards": [
      {"common_name": "Fire Anemone",                          "scientific_name": "Actinodendron plumosum"},
      {"common_name": "Randall's Snapping Shrimp",             "scientific_name": "Alpheus randalli"},
      {"common_name": "Flying Sea Hare",                       "scientific_name": "Aplysia sp"},
      {"common_name": "White Sand Shifting Sea Star",          "scientific_name": "Archaster typicus"},
      {"common_name": "Red-White Feather-duster Tube Worm",    "scientific_name": "Bispira sp"},
      {"common_name": "Electric Blue Knuckle Hermit Crab",     "scientific_name": "Calcinus elegans"},
      {"common_name": "Tube Anemone Orange",                   "scientific_name": "Cerianthus membranaceus"},
      {"common_name": "Anna's Chromodoris Nudibranch",         "scientific_name": "Chromodoris annae"},
      {"common_name": "Helmet Urchin",                         "scientific_name": "Colobocentrotus atratus"},
      {"common_name": "Whitespotted Hermit Crab",              "scientific_name": "Dardanus megistos"},
      {"common_name": "Long-spined Sea Urchin",                "scientific_name": "Diadema setosum"},
      {"common_name": "Wedge Sea Hare",                        "scientific_name": "Dolabella auricularia"},
      {"common_name": "Burrowing Sea Urchin",                  "scientific_name": "Echinometra mathaei"},
      {"common_name": "Debelius Reef Lobster",                 "scientific_name": "Enoplometopus debelius"},
      {"common_name": "Corn Anemone Green",                    "scientific_name": "Entacmea quadricolor"},
      {"common_name": "Corn Anemone Red Metallic",             "scientific_name": "Entacmea quadricolor"},
      {"common_name": "Peppermint Sea Star (Assorted)",        "scientific_name": "Fromia monilis"},
      {"common_name": "Bumble Bee Shrimp",                     "scientific_name": "Gnathophyllum americanum"},
      {"common_name": "Sand Anemone Brown",                    "scientific_name": "Heteractis crispa"},
      {"common_name": "Sand Anemone Purple",                   "scientific_name": "Heteractis crispa"},
      {"common_name": "Clown Anemone",                         "scientific_name": "Heteractis magnifica"},
      {"common_name": "Clown Anemone Metallic",                "scientific_name": "Heteractis magnifica"},
      {"common_name": "Clown Anemone Violet Tip",              "scientific_name": "Heteractis magnifica"},
      {"common_name": "Ordinary Base Anemone White Milk",      "scientific_name": "Heteractis malu"},
      {"common_name": "Black Long Sea Cucumber",               "scientific_name": "Holothuria leucospilota"},
      {"common_name": "Harlequin Shrimp",                      "scientific_name": "Hymenocera picta"},
      {"common_name": "Hypselodoris Nudibranch (Assorted)",    "scientific_name": "Hypselodoris sp"},
      {"common_name": "Comet Linckia Sea Star",                "scientific_name": "Linckia guildingi"},
      {"common_name": "Blue Linckia Sea Star",                 "scientific_name": "Linckia laevigata"},
      {"common_name": "Boxer Crab",                            "scientific_name": "Lybia tesselata"},
      {"common_name": "Peppermint Cleaner Shrimp",             "scientific_name": "Lysmata vittata"},
      {"common_name": "Kuekenthali's Cleaner Shrimp",          "scientific_name": "Lysmata kuekenthali"},
      {"common_name": "Long Tentacle Anemone Green",           "scientific_name": "Macrodactyla doreensis"},
      {"common_name": "Long Tentacle Anemone Purple",          "scientific_name": "Macrodactyla doreensis"},
      {"common_name": "Globe Sea Urchin (Brown Spines)",       "scientific_name": "Mespilia globulus"},
      {"common_name": "Globe Sea Urchin (Red Spines)",         "scientific_name": "Mespilia globulus"},
      {"common_name": "Tongan Nassarius Snail",                "scientific_name": "Nassarius distortus"},
      {"common_name": "Anemone Crab",                          "scientific_name": "Neopetrolisthes ohshimai"},
      {"common_name": "Zebra Brittle Sea Star",                "scientific_name": "Ophiolepis superba"},
      {"common_name": "Chain-link Brittle Sea Star",           "scientific_name": "Ophiomastix annulosa"},
      {"common_name": "Scarlet Reef Hermit Crab",              "scientific_name": "Paguristes cadenati"},
      {"common_name": "Knobbly Sea Star",                      "scientific_name": "Protoreaster nodosus"},
      {"common_name": "Bumble Bee Snail",                      "scientific_name": "Pusiostoma mendicaria"},
      {"common_name": "Camel Shrimp",                          "scientific_name": "Rhynchocinetes durbanensis"},
      {"common_name": "Common Feather-duster Tube Worm",       "scientific_name": "Sabellastarte spectabilis"},
      {"common_name": "Yellow Feather-duster Tube Worm",       "scientific_name": "Sabellastarte spectabilis"},
      {"common_name": "Saron Shrimp",                          "scientific_name": "Saron marmoratus"},
      {"common_name": "Banded Coral Shrimp",                   "scientific_name": "Stenopus hispidus"},
      {"common_name": "Gold Banded Coral Shrimp",              "scientific_name": "Stenopus zanzibaricus"},
      {"common_name": "Purple Banded Coral Shrimp",            "scientific_name": "Stenopus zanzibaricus"},
      {"common_name": "Carpet Anemone Brown",                  "scientific_name": "Stichodactyla haddoni"},
      {"common_name": "Orange Carpet Anemone",                 "scientific_name": "Stichodactyla gigantea"},
      {"common_name": "Carpet Anemone White",                  "scientific_name": "Stichodactyla haddoni"},
      {"common_name": "Little Pitcher Conch (Assorted)",       "scientific_name": "Strombus urceus"},
      {"common_name": "Turban Algae Shell",                    "scientific_name": "Tectus fenestratus"},
      {"common_name": "Sexy Anemone Shrimp",                   "scientific_name": "Thor amboinensis"},
      {"common_name": "White Collector Sea Urchin",            "scientific_name": "Tripneustes gratilla"},
      {"common_name": "Multicolor Collector Sea Urchin",       "scientific_name": "Tripneustes gratilla"},
      {"common_name": "Assorted Red Banded Algae Snail",       "scientific_name": "Trochus histrio"},
      {"common_name": "Dwarf Turban Snail (Assorted)",         "scientific_name": "Turbo bruneus"}
    ]
  },
  {
    "family": "Moorish Idol",
    "cards": [
      {"common_name": "Moorish Idol",                          "scientific_name": "Zanclus cornutus"}
    ]
  },
  {
    "family": "Other Reef Fish",
    "cards": [
      {"common_name": "Eye Flounder",                          "scientific_name": "Bothus sp"},
      {"common_name": "Striped Catfish",                       "scientific_name": "Plotosus lineatus"},
      {"common_name": "Bridled Monocle Bream",                 "scientific_name": "Scolopsis bilineatus"}
    ]
  },
  {
    "family": "Pufferfish & Boxfish",
    "cards": [
      {"common_name": "Stars & Stripes Pufferfish",            "scientific_name": "Arothron hispidus"},
      {"common_name": "Striped Pufferfish",                    "scientific_name": "Arothron manilensis"},
      {"common_name": "Map Pufferfish",                        "scientific_name": "Arothron mappa"},
      {"common_name": "Black Spotted Pufferfish (Grey)",       "scientific_name": "Arothron nigropunctatus"},
      {"common_name": "Star Pufferfish",                       "scientific_name": "Arothron stellatus"},
      {"common_name": "Bennett's Toby",                        "scientific_name": "Canthigaster bennetti"},
      {"common_name": "Spotted Toby",                          "scientific_name": "Canthigaster solandri"},
      {"common_name": "Black Saddled Toby",                    "scientific_name": "Canthigaster valentini"},
      {"common_name": "Black Blotched Porcupine Fish",         "scientific_name": "Diodon liturosus"},
      {"common_name": "Longhorned Cowfish",                    "scientific_name": "Lactoria cornuta"},
      {"common_name": "Yellow Black Spotted Boxfish",          "scientific_name": "Ostracion cubicus"},
      {"common_name": "Blue Spotted Boxfish (Male)",           "scientific_name": "Ostracion meleagris"},
      {"common_name": "Black Spotted Boxfish (Female)",        "scientific_name": "Ostracion meleagris"},
      {"common_name": "Horn Nosed Boxfish",                    "scientific_name": "Ostracion rhinorhynchos"}
    ]
  },
  {
    "family": "Rabbitfish",
    "cards": [
      {"common_name": "White Spotted Rabbitfish",              "scientific_name": "Siganus canaliculatus"},
      {"common_name": "Indian Coral Rabbitfish",               "scientific_name": "Siganus corallinus"},
      {"common_name": "Magnificent Rabbitfish",                "scientific_name": "Siganus magnificus"},
      {"common_name": "Chin Strap Rabbitfish",                 "scientific_name": "Siganus puelloides"},
      {"common_name": "Golden Masked Rabbitfish",              "scientific_name": "Siganus puellus"},
      {"common_name": "Double Barred Rabbitfish",              "scientific_name": "Siganus virgatus"},
      {"common_name": "Foxface Rabbitfish",                    "scientific_name": "Siganus vulpinus"}
    ]
  },
  {
    "family": "Sandtilefish",
    "cards": [
      {"common_name": "Green Sandtilefish",                    "scientific_name": "Hoplolatilus cuniculus"},
      {"common_name": "Yellow Sandtilefish",                   "scientific_name": "Hoplolatilus luteus"},
      {"common_name": "Red Stripe Sandtilefish",               "scientific_name": "Hoplolatilus marcosi"},
      {"common_name": "Purple Sandtilefish",                   "scientific_name": "Hoplolatilus purpureus"},
      {"common_name": "Purple Headed Sandtilefish",            "scientific_name": "Hoplolatilus starcki"},
      {"common_name": "Striped Blanquillo",                    "scientific_name": "Malacanthus latovittatus"}
    ]
  },
  {
    "family": "Scorpionfish & Lionfish",
    "cards": [
      {"common_name": "Cockatoo Waspfish",                     "scientific_name": "Ablabys taenianotus"},
      {"common_name": "Twinspot Lionfish",                     "scientific_name": "Dendrochirus biocellatus"},
      {"common_name": "Shortfin Lionfish",                     "scientific_name": "Dendrochirus brachypterus"},
      {"common_name": "Zebra Lionfish",                        "scientific_name": "Dendrochirus zebra"},
      {"common_name": "Spotfin Lionfish",                      "scientific_name": "Pterois antennata"},
      {"common_name": "Tailbar Lionfish",                      "scientific_name": "Pterois radiata"},
      {"common_name": "Goose Scorpionfish (Yellow)",           "scientific_name": "Rhinopias frondosa"},
      {"common_name": "Goose Scorpionfish (Red)",              "scientific_name": "Rhinopias frondosa"},
      {"common_name": "Goose Scorpionfish (Purple)",           "scientific_name": "Rhinopias frondosa"},
      {"common_name": "Sailfin/Leaf Scorpionfish",             "scientific_name": "Taenianotus triacanthos"},
      {"common_name": "Sailfin/Leaf Scorpionfish Yellow",      "scientific_name": "Taenianotus triacanthos"},
      {"common_name": "Sailfin/Leaf Scorpionfish Red/Purple",  "scientific_name": "Taenianotus triacanthos"}
    ]
  },
  {
    "family": "Seahorses & Pipefish",
    "cards": [
      {"common_name": "Shrimp Fish",                           "scientific_name": "Aeoliscus strigatus"},
      {"common_name": "Messmate Pipefish",                     "scientific_name": "Corythoichthys intestinalis"},
      {"common_name": "Banded Pipefish",                       "scientific_name": "Doryhamphus dactyliophorus"},
      {"common_name": "Janss Pipefish",                        "scientific_name": "Doryhamphus janssi"},
      {"common_name": "Many Banded Pipefish",                  "scientific_name": "Doryhamphus multiannulatus"},
      {"common_name": "Alligator Pipefish",                    "scientific_name": "Syngnathoides biaculeatus"}
    ]
  },
  {
    "family": "Snappers & Seabream",
    "cards": [
      {"common_name": "Blue Lined Snapper",                    "scientific_name": "Lutjanus kasmira"},
      {"common_name": "Emperor Snapper",                       "scientific_name": "Lutjanus sebae"},
      {"common_name": "Malabar Blood Snapper",                 "scientific_name": "Lutjanus malabaricus"},
      {"common_name": "Black Beauty Snapper",                  "scientific_name": "Macolor niger"},
      {"common_name": "Blue Lined Seabream",                   "scientific_name": "Symphorichthys spilurus"}
    ]
  },
  {
    "family": "Soapfish",
    "cards": [
      {"common_name": "Sixstripe Soapfish",                    "scientific_name": "Grammistes sexlineatus"}
    ]
  },
  {
    "family": "Soldierfish & Squirrelfish",
    "cards": [
      {"common_name": "White Edge Soldierfish",                "scientific_name": "Myripristis axillaris"},
      {"common_name": "Soldierfish",                           "scientific_name": "Myripristis sp"}
    ]
  },
  {
    "family": "Surgeonfish & Tangs",
    "cards": [
      {"common_name": "Black Spot Surgeonfish",                "scientific_name": "Acanthurus bariene"},
      {"common_name": "Horse Shoe Surgeonfish",                "scientific_name": "Acanthurus fowleri"},
      {"common_name": "Mustard Surgeonfish",                   "scientific_name": "Acanthurus guttatus"},
      {"common_name": "White Faced Surgeonfish",               "scientific_name": "Acanthurus japonicus"},
      {"common_name": "Powder Blue Surgeonfish",               "scientific_name": "Acanthurus leucosternon"},
      {"common_name": "Lined Clown Surgeonfish",               "scientific_name": "Acanthurus lineatus"},
      {"common_name": "Black Eared Spot Faced Surgeonfish",    "scientific_name": "Acanthurus maculiceps"},
      {"common_name": "Yellow Eyed Surgeonfish",               "scientific_name": "Acanthurus mata"},
      {"common_name": "Gold Rimmed Surgeonfish",               "scientific_name": "Acanthurus nigricans"},
      {"common_name": "Eye Line Surgeonfish",                  "scientific_name": "Acanthurus nigricaudus"},
      {"common_name": "Dusky Red Surgeonfish",                 "scientific_name": "Acanthurus nigrofuscus"},
      {"common_name": "Orange Blotch Surgeonfish (Adult)",     "scientific_name": "Acanthurus olivaceus"},
      {"common_name": "Orange Blotch Surgeonfish (Juv)",       "scientific_name": "Acanthurus olivaceus"},
      {"common_name": "Yellow Mimic Surgeonfish (Juv)",        "scientific_name": "Acanthurus pyroferus"},
      {"common_name": "Yellow Mimic Surgeonfish (Adult)",      "scientific_name": "Acanthurus pyroferus"},
      {"common_name": "Lieutenant Surgeonfish",                "scientific_name": "Acanthurus tennenti"},
      {"common_name": "Convict Surgeonfish",                   "scientific_name": "Acanthurus triostegus"},
      {"common_name": "Yellow Mask Surgeonfish",               "scientific_name": "Acanthurus xanthopterus"},
      {"common_name": "Indonesian Powder Blue Surgeonfish",    "scientific_name": "Acanthurus leucosternon"},
      {"common_name": "Two Spot Bristletooth Surgeonfish",     "scientific_name": "Ctenochaetus binotatus"},
      {"common_name": "Striped Bristletooth Surgeonfish",      "scientific_name": "Ctenochaetus striatus"},
      {"common_name": "Tomini Bristletooth",                   "scientific_name": "Ctenochaetus tominiensis"},
      {"common_name": "Indian Orange Spine Unicornfish",       "scientific_name": "Naso elegans"},
      {"common_name": "Pacific Orange Spine Unicornfish",      "scientific_name": "Naso lituratus"},
      {"common_name": "Blue Spine Unicornfish",                "scientific_name": "Naso unicornis"},
      {"common_name": "Vlaming's Unicornfish",                 "scientific_name": "Naso vlamingii"},
      {"common_name": "Blue Surgeonfish",                      "scientific_name": "Paracanthurus hepatus"},
      {"common_name": "Sawtail Fish",                          "scientific_name": "Prionurus chrysurus"},
      {"common_name": "Desjardin's Sailfin Tang",              "scientific_name": "Zebrasoma desjardinii"},
      {"common_name": "Brown Sailfin Tang",                    "scientific_name": "Zebrasoma scopas"},
      {"common_name": "Koi/Aberrant Tang",                     "scientific_name": "Zebrasoma scopas"},
      {"common_name": "Pacific Sailfin Tang",                  "scientific_name": "Zebrasoma veliferum"}
    ]
  },
  {
    "family": "Sweetlips",
    "cards": [
      {"common_name": "Harlequin Sweetlip",                    "scientific_name": "Plectorhynchus chaetodonoides"},
      {"common_name": "Lined Sweetlip",                        "scientific_name": "Plectorhynchus lineatus"},
      {"common_name": "Oriental Sweetlip",                     "scientific_name": "Plectorhynchus orientalis"},
      {"common_name": "Painted Sweetlip",                      "scientific_name": "Plectorhynchus pictus"}
    ]
  },
  {
    "family": "Trevally & Relatives",
    "cards": [
      {"common_name": "African Pompano",                       "scientific_name": "Alectis ciliaris"},
      {"common_name": "Lined Shark Suckers",                   "scientific_name": "Echeneis naucrates"},
      {"common_name": "Golden Trevally",                       "scientific_name": "Gnathanodon speciosus"}
    ]
  },
  {
    "family": "Triggerfish",
    "cards": [
      {"common_name": "Orange Striped Triggerfish",            "scientific_name": "Balistapus undulatus"},
      {"common_name": "Clown Triggerfish",                     "scientific_name": "Balistoides conspicillum"},
      {"common_name": "Black Triggerfish",                     "scientific_name": "Melichthys niger"},
      {"common_name": "Pinktail Triggerfish",                  "scientific_name": "Melichthys vidua"},
      {"common_name": "Redtooth Triggerfish",                  "scientific_name": "Odonus niger"},
      {"common_name": "Blue & Gold Triggerfish",               "scientific_name": "Pseudobalistes fuscus"},
      {"common_name": "Picasso Triggerfish/Humu-humu",         "scientific_name": "Rhinecanthus aculeatus"},
      {"common_name": "Rectangle Triggerfish",                 "scientific_name": "Rhinecanthus rectangulus"},
      {"common_name": "Black Belly Triggerfish",               "scientific_name": "Rhinecanthus verrucosus"},
      {"common_name": "Half Moon Triggerfish",                 "scientific_name": "Sufflamen chrysopterus"},
      {"common_name": "Guilded Triggerfish (Female)",          "scientific_name": "Xanthichthys auromarginatus"},
      {"common_name": "Guilded Triggerfish (Male)",            "scientific_name": "Xanthichthys auromarginatus"}
    ]
  },
  {
    // ⚠️  Source JSON was truncated at this family — only 3 complete cards recovered.
    // Add missing cards before running, or run with what's here.
    "family": "Wrasses & Parrotfish",
    "cards": [
      {"common_name": "Yellow Tail Tamarin Wrasse",            "scientific_name": "Anampses meleagrides"},
      {"common_name": "Twospot Hogfish",                       "scientific_name": "Bodianus bimaculatus"},
      {"common_name": "Diana's Hogfish",                       "scientific_name": "Bodianus diana"}
    ]
  }
];

// ── Main ──────────────────────────────────────────────────────────────────────

async function main() {
  const totalCards = DATA.reduce((s, f) => s + f.cards.length, 0);
  console.log('🐠  Phase 1 — Import marine creature database');
  console.log(`    Supabase: ${SB_URL}`);
  console.log(`    Families: ${DATA.length}  |  Cards: ${totalCards}\n`);

  // ── Step 1: Check is_visible column ────────────────────────────────────────
  await ensureIsVisibleColumn();

  // ── Step 2: Load existing IDs (avoid double-counting skips) ───────────────
  const existingFamilyRows = await sbSelect('/fish_families?select=id&limit=500').catch(() => []);
  const existingFamilyIds  = new Set((existingFamilyRows || []).map(r => r.id));

  const existingCardRows   = await sbSelect('/fish_cards?select=id&limit=2000').catch(() => []);
  const existingCardIds    = new Set((existingCardRows || []).map(r => r.id));

  let famInserted = 0, famSkipped = 0, cardInserted = 0, cardSkipped = 0;
  const errors = [];

  // ── Step 3: Insert families then their cards ────────────────────────────────
  for (const familyData of DATA) {
    const famId = makeFamilyId(familyData.family);

    // Insert / skip family
    if (existingFamilyIds.has(famId)) {
      famSkipped++;
    } else {
      try {
        await sbPost('/fish_families', {
          id:         famId,
          name_en:    familyData.family,
          name_ar:    '',
          name_ku:    '',
          created_at: new Date().toISOString(),
        });
        existingFamilyIds.add(famId);
        famInserted++;
      } catch (e) {
        errors.push(`Family "${familyData.family}": ${e.message}`);
        console.error(`  ✗ Family: ${familyData.family} — ${e.message}`);
        continue;
      }
    }

    // Insert cards for this family
    let familyNewCards = 0;
    for (const cardData of familyData.cards) {
      const cardId = makeCardId(famId, cardData.common_name);

      if (existingCardIds.has(cardId)) {
        cardSkipped++;
        continue;
      }

      try {
        await sbPost('/fish_cards', {
          id:              cardId,
          family_id:       famId,
          common_name_en:  cardData.common_name,
          common_name_ar:  '',
          common_name_ku:  '',
          scientific_name: cardData.scientific_name,
          care_level:      null,
          diet:            null,
          reef_safe:       null,
          notes:           '',
          image_url:       null,
          is_visible:      true,
          created_at:      new Date().toISOString(),
        });
        existingCardIds.add(cardId);
        cardInserted++;
        familyNewCards++;
      } catch (e) {
        // If NULL not allowed for care_level/diet/reef_safe, suggest fix
        if (e.message.includes('null value') || e.message.includes('violates not-null')) {
          console.error(`\n⚠️  NULL constraint error on fish_cards.`);
          console.error(`   Run this SQL in Supabase Dashboard → SQL Editor:\n`);
          console.error(`   ALTER TABLE fish_cards`);
          console.error(`     ALTER COLUMN care_level DROP NOT NULL,`);
          console.error(`     ALTER COLUMN diet       DROP NOT NULL,`);
          console.error(`     ALTER COLUMN reef_safe  DROP NOT NULL;\n`);
          console.error(`   Then re-run this script.\n`);
          process.exit(1);
        }
        errors.push(`Card "${cardData.common_name}": ${e.message}`);
        console.error(`  ✗ Card "${cardData.common_name}": ${e.message}`);
      }
    }

    console.log(`  ✓ ${familyData.family.padEnd(32)} ${familyNewCards} new  (${familyData.cards.length} total)`);
  }

  // ── Summary ─────────────────────────────────────────────────────────────────
  console.log('\n─────────────────────────────────────────────────');
  console.log(`✅  Phase 1 complete`);
  console.log(`    Families : ${famInserted} inserted, ${famSkipped} already existed`);
  console.log(`    Cards    : ${cardInserted} inserted, ${cardSkipped} already existed`);
  if (errors.length) {
    console.log(`\n⚠️  ${errors.length} error(s):`);
    errors.forEach(e => console.log('   •', e));
  }
  console.log('\n▶  Next: run  node scripts/phase2-fishbase.js');
}

main().catch(e => {
  console.error('\n❌  Fatal:', e.message);
  process.exit(1);
});
