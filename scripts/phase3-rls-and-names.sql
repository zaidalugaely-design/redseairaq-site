-- ═══════════════════════════════════════════════════════════════════════
-- Phase 3 — Fix public read access + delete duplicate + Arabic family names
-- Run in: Supabase Dashboard → SQL Editor
-- Safe to re-run (idempotent)
-- ═══════════════════════════════════════════════════════════════════════

-- ─────────────────────────────────────────────────────────────────────────
-- STEP 1: Grant public read access to anon key
-- (Required so the website frontend can load fish data)
-- ─────────────────────────────────────────────────────────────────────────

GRANT SELECT ON public.fish_families TO anon;
GRANT SELECT ON public.fish_cards    TO anon;

-- Enable RLS and add public-read policies (covers both cases)
ALTER TABLE public.fish_families ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.fish_cards    ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "public read fish_families" ON public.fish_families;
CREATE POLICY "public read fish_families"
  ON public.fish_families FOR SELECT USING (true);

DROP POLICY IF EXISTS "public read fish_cards" ON public.fish_cards;
CREATE POLICY "public read fish_cards"
  ON public.fish_cards FOR SELECT USING (true);

-- ─────────────────────────────────────────────────────────────────────────
-- STEP 2: Delete duplicate empty family
-- ─────────────────────────────────────────────────────────────────────────

DELETE FROM fish_families WHERE id = 'fam-1779274528494';

-- ─────────────────────────────────────────────────────────────────────────
-- STEP 3: Add Arabic and Kurdish names to all 33 families
-- ─────────────────────────────────────────────────────────────────────────

UPDATE fish_families SET
  name_ar = 'أسماك شقائق النعمان والأبو طبان',
  name_ku = 'ماسیی شیلی بحر و کلاون'
WHERE id = 'fam-anemonefish-clownfish';

UPDATE fish_families SET
  name_ar = 'أسماك الملائكة',
  name_ku = 'ماسیی مەلاوێکە'
WHERE id = 'fam-angelfish';

UPDATE fish_families SET
  name_ar = 'الأنثياس والباسيلتس',
  name_ku = 'ئەنتیاس و بازلێتس'
WHERE id = 'fam-anthias-basslets';

UPDATE fish_families SET
  name_ar = 'أسماك الخفاش',
  name_ku = 'ماسیی شەپۆل'
WHERE id = 'fam-batfish';

UPDATE fish_families SET
  name_ar = 'البلنيات',
  name_ku = 'بلێنییەکان'
WHERE id = 'fam-blennies';

UPDATE fish_families SET
  name_ar = 'أسماك الفراشة',
  name_ku = 'ماسیی پەپووڵە'
WHERE id = 'fam-butterflyfish';

UPDATE fish_families SET
  name_ar = 'أسماك الكاردينال',
  name_ku = 'ماسیی کاردینال'
WHERE id = 'fam-cardinalfish';

UPDATE fish_families SET
  name_ar = 'أسماك الدامسيل',
  name_ku = 'ماسیی دامزێل'
WHERE id = 'fam-damselfish';

UPDATE fish_families SET
  name_ar = 'الدوتيباك',
  name_ku = 'دۆتیباک'
WHERE id = 'fam-dottybacks';

UPDATE fish_families SET
  name_ar = 'الأنقليس',
  name_ku = 'مارماسی'
WHERE id = 'fam-eels';

UPDATE fish_families SET
  name_ar = 'أسماك الملف',
  name_ku = 'ماسیی فایل'
WHERE id = 'fam-filefish';

UPDATE fish_families SET
  name_ar = 'أسماك الضفدع',
  name_ku = 'ماسیی بۆق'
WHERE id = 'fam-frogfish';

UPDATE fish_families SET
  name_ar = 'الفيوزيليرز',
  name_ku = 'فیوزیلییەکان'
WHERE id = 'fam-fusiliers';

