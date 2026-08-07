# CLAUDE.md — دليل العمل الكامل لمشروع redseairaq.com

---

## Git Workflow — ALWAYS Follow This

**Always work directly on `main`. No exceptions.**

- Never create branches
- Never create pull requests
- Always: `git add` → `git commit` → `git push origin main`
- Every push must go to `origin main` so Netlify deploys to Production (not Deploy Preview)

Before every commit, verify you are on main:
```
git branch   # must show: * main
```

If not on main, switch immediately: `git checkout main`

---

## ضوابط العمل — يجب الالتزام بها دائماً

1. **تشخيص أولاً، تنفيذ بعد الموافقة** — لا تعدّل الكود أبداً قبل أن تعرض التشخيص والخطة وتحصل على موافقة صريحة.
2. **لا تتجاوز النطاق** — نفّذ ما طُلب فقط. لا تنظّف كوداً جانبياً، ولا تُعدّل أكثر مما وافق عليه المالك.
3. **اعرض hash الكوميت بعد كل push** — أكّد للمالك بالـ commit hash أن التغيير وصل.
4. **ممنوع تصغير كود الأنميشن** — CSS animations وكل كود ذات صلة يبقى مقروءاً ومنسّقاً.
5. **تحقق عبر Supabase SQL لا عبر Netlify logs** — الـ console logs لا تصل من Lambda، الطريقة الوحيدة لتأكيد التنفيذ هي جدول `_debug_log` أو استعلام مباشر.
6. **الشبكة محجوبة من بيئة التنفيذ** — لا يمكن الاتصال بـ Supabase أو أي خدمة خارجية عبر curl/fetch من هذه البيئة (403 من proxy). قدّم استعلامات SQL للمالك ليشغّلها بنفسه.

---

## بنية الموقع

### الملفات الأساسية

| الملف | الوصف |
|-------|-------|
| `index.html` | SPA كاملة — HTML + CSS + JS في ملف واحد (~6100 سطر، ~460 KB) |
| `netlify/functions/api.js` | Gateway الـ API — كل العمليات الحساسة تمر منه (~1064 سطر) |
| `netlify.toml` | إعدادات البناء والنشر |
| `scripts/generate-og-pages.js` | يُولّد صفحات OG ثابتة (`dist/p/{id}.html`) عند البناء |
| `scripts/migrate-base64-images.js` | سكريبت ترحيل الصور من base64 إلى Supabase Storage (احتفظ به حتى تأكيد اكتمال الترحيل) |

### netlify.toml

```toml
[build]
  command = "mkdir -p dist && cp index.html dist/ && cp -r netlify dist/ && node scripts/generate-og-pages.js"
  functions = "netlify/functions"
  publish = "dist"
[functions]
  node_bundler = "esbuild"
[[redirects]]
  from = "/*"  to = "/index.html"  status = 200
```

### متغيرات البيئة (Netlify Dashboard)

| المتغير | الاستخدام |
|---------|-----------|
| `SUPABASE_URL` | رابط المشروع (`https://glhmmrovxyijtzjaldtf.supabase.co`) |
| `SB_SERVICE_KEY` | مفتاح service_role — لا يُكشف أبداً للعميل |
| `ADMIN_PASS_HASH` | hash كلمة مرور الأدمن |
| `JWT_SECRET` | لتوليد وتحقق JWT للأدمن |
| `NETLIFY_BUILD_HOOK` | رابط POST لإعادة البناء بعد حفظ منتج |

### Frontend (index.html)

- **routing**: hash-based (`#/home`, `#/products`, `#/product/{id}`)
- **المفتاح العام**: `const SB_KEY = 'sb_publishable_...'` — مرئي في المصدر، لا تضع عليه اعتماداً أمنياً
- **`sbGet(path)`**: طلبات GET مباشرة لـ Supabase بالمفتاح العام
- **`apiCall(action, body, requireAuth)`**: يُرسل إلى `/.netlify/functions/api` — الطريقة الوحيدة للعمليات الحساسة
- **`syncFromSupabase()`**: يُشغَّل عند التحميل، يجلب products/categories/blog/reference — **يُنتظر (await) قبل router()**، أي الزبون يرى دائماً بيانات Supabase الحديثة
- **`products` (متغير)**: يُهيَّأ من `localStorage['rsi_prods']` أولاً، تُحدَّث بعد sync

### api.js — أهم الـ actions

