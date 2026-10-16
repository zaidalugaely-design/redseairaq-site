#!/usr/bin/env node
'use strict';

const https = require('https');
const fs    = require('fs');
const path  = require('path');

const SB_URL = 'https://glhmmrovxyijtzjaldtf.supabase.co';
const SB_KEY = 'sb_publishable_hzVe29KIzQ2h72PuHBLZ5Q_M6BLVkaI';
const SITE   = 'https://redseairaq.com';
const OUT    = path.join(__dirname, '..', 'dist', 'p');

function esc(str) {
  return String(str || '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#x27;');
}

const DEFAULT_IMAGE = `${SITE}/og-default.jpg`;

function safeImage(url) {
  if (typeof url === 'string' && url.startsWith('https://')) return url;
  return DEFAULT_IMAGE;
}

/* /.netlify/images?url=... يرجع 400 فعلياً للصور المصدر الكبيرة (تأكد على rsa_r35320،
   8.9MB — أكبر صورة بمجلد red-sea-images، أكبر من حد Netlify Image CDN لجلب/تحويل
   المصدر). نستخدم رابط Supabase الأصلي مباشرة بدل المرور بهذا المحوّل. */
function imageType(url) {
  const ext = String(url).split('?')[0].split('.').pop().toLowerCase();
  if (ext === 'png') return 'image/png';
  if (ext === 'webp') return 'image/webp';
  return 'image/jpeg';
}

/* صور og:image الأصلية فوق ~300 كيلوبايت يرفضها واتساب بصمت (بلا صورة بالمعاينة
   إطلاقاً، لا خطأ ظاهر). لهذا كل صورة منتج كانت > 300KB (فُحصت كل صور Supabase Storage
   لمجلد red-sea-images فعلياً، سبتمبر 2026 — 26 صورة) لها نسخة مصغّرة/مضغوطة دائمة
   (JPEG، حد أقصى 1200×1200، أقل من 300KB) مولَّدة *مسبقاً* بـ og-thumbs/{id}.jpg بنفس
   الـ bucket — لا معالجة حيّة وقت الطلب. الصورة الأصلية عالية الجودة تبقى كما هي
   وتُستخدم بصفحة المنتج نفسها (index.html لم يُمس). og:image يستخدم النسخة المصغّرة
   لأي id بالقائمة أدناه، وإلا الصورة الأصلية مباشرة (آمنة لأي منتج ≤300KB أصلاً).

   القائمة *ثابتة يدوياً* عمداً — لا استعلام حي وقت البناء: لا توجد سياسة RLS تسمح
   بعملية LIST على مجلد Storage بالمفتاح العام (فقط GET لملف محدد بالمسار مسموح
   للـ bucket العام، جُرّب فعلياً وتأكد الفرق)، وإضافة سياسة كهذي تعديل صلاحيات لا
   يستحق التعقيد لقائمة تتغيّر نادراً.

   **أي صورة منتج جديدة تُرفع مستقبلاً وحجمها > 300KB تحتاج نفس المعالجة يدوياً:**
   أعد نشر/شغّل دالة `generate-og-thumbnails` (Supabase Edge Function، Deno +
   ImageScript، تفاصيل الطريقة كاملة موثّقة بجلسة "معالجة صور og:image الكبيرة"،
   سبتمبر 2026) على الصورة الجديدة، ثم أضف الـ id هنا. */
const OG_THUMB_IDS = new Set([
  'p1', 'p4',
  'rsa_r35150', 'rsa_r35184', 'rsa_r35185', 'rsa_r35310', 'rsa_r35320',
  'rsa_r40580', 'rsa_r42089', 'rsa_r42195', 'rsa_r42196', 'rsa_r42197',
  'rsa_r42437', 'rsa_r43764', 'rsa_r45118', 'rsa_r45132', 'rsa_r45139',
  'rsa_r45146', 'rsa_r45164', 'rsa_r45173', 'rsa_r45198', 'rsa_r45206',
  'rsa_r45214', 'rsa_r45221', 'rsa_r50504', 'rsa_r50506',
]);

function fetchProducts() {
  return new Promise((resolve, reject) => {
    const reqUrl = new URL(
      `${SB_URL}/rest/v1/products?select=id,name,description,image&limit=1000`
    );
    https.get(
      { hostname: reqUrl.hostname, path: reqUrl.pathname + reqUrl.search,
        headers: { apikey: SB_KEY, Authorization: `Bearer ${SB_KEY}`, Accept: 'application/json' } },
      (res) => {
        let raw = '';
        res.on('data', c => raw += c);
        res.on('end', () => {
          try { resolve(JSON.parse(raw)); }
          catch (e) { reject(new Error(`JSON parse failed: ${e.message}\nBody: ${raw.slice(0, 200)}`)); }
        });
      }
    ).on('error', reject);
  });
}

function page(p) {
  const id      = p.id;
  const title   = esc(p.name || 'Red Sea Iraq');
  const desc    = esc((p.description || 'منتج Red Sea الأصلي — الوكيل الحصري في العراق').slice(0, 160));
  console.log('RAW image for', p.id, ':', JSON.stringify(p.image));
  const hasThumb = OG_THUMB_IDS.has(id);
  const rawImage = hasThumb ? `${SB_URL}/storage/v1/object/public/products/og-thumbs/${id}.jpg` : safeImage(p.image);
  const image    = esc(rawImage);
  const imgType  = hasThumb ? 'image/jpeg' : imageType(rawImage);
  const ogUrl   = `${SITE}/p/${encodeURIComponent(id)}.html`;
  const hashUrl = `${SITE}/#/product/${encodeURIComponent(id)}`;
  const hashRel = `/#/product/${encodeURIComponent(id)}`;

  return `<!DOCTYPE html><html lang="ar"><head>
<!-- generated: ${new Date().toISOString()} -->
<meta charset="utf-8">
<meta property="og:type" content="product">
<meta property="og:title" content="${title}">
<meta property="og:description" content="${desc}">
<meta property="og:image" content="${image}">
<meta property="og:image:type" content="${imgType}">
<meta property="og:url" content="${ogUrl}">
<meta property="og:site_name" content="Red Sea Iraq">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="${title}">
<meta name="twitter:description" content="${desc}">
<meta name="twitter:image" content="${image}">
<meta http-equiv="refresh" content="0;url=${hashUrl}">
<title>${title} | Red Sea Iraq</title>
</head>
<body><p>&#x62C;&#x627;&#x631;&#x64A; &#x627;&#x644;&#x62A;&#x62D;&#x648;&#x64A;&#x644;&#x2026;</p>
<script>location.replace('${hashRel}');</script>
</body></html>`;
}

async function main() {
  console.log('Fetching products from Supabase...');
  let products;
  try {
    products = await fetchProducts();
  } catch (e) {
    console.error('ERROR fetching products:', e.message);
    process.exit(1);
  }

  console.log('First product:', JSON.stringify(products[0]));

  if (!Array.isArray(products)) {
    console.error('Unexpected response (not an array):', JSON.stringify(products).slice(0, 200));
    process.exit(1);
  }

  products.forEach(p => console.log(p.id, '→', p.image || '(empty)'));

  if (!fs.existsSync(OUT)) fs.mkdirSync(OUT, { recursive: true });

  let count = 0;
  for (const p of products) {
    if (!p.id) continue;
    fs.writeFileSync(path.join(OUT, `${p.id}.html`), page(p), 'utf8');
    count++;
  }

  console.log(`Generated ${count} OG pages → /p/`);
}

main();