UPDATE fish_families SET
  name_ar = 'سلطان إبراهيم',
  name_ku = 'ماسیی بزن بحر'
WHERE id = 'fam-goatfish';

UPDATE fish_families SET
  name_ar = 'الجوبيات',
  name_ku = 'گۆبییەکان'
WHERE id = 'fam-gobies';

UPDATE fish_families SET
  name_ar = 'الهامور',
  name_ku = 'هامور'
WHERE id = 'fam-groupers';

UPDATE fish_families SET
  name_ar = 'أسماك الصقر',
  name_ku = 'ماسیی باز'
WHERE id = 'fam-hawkfish';

UPDATE fish_families SET
  name_ar = 'اللافقاريات',
  name_ku = 'بێ مهرەیەکان'
WHERE id = 'fam-invertebrates';

UPDATE fish_families SET
  name_ar = 'الزاهد المغربي',
  name_ku = 'ئایدۆڵی مووری'
WHERE id = 'fam-moorish-idol';

UPDATE fish_families SET
  name_ar = 'أسماك شعاب مرجانية أخرى',
  name_ku = 'ماسیی ریفی تر'
WHERE id = 'fam-other-reef-fish';

UPDATE fish_families SET
  name_ar = 'أسماك الكرة والصندوق',
  name_ku = 'ماسیی باڵقی و سندووق'
WHERE id = 'fam-pufferfish-boxfish';

UPDATE fish_families SET
  name_ar = 'أسماك الأرنب',
  name_ku = 'ماسیی کانیچک'
WHERE id = 'fam-rabbitfish';

UPDATE fish_families SET
  name_ar = 'أسماك بلاط الرمال',
  name_ku = 'ماسیی خاک بحر'
WHERE id = 'fam-sandtilefish';

UPDATE fish_families SET
  name_ar = 'أسماك العقرب والأسد',
  name_ku = 'ماسیی دڕندە و شێر'
WHERE id = 'fam-scorpionfish-lionfish';

UPDATE fish_families SET
  name_ar = 'فرس البحر وأسماك الأنبوب',
  name_ku = 'ئەسپی بحر و ماسیی بۆری'
WHERE id = 'fam-seahorses-pipefish';

UPDATE fish_families SET
  name_ar = 'الدنيس والشبار',
  name_ku = 'ماسیی دەنیس و شەباری'
WHERE id = 'fam-snappers-seabream';

UPDATE fish_families SET
  name_ar = 'أسماك الصابون',
  name_ku = 'ماسیی سابوون'
WHERE id = 'fam-soapfish';

UPDATE fish_families SET
  name_ar = 'أسماك الجندي والسنجاب',
  name_ku = 'ماسیی سەربازی و سنجاب'
WHERE id = 'fam-soldierfish-squirrelfish';

UPDATE fish_families SET
  name_ar = 'أسماك الجراح',
  name_ku = 'ماسیی نەشتەرگەر'
WHERE id = 'fam-surgeonfish-tangs';

UPDATE fish_families SET
  name_ar = 'أسماك الشفاه الحلوة',
  name_ku = 'ماسیی لێوی شیرین'
WHERE id = 'fam-sweetlips';

UPDATE fish_families SET
  name_ar = 'الكوفر وأقاربه',
  name_ku = 'کەوفەر و هاوڕێکانی'
WHERE id = 'fam-trevally-relatives';

UPDATE fish_families SET
  name_ar = 'أسماك الزناد',
  name_ku = 'ماسیی مەحەنەکە'
WHERE id = 'fam-triggerfish';

UPDATE fish_families SET
  name_ar = 'أسماك الراسة والببغاء',
  name_ku = 'ماسیی راسە و تۆتی'
WHERE id = 'fam-wrasses-parrotfish';

-- ═══════════════════════════════════════════════════════════════════════
-- Done. Expected: public read enabled, 1 family deleted, 33 families named.
-- ═══════════════════════════════════════════════════════════════════════