| Action | Auth | الوصف |
|--------|------|-------|
| `login` | لا | يُعيد JWT عند صحة كلمة المرور |
| `save_product` | نعم | حفظ/تعديل منتج، يُشغّل `triggerRebuild()` |
| `save_category` | نعم | حفظ فئة |
| `delete_category` | نعم | حذف فئة |
| `save_order` | لا | حفظ طلب جديد |
| `upload_product_image` | نعم | رفع صورة لـ Supabase Storage |
| `migrate_images_batch` | نعم | ترحيل 10 صور base64 دفعة واحدة (مؤقت) |
| `sync` | لا | جلب منتجات وفئات |

---

## جداول Supabase (10 جداول)

| الجدول | الصفوف | RLS | ملاحظات |
|--------|--------|-----|---------|
| `products` | 189 | ✅ | المنتجات الرئيسية |
| `products_image_backup` | 190 | ✅ | نسخة احتياطية من قبل ترحيل الصور — يمكن حذفها بعد التأكيد |
| `categories` | 13 | ✅ | الفئات |
| `orders` | 15 | ✅ | الطلبات |
| `fish_cards` | 454 | ✅ | كل الصفوف لها `reef_safe` (لا NULL) |
| `fish_families` | 33 | ✅ | عائلات الأسماك |
| `coral_cards` | 0 | ✅ | فارغة حالياً |
| `reference_topics` | 11 | ✅ | مقالات المرجع |
| `blog_posts` | 0 | ✅ | فارغة حالياً |
| `_debug_log` | 16 | ✅ | جدول مؤقت للتشخيص — احذفه بعد التأكيد |

### بنية `products`

أهم الحقول: `id`, `name`, `category`, `price`, `currency`, `stock`, `image`, `description`, `specs` (JSONB), `variants` (JSONB), `hidden`, `badge`, `sort_order`, `updated_at`

**قيم `stock` الصالحة:** `available` | `available_nd` | `preorder` | `soon` | `out`

**`variants` format:**
```json
[{"name": "500ml", "price": 40000}, {"name": "1000ml", "price": 75000}]
```

---

## الأخطاء المتكررة وحلولها الجذرية

### 1. AWS Lambda Freeze — triggerRebuild لا تُشغَّل

**الأعراض:** بناء Netlify لا يُشغَّل تلقائياً بعد حفظ منتج. `_debug_log` فارغ.

**السبب الجذري:** Lambda تتجمّد فور `return res(...)`. أي `fetch()` بعدها يُلغى.

**الحل:** `await triggerRebuild()` قبل `return`، وكل شيء داخل triggerRebuild يكون `await`.

```js
// api.js — save_product
try { await triggerRebuild(); } catch (_) {}
return res(headers, 200, { ok: true });
```

**الكوميت:** `88fc245`

---

### 2. سعر المنتج للأدمن ≠ سعر المنتج للزبون (variant products)

**الأعراض:** الأدمن يُعدّل السعر، يراه محدثاً في لوحة الأدمن، لكن الزبائن يرون السعر القديم.

**السبب الجذري:** مصدران منفصلان للسعر:
- قائمة الأدمن تعرض `p.price`
- بطاقة المنتج للزبون تعرض `p.variants[0].price`
- `saveAdminProduct()` كانت تحفظ `price` جديداً لكن تترك `variants[0].price` بالقيمة القديمة

**الحل الجذري — 3 تعديلات:**

```js
// 1. saveAdminProduct(): عند الحفظ، زامن variants[0].price مع price
if (variants.length) variants[0].price = price;

// 2. editAdminProduct(): اعرض variants[0].price في حقل السعر (لا p.price)
adminPrice.value = p.variants?.length ? p.variants[0].price : p.price;

// 3. adminProductRow(): اعرض variants[0].price في قائمة الأدمن
money(p.variants?.length ? p.variants[0].price : p.price, cur)
```

**الكوميت:** `514ad26`

**SQL لمزامنة البيانات القديمة في Supabase:**
```sql
UPDATE products
SET
  variants   = jsonb_set(variants, '{0,price}', to_jsonb(price)),
  updated_at = now()
WHERE variants IS NOT NULL
  AND variants <> '[]'::jsonb
  AND price <> (variants->0->>'price')::numeric;
```

---

### 3. addToCart صامتة لمنتجات `available_nd`

**الأعراض:** الزر مفعّل ويكتب "أضف للسلة" لكن الضغط عليه لا يفعل شيئاً.

**السبب الجذري:** `addToCart()` تتحقق من `stock === 'available' || stock === 'preorder'` فقط — وتتجاهل `available_nd` بصمت تام بلا رسالة خطأ.

**المنتجات المتأثرة (8 منتجات بـ `available_nd`):**
`p1778362430841`, `p1778632522151`, `p1778434984579`, `p1781983793656`, `p1780761808459`, `p1780763513769`, `p1780763169396`, `p1782008005906`

**الحل:**
```js
if (!p || (p.stock !== 'available' && p.stock !== 'available_nd' && p.stock !== 'preorder')) return;
```

**الكوميت:** `9f979e9`

---

### 4. اختيار الـ Variant مبني على DOM — انقطاع عند إعادة الرندر

**الأعراض:** المستخدم يختار variant، الـ Supabase sync يُعيد رندر الصفحة، الاختيار يُفقد أو يُقرأ variant خاطئ. إضافة للسلة تُضيف variant غاطئ أو تُكرش بلا رسالة.

**السبب الجذري:** `varIdx(pid)` كانت تقرأ `document.getElementById('var-'+pid).value` لحظة الإضافة للسلة. نفس الـ id يمكن أن يظهر في عدة أماكن (الرئيسية + صفحة المنتجات) و`getElementById` يُعيد الأول. إعادة الرندر تُصفّر الـ select.

**الحل الجذري — نقل مصدر الحقيقة للـ state:**

```js
// state object — مصدر الحقيقة الوحيد
const selectedVariants = {};

// varIdx يقرأ من state لا من DOM
function varIdx(pid) { return selectedVariants[pid] ?? 0; }

// onVarChange يكتب للـ state أولاً
window.onVarChange = function(pid, sel) {
  selectedVariants[pid] = Number(sel.value || 0);
  // ثم يُحدّث عرض السعر...
};

// prodCard ينشئ select مع selected مبني من state
`<option value="${i}"${i===(selectedVariants[p.id]||0)?' selected':''}>`
```

**الكوميت:** `bffcd33`

**التحقق:** اختبار Playwright أكّد:
- `selectedVariants[pid]` يُحدَّث فور اختيار variant
- السلة تحتوي `variantIndex` الصحيح
- بعد `renderProducts()` الاختيار يبقى محفوظاً في DOM والـ state

---

### 5. عمليات الفئات تستخدم المفتاح العام مباشرةً (ثغرة أمنية)

**السبب:** `sbSaveCat()` و`sbDeleteCat()` كانتا ترسلان طلبات مباشرة لـ Supabase بـ `SB_KEY` العام — أي أحد يقرأ المصدر يستطيع تعديل/حذف الفئات.

**الحل:** توجيههما عبر `apiCall('save_category', ...)` و`apiCall('delete_category', ...)` في api.js خلف JWT auth.

**الكوميت:** `dff85f1`

---

## بنية السلة وإضافة المنتجات

### دورة الـ variant (بعد الإصلاح)

```
1. RENDER   → prodCard() ينشئ <select> مع selected من selectedVariants[pid]
2. USER     → يختار → onVarChange(pid, this) يكتب selectedVariants[pid]=N
3. CART ADD → varIdx(pid) = selectedVariants[pid] ?? 0  (لا DOM)
4. RE-RENDER → prodCard يُعيد رسم select مع نفس الاختيار من state
```

### `addToCart()` — بعد التحصين

```js
window.addToCart = function(id) {
  try {
    const p = byId(id);
    if (!p || (p.stock !== 'available' && p.stock !== 'available_nd' && p.stock !== 'preorder')) return;
    const hv = p.variants && p.variants.length > 0;
    const vi = hv ? safeVarIdx(p) : 0;         // safeVarIdx = clamp(0, vi, length-1)
    const variant = hv ? p.variants[vi] : null;
    const price = (variant && variant.price) || p.price || 0;
    const opt   = (variant && variant.name)  || '';
    // ... push to cart
  } catch(e) {
    console.error('[addToCart]', id, e);
    toast('حدث خطأ — حاول مجدداً');
  }
};
```

---

## صور المنتجات

### المسارات

| النوع | المسار |
|-------|-------|
| منتجات جديدة (رفع من الأدمن) | `https://glhmmrovxyijtzjaldtf.supabase.co/storage/v1/object/public/products/product-images/{timestamp}.{ext}` |
| منتجات قديمة مُهاجَرة (base64 → Storage) | `https://glhmmrovxyijtzjaldtf.supabase.co/storage/v1/object/public/products/og-migrated/{id}.{ext}` |
| منتجات افتراضية ثابتة (p1-p8) | `assets/products/{slug}.webp` |
| OG / Social | `https://redseairaq.com/logo.jpg` |

### ترحيل base64 (مؤقت)

- UI الترحيل في index.html: accordion `accMigration` + `window.runMigration`
- Backend: action `migrate_images_batch` في api.js (batch = 10)
- سكريبت بديل: `scripts/migrate-base64-images.js` (يحتاج `SB_SERVICE_KEY`)
- بعد `remaining_base64 = 0`: احذف UI + action + سكريبت

---

## كود مؤقت ينتظر الحذف

| العنصر | الملف | الشرط للحذف |
|--------|-------|------------|
| `accMigration` HTML | index.html | بعد `remaining_base64 = 0` |
| `window.runMigration` | index.html | نفسه |
| `migrate_images_batch` action | api.js | نفسه |
| `dbLog()` + استدعاءاتها | api.js | بعد التأكد من `triggerRebuild` يعمل |
| `_debug_log` table | Supabase | بعد حذف `dbLog()` |
| `products_image_backup` table | Supabase | اختياري — بعد التأكد من نجاح الترحيل |
| `scripts/migrate-base64-images.js` | / | بعد `remaining_base64 = 0` |

---

## RLS — تنبيهات أمنية مفتوحة

الجداول التالية لها سياسات RLS واسعة تحتاج مراجعة يدوية في Supabase Dashboard:

- `products`: public SELECT, INSERT, UPDATE, DELETE — خطر
- `categories`: public SELECT, INSERT, UPDATE, DELETE — خطر
- `orders`: public SELECT, INSERT — SELECT العام خطر

**الإصلاح المطلوب (يدوي في Supabase):** قصر INSERT/UPDATE/DELETE على `service_role` فقط. الأدمن يتصرف عبر api.js الذي يستخدم service key، ولا يحتاج تعديلاً.

---

## الهوية البصرية (مختصر) — النظام الأصلي (main / لوحة الإدارة)

```css
:root {
  --red: #c8202a;   --navy: #08111f;   --reef: #00b4c4;
  --pearl: #f4f7fb; --gold: #c9a84c;   --muted: #5d6b7e;
  --grad-red: linear-gradient(135deg, #c8202a 0%, #a01820 100%);
  --transition: .25s cubic-bezier(.4, 0, .2, 1);
}
```

**خطوط:** Tajawal (body) · Montserrat 900 (عناوين) · EB Garamond 700 (اسم العلامة)

**RTL:** العربية هي اللغة الأساسية. الموقع يدعم العربية والكردية والإنجليزية.

هذا النظام (فاتح) هو ما تزال تستخدمه **لوحة الإدارة** (`#page-admin-9x7k2`) دائماً — لم يُلمس عمداً أثناء إعادة التصميم أدناه.

---

## نظام التصميم الداكن — فرع `redesign-dark` (قيد المعاينة، لم يُدمج مع main بعد)

الصفحات العامة (كل شيء عدا لوحة الإدارة) أُعيد تصميمها بخلفية داكنة. هذا موثّق هنا حتى تعتمده الجلسات القادمة **إذا صار هذا الفرع هو `main`**؛ إلى أن يحصل الدمج، `main` ولوحة الإدارة يبقيان على النظام الفاتح أعلاه.

### الألوان

```css
:root {
  --bg-base:      #0A1220;
  --bg-surface:   #141F35;
  --bg-elevated:  #1E2C46;
  --border-subtle: rgba(255,255,255,0.08);
  --border-strong: rgba(255,255,255,0.16);
  --text-primary:   #F2F5FA;
  --text-secondary: #A8B4C8;
  --text-muted:     #6B7A94;
  --brand-red:      #E11D2E;   /* الشعار + الخط الفاصل تحت عناوين الأقسام فقط — ممنوع على أي زر */
  --action:         #1B6DF0;   /* اللون الوحيد المسموح للأزرار الأساسية */
  --action-hover:   #3A85FF;
  --success:        #2ECC71;
  --warning:        #F0A500;
  --shadow:         0 8px 24px rgba(0,0,0,.45); /* فقط: الهيدر الثابت، bottom-nav، النوافذ المنبثقة */
}
```

### الخط

`IBM Plex Sans Arabic` (400/600/700) — الخط الوحيد للموقع العام، عربي وإنجليزي معاً. `letter-spacing: normal` دائماً مع العربية.

⚠️ روابط Google Fonts القديمة (Tajawal/Montserrat/EB Garamond) **بقيت محمّلة عمداً** بجانب IBM Plex Sans Arabic — لوحة الإدارة (مودال تسجيل الدخول تحديداً) لا تزال تستخدم Montserrat صراحة، وحذف الاستيراد كان سيغيّر مظهرها دون لمس كودها مباشرة. إذا انتهى الترحيل الكامل للوحة الإدارة يوماً لنفس النظام الداكن، احذف هذي الاستيرادات القديمة وقلّص الرابط لثلاث أوزان IBM Plex فقط.

### مستويات الأزرار — قاعدة صارمة: زر أساسي واحد فقط في كل شاشة

```css
.btn, .btn-secondary  { background:transparent; color:var(--text-primary); border:1px solid var(--border-strong); }
.btn.primary, .btn-primary { background:var(--action); color:#fff; border:none; }
.btn.ghost, .btn-ghost { background:transparent; color:var(--text-muted); border:none; text-decoration:underline; }
```

الأساس `.btn` (بلا modifier) = ثانوي تلقائياً. أضف `.primary` لفعل واحد فقط بالشاشة. أضف `.ghost` للأفعال الجانبية/التدميرية (مشاركة، رجوع، إفراغ السلة، حذف).

### المسافات

مقياس مقصود: **4، 8، 12، 16، 24، 32، 48، 64px**. طُبّق حرفياً على كل عنصر أعيدت هيكلته في إعادة التصميم (بطاقات الفئات، صفوف السلة، meta-boxes، قوائم المميزات). المسافات القديمة في مكونات لم يُطلب إعادة هيكلتها (trust-strip الأصلي، hero-stats، إلخ) لم تُعاد كتابتها بالكامل — **الامتثال غير شامل 100% لكل قيمة مسافة بالملف**.

### الشكل والظل

- نصف قطر: بطاقات/حاويات `14px`، أزرار/حقول `10px`، شارات `6px` — عبر `--radius-card/--radius-control/--radius-badge`.
- **البطاقات بلا ظل نهائياً.** `box-shadow` يظهر فقط في: الهيدر الثابت، bottom-nav، الدرج الجانبي، النوافذ المنبثقة، وحلقات focus (استثناء مقصود لإتاحة الوصول).

### عزل لوحة الإدارة (تقنية مهمة لأي تعديل مستقبلي على الصفحات العامة)

الكثير من الأصناف مشتركة بين لوحة الإدارة والصفحات العامة (`.btn` `.input` `.select` `.textarea` `.panel` `.acc-section` وعائلتها)، وأكواد JS الخاصة بصفحات العملاء (دليل الأسماك، بانر الحجز المسبق...) تستخدم `style="color:var(--navy)"` inline مباشرة. الحل المطبّق:

```css
main, #bioModal {
  --navy:var(--text-primary); --muted:var(--text-muted); --red:var(--brand-red);
  --pearl:var(--bg-surface); --line:var(--border-subtle); /* ...إلخ */
}
#page-admin-9x7k2 {
  --navy:#08111f; --muted:#5d6b7e; --red:#c8202a; --pearl:#f4f7fb; --line:#e6ecf3; /* القيم الأصلية */
}
```

أي متغير قديم (`--navy` `--muted` `--red` `--pearl` `--line` `--line-soft` `--card` `--red-dark` `--red-bright` `--navy2`) يُعاد تدويره تلقائياً بهذي الطريقة. الأصناف المشتركة التي أعيد تعريفها بقيم **جديدة مباشرة** (وليس عبر المتغيرات القديمة) — `.btn` `.input/.select/.textarea` `.panel` وبعض حالات `.acc-*` — لها بلوك استرجاع صريح مكرّس بعنوان `ADMIN ISOLATION` قرب نهاية `<style>`. **أي كلاس جديد مشترك تضيفه لصفحة عامة، تحقق أولاً إذا تستخدمه لوحة الإدارة، وأضف استرجاعاً مماثلاً إذا لزم.**

### قيود معروفة (لم تُحلّ بالكامل)

- صور منتجات بخلفية بيضاء داخل ملف الصورة نفسه — لا يوجد حل CSS، يحتاج استبدال الصورة من المالك.
- أيقونات الفئات إيموجي مخزّنة كنص في `categories.icon` بقاعدة بيانات Supabase — ليست في الكود، ولا تُعدَّل قاعدة البيانات من هذا العمل.
- امتثال مقياس المسافات (4/8/12/16/24/32/48/64) غير شامل لكل قيمة بالملف — طُبّق على ما أُعيدت هيكلته فقط.
