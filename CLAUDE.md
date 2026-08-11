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
6. **الشبكة متاحة عبر proxy في بيئات الجلسات الحالية (Claude Code on the web)** — الاتصال بـSupabase عبر MCP وبـGitHub API عبر curl/fetch يعمل فعلياً (اختُبر). هذا قد يختلف بين البيئات (محلي مقابل remote، أو إعدادات مستقبلية) — تحقق فعلياً بأداة أو استعلام حقيقي بدل افتراض الحجب أو التوفر.
7. **Netlify MCP قد لا يكون متاحاً بكل جلسة** — رغم ربطه بحساب المالك ورغم أن `.claude/settings.json` يمنحه صلاحية تلقائية، قد لا يكون سيرفر Netlify MCP متصلاً فعلياً بجلسة معيّنة. تحقق ببحث فعلي عن الأداة قبل افتراض توفرها؛ إن لم تكن متاحة، تحقق حالة النشر يعود للمالك.
8. **ممنوع تعديل أسماء المنتجات نهائياً.** الأسماء يكتبها المالك وتحمل مواصفات جوهرية — قياسات الأحواض، وأهم صفة مميّزة لكل منتج. أي تغيير في اسم منتج يحتاج موافقة صريحة من المالك على كل منتج على حدة. تعليمة عامة مثل «وحّد الأسماء» لا تُعدّ إذناً. (خلفية: مهمة سابقة وحّدت تسمية 5 منتجات مكمّلات بلا إذن صريح لكل منتج — أُرجعت لاحقاً لأسمائها الأصلية، انظر أدناه.)

---

## نقاط الرجوع

| المعرّف | الوصف |
|---|---|
| `54eb498` | آخر حالة قبل التصميم الداكن — نقطة الرجوع الأساسية لو انكسر شيء بالتصميم الجديد |
| `4901241` | كوميت دمج التصميم الداكن مع `main` (merge commit — الأب الأول `54eb498`، الأب الثاني فرع التصميم الداكن) |

**التراجع عن الدمج بالكامل:**
```
git revert -m 1 4901241
```
يُعيد الشجرة لحالة `54eb498` بكوميت جديد يحافظ على السجل (لا حذف تاريخ، لا force-push).

**تنبيه — لا تعتمد على وسوم (tags) بين الجلسات:** دفع الوسوم لـ`origin` محجوب حالياً (403)، وبيئة التنفيذ نفسها تتجدد بين الجلسات فتفقد أي وسم محلي لم يُدفع. **اعتمد دائماً على معرّفات الكوميت (commit hashes) الثابتة أعلاه، لا على أسماء وسوم مفترَضة.**

**أسرع تراجع عن نشر مكسور (بدون git، فوري):** Netlify Dashboard → الموقع → **Deploys** → اختر آخر بناء ناجح سابق → **Publish deploy**. يُرجع الموقع المباشر فوراً بلا انتظار بناء جديد ومستقل تماماً عن حالة git — مناسب كإجراء طوارئ سريع قبل أو بدل `git revert`.

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

### قواعد كتابة أوصاف المنتجات (`description`)

**السبب:** مهمة سابقة تركت أوصاف منتجات بنص إجرائي مثل «تم العثور على المنتج على redseafish.com. إليك الوصف التسويقي...» — سرد لخطوات عمل بدل وصف حقيقي، ظاهر للزبائن على الموقع الحي. أُصلح ذلك (16 منتجاً، انظر الكوميت أدناه)؛ هذه القواعد لمنع تكرار الخطأ:

- الوصف نص تسويقي موجّه للزبون مباشرة، **جملة أو جملتان بحد أقصى**، عربية سليمة بالهمزات وعلامات الترقيم، يبدأ مباشرة بما يفعله المنتج.
- **ممنوع منعاً باتاً:** أي إشارة لمصدر/موقع/بحث/مرجع (تم/حسب/وفقاً/بناءً على/المصدر/وجدت/بحثت)، أي كلام عن كاتب الوصف أو خطواته، markdown (`**`, `---`, `>`)، إيموجي زخرفية، نص إنجليزي إلا اسم المنتج التجاري (رموز كيميائية كـ`KH`/`Ca`/`Mg` تُترجم عربياً في الوصف — "عسرة الكربونات"، "الكالسيوم"، "المغنيسيوم" — وتبقى بالاختصار الإنجليزي في **الاسم** فقط عند الحاجة للتمييز)، تكرار اسم المنتج داخل وصفه، أو أرقام/وعود غير مؤكدة.
- **إن لم يُعرف المنتج بما يكفي لوصف صحيح، يُترك الوصف فارغاً ويُذكر ذلك صراحة** — وصف فارغ أفضل من وصف مخترع. لم يحدث هذا فعلياً في إصلاح أغسطس 2026 (كل الأوصاف المتضررة كانت قابلة للوصف الواثق من اسم المنتج/فئته).
- **نطاق الإصلاح المُلزم عند مراجعة الأوصاف:** فارغ، أو "وصف المنتج." (placeholder)، أو مطابق حرفياً لاسم المنتج، أو يحتوي نصاً إجرائياً. أوصاف من نمط "منتج Red Sea أصلي — {الاسم الإنجليزي}" (موجودة في نحو 150 من ملحقات/قطع غيار Red Sea التقنية) **لم تُدرَج** ضمن هذا الإصلاح عمداً — قرار اتخذته الجلسة نفسها لتفادي تجاوز النطاق (`لا تتجاوز النطاق` في ضوابط العمل أعلاه)؛ هذه أوصاف قصيرة لكنها صادقة وغير مربكة، بخلاف النص الإجرائي. تحويلها لوصف تسويقي كامل لكل قطعة يحتاج قراراً منفصلاً من المالك بسبب الحجم (~150 منتجاً).
- عند وجود وصف "سليم" موجود مسبقاً (لا يقع ضمن نطاق الإصلاح الإلزامي أعلاه) لكنه يحتوي خطأ إملائياً واضحاً: صحّحه دون تغيير المعنى، ولا تُعد كتابته من الصفر.
- **النسخ الاحتياطية لجدول `products`:** `docs/products-backup-<YYYY-MM-DD>.json` (نسخة كاملة JSON لكل الأعمدة، كل الصفوف). أول نسخة بتاريخ 2026-08-11 قبل إصلاح الأوصاف — **هذه هي المرجع الوحيد لأسماء وأوصاف المنتجات الأصلية التي يملكها المالك**، لا تُستبدل ولا تُحذف. نسخة ثانية `docs/products-backup-2026-08-11-before-restore.json` أُخذت قبل استرجاع الأسماء (انظر أدناه) لتوثيق الحالة الوسيطة. خذ نسخة جديدة بنفس النمط قبل أي تعديل جماعي مستقبلي إن لم تكن هناك نسخة أحدث.

### تسمية منتجات المكمّلات — أُعيدت للأصل، لا تُعدَّل الأسماء بعد الآن

مهمة إصلاح الأوصاف (أعلاه) وحّدت أسماء 5 منتجات مكمّلات (عسرة/كالسيوم/مغنيسيوم) بنمط `{العنصر} ({الرمز}) — {وصف تفريقي} {الحجم}` **بلا إذن صريح من المالك على كل منتج** — تعليمة عامة («وحّد الأسماء المتضاربة») لا تكفي لتعديل حقل يملكه المالك ويحمل مواصفات جوهرية (قياسات/صفة مميزة). عند مراجعة لاحقة، تبيّن أن التوحيد حذف معلومات كان المالك كتبها بنفسه، فأُرجعت الأسماء الخمسة **حرفياً** لقيمتها الأصلية في `docs/products-backup-2026-08-11.json`:

| المعرّف | الاسم الحالي (الأصلي، بعد الاسترجاع) |
|---|---|
| `p1778009980521` | `Kh red sea 500ml عسره` |
| `p1778010089050` | `عسره لتحفيز نمو الكارولينا 500ml kh` |
| `p1778009899131` | `Mg مغنيسيوم 500ml` |
| `p1778009709492` | `كالسيوم سائل ٥٠٠ مل` |
| `p1782008005906` | `سيت عسره كالسيوم مغنيسيوم نصل لتر للبطل الواحد` |

**القاعدة الآن (انظر ضوابط العمل، البند ٨): ممنوع تعديل أي اسم منتج بلا موافقة صريحة من المالك على ذلك المنتج تحديداً.** الأوصاف (`description`) ليست مشمولة بهذا المنع — تبقى قابلة للتحسين وفق قواعد كتابة الأوصاف أعلاه.

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

## الهوية البصرية — النظام الموحّد (مدموج مع main، منشور على الإنتاج)

**تحديث:** بعد جلسة "إعادة بناء طبقة التنسيق"، لوحة الإدارة **لم تعد معزولة** — توحّدت مع نفس النظام الداكن أدناه (بلا استثناء تصميمي، فقط وظيفتها ووضوحها مضمونان). **الدمج مع `main` تم فعلياً بكوميت `4901241`** وهذا النظام هو المنشور حالياً على redseairaq.com. نقطة الرجوع لما قبل الدمج: `54eb498` (انظر قسم "نقاط الرجوع" أعلاه).

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
  --accent-cyan:       #22D3EE;  /* حصراً لقسم PRODIBIO — بديل --action داخل ذلك القسم فقط */
  --accent-cyan-hover: #5ce4f5;
  --shadow:         0 8px 24px rgba(0,0,0,.45); /* فقط: الهيدر الثابت، bottom-nav، الدرج الجانبي، النوافذ المنبثقة */
}
```

### المتغيرات القديمة — لا تُحذف، مربوطة بالنظام الجديد

الكثير من قوالب JS (دليل الأسماك، بانر الحجز المسبق، شاشات الأدمن...) تكتب `style="color:var(--navy)"` وأمثالها inline مباشرة — تعديلها يعني لمس منطق JS، وهو ممنوع بأغلب المهام. لذا كل متغير قديم بقي معرّفاً في `:root` لكن **مربوطاً بمتغير النظام الجديد المكافئ**، وليس بقيمة حرفية قديمة:

| المتغير القديم | مربوط بـ | لماذا |
|---|---|---|
| `--navy`, `--ink` | `var(--text-primary)` | استُخدم 53 مرة كـ`color:` مقابل 4 فقط كـ`background:` |
| `--ink2` | `var(--text-secondary)` | نص ثانوي دائماً |
| `--muted` | `var(--text-muted)` | نص دائماً (73/73) |
| `--pearl`, `--navy2` | `var(--bg-elevated)` | خلفية دائماً (29/29 لـ`--pearl`) |
| `--card` | `var(--bg-surface)` | خلفية بطاقة |
| `--line`, `--line-soft` | `var(--border-subtle)` | حدود دائماً |
| `--red`, `--red-bright`, `--red-dark`, `--red-deep` | `var(--brand-red)` | كل درجات الأحمر توحّدت بواحدة |
| `--gold`, `--gold-soft` | `var(--warning)` | نفس عائلة اللون الذهبي/الكهرماني |
| `--reef`, `--reef-glow` | `var(--accent-cyan)` | القيمة الأصلية (#00b4c4) كانت أصلاً قريبة من السماوي الجديد |
| `--ocean`, `--teal` | `var(--action)` | أزرق باهت قديم → أزرق الفعل |
| `--ocean-deep` | `var(--action-hover)` | — |
| `--shadow-hard`, `--shadow-soft`, `--shadow-glow` | `none` | البطاقات بلا ظل بالنظام الجديد |
| `--shadow-red` | قيمة توهج حرفية جديدة (`rgba(225,29,46,...)`) | تُستخدم داخل `@keyframes pulseRed` المحفوظة كما هي |

**قاعدة حاسمة عند فحص أي متغير قديم:** لا تخمّن الربط — افحص هل استخدامه الفعلي أغلبه `color:` (نص) أم `background:` (خلفية) قبل تقرير أي متغير جديد يُربط به. الخلط هنا يعني نص غير مرئي.

### الخط

`IBM Plex Sans Arabic` (400/600/700) فقط — **للموقع كله بما فيه لوحة الإدارة**. لا Tajawal، لا Montserrat، لا EB Garamond، لا Noto Sans Arabic. `letter-spacing: normal` دائماً مع العربية.

### مستويات الأزرار — قاعدة صارمة: زر أساسي واحد فقط في كل شاشة

```css
.btn, .btn-secondary  { background:transparent; color:var(--text-primary); border:1px solid var(--border-strong); }
.btn.primary, .btn-primary { background:var(--action); color:#fff; border:none; }
.btn.ghost, .btn-ghost { background:transparent; color:var(--text-muted); border:none; text-decoration:underline; }
```

الأساس `.btn` (بلا modifier) = ثانوي تلقائياً. أضف `.primary` لفعل واحد فقط بالشاشة. أضف `.ghost` للأفعال الجانبية/التدميرية (مشاركة، رجوع، إفراغ السلة، حذف). زر واتساب بالسلة = الزر الأساسي الوحيد بتلك الشاشة، بعرض كامل وارتفاع 52px كحد أدنى.

### المسافات

مقياس مقصود: **4، 8، 12، 16، 24، 32، 48، 64px**. مطبّق على كل قيمة مسافة على مستوى الأقسام والبطاقات (حشو البطاقة 20px، بين البطاقات 12px، بين الأقسام 64px، إلخ). **غير شامل 100%** لكل مسافة صغيرة موروثة من التصميم الأصلي (حشو الأيقونات الصغيرة، الشارات، الفجوات دون 16px) — هذي تُركت بقيمها الأصلية لأن تقريبها بلا معاينة بصرية فعلية قد يكسر تناسق عناصر صغيرة لا يمكن التحقق منها بالكود وحده.

استثناءات مسموحة لا تُقرَّب: `env(safe-area-inset-bottom)`, `calc()` المرتبط بارتفاع عنصر ثابت (حشوة bottom-nav)، والنسب المئوية.

### الشكل والظل

- نصف قطر: بطاقات/حاويات `14px`، أزرار/حقول `10px`، شارات `6px` — عبر `--radius-card/--radius-control/--radius-badge`. حاوية صورة المنتج بالبطاقة استثناء صريح: `10px` (مذكور حرفياً بأمر التصميم).
- **البطاقات بلا ظل نهائياً — لوحة الإدارة أيضاً.** `box-shadow` يظهر فقط في: الهيدر الثابت، bottom-nav، الدرج الجانبي، النوافذ المنبثقة (بما فيها مودال تسجيل دخول الأدمن)، وحلقات focus (استثناء مقصود لإتاحة الوصول، عبر `:focus-visible{outline:2px solid var(--action);outline-offset:2px}` على كل حقل وزر).

### مساحات اللمس

كل عنصر قابل للنقر: `min-height`/مساحة فعّالة `44px` على الأقل. حيث المظهر المرئي أصغر (أزرار الكمية بالسلة)، وُسّعت مساحة النقر عبر `::before` غير مرئي بدل تكبير الشكل.

### الأدوات المرئية على شاشات كبيرة (حاسوب)

نقاط التوقّف وعدد أعمدة كل شبكة **لم تتغيّر** عن التصميم الأصلي. الإضافة الوحيدة: `@media(min-width:1081px)` يكبّر عنوان البطل (34→48px) وعنوان القسم (26→32px) فقط — بقية النصوص وكل الأعمدة كما هي على الحاسوب.

### PRODIBIO

قسم مستقل (`#page-prodibio` وعائلة `.pb-*`) — توحّد مع نظام الألوان/الخط العام، لكن `--accent-cyan`/`--accent-cyan-hover` يستبدلان `--action` كلون تمييز خاص بهذا القسم فقط (بدل الأزرق العام)، حفاظاً على هويته البصرية المميزة.

### قيود معروفة (لم تُحلّ بالكامل)

- صور منتجات بخلفية بيضاء داخل ملف الصورة نفسه — لا يوجد حل CSS، يحتاج استبدال الصورة من المالك.
- امتثال مقياس المسافات (4/8/12/16/24/32/48/64) غير شامل لكل قيمة صغيرة بالملف — طُبّق على مستوى الأقسام/البطاقات فقط، للأسباب الموضحة أعلاه.
- نسخة احتياطية من الـ CSS القديم (قبل التطبيع) محفوظة في `docs/css-legacy-backup.txt` للرجوع إليها عند الحاجة لفهم سلوك قاعدة قديمة.
- **معرّفات الفئات تأتي من Supabase دائماً — لا تُكتب يدوياً أبداً.** أي مصفوفة/كائن بالكود يحتاج معرّف فئة (`category.id`) يجب أن يُبنى من `CATS` المُحمَّلة فعلياً (أو يُتحقَّق أعضاؤه منها في وقت التشغيل)، وليس بنسخ أسماء تبدو منطقية يدوياً. هذا الخلل بالذات ضرب `homeCats` (أُصلح — انظر أدناه)، وما زال موجوداً بموضعين لم يُصلَحا بعد لأنهما خارج نطاق أي أمر طُلب حتى الآن:
  - `const SUGG_MAP` (~2510)، تُستخدم بصفحة المتجر وصفحة تفاصيل المنتج: خريطة "فئات ذات صلة" بمعرّفات قديمة — 7 من 13 فئة حقيقية لا تُظهر أي اقتراح بسببها.
  - `DEFAULT_CAT_IDS` و`saveCustomCats()`: تصنيف "افتراضي مقابل مخصّص" بلوحة إدارة الفئات بالأدمن — تصنيف معلوماتي خاطئ لـ7 فئات، لا يمنع أي وظيفة.
- `renderHome()` / `homeCats` — **أُصلح** (كوميت `4adaddc`). كانت تستخدم معرّفات قديمة غير مطابقة (`tanks`, `food`, `rocks`, ...)؛ استُبدلت بالمعرّفات الحقيقية، وحُذف `rocks` (لا فئة مقابلة له إطلاقاً) و`test` (غامض، يكرر فئة `tools` المُغطاة أصلاً). أُضيف `console.warn` عند أي معرّف بـ`homeCats` غير موجود ضمن `CATS` المُحمَّلة، وأُضيفت تعبئة احتياطية من بقية الفئات المرئية مرتبة تنازلياً بعدد منتجاتها إن نقصت المطابقة المباشرة عن 6 — بدل الوقوع على قائمة منتجات عشوائية بلا تنويع فئات.

### لا بيانات وهمية خارج Supabase — CATS وDEF_PRODUCTS (أُصلح نهائياً)

**مبدأ حاكم:** ممنوع عرض أي فئة أو منتج للزبون لم يأتِ فعلياً من Supabase. لا مصفوفات احتياطية بأسماء/أسعار/معرّفات مكتوبة يدوياً في `index.html`.

- `let CATS=[...]` (12 فئة بمعرّفات قديمة غير مطابقة إطلاقاً لمعرّفات Supabase الحقيقية) و`const DEF_PRODUCTS=[...]` (8 منتجات وهمية) **حُذفتا نهائياً**. الآن: `let CATS=[];` و`products` تُهيَّأ من `localStorage['rsi_prods']` إن كان صالحاً وإلا `[]` — لا قيمة احتياطية مكتوبة يدوياً بعد الآن.
- زر لوحة الأدمن `استرجاع الأصلية` ودالته `resetProductsToDefault()` حُذفا معه — كانا يستبدلان `products` محلياً بـ`DEF_PRODUCTS` (لا يكتبان لـ Supabase، لكنهما يُظهران بيانات وهمية للأدمن نفسه، وهذا يخالف نفس المبدأ).
- **الحالة الفارغة الصادقة:** إن فشلت `syncFromSupabase()` (لا اتصال) ولا يوجد cache صالح في `localStorage`، فإن `CATS` و/أو `products` تبقى فارغتين. `renderHome()` و`renderProducts()` و`renderCategoriesPage()` تتحقق من الطول الفعلي (`CATS.length` / `products.length`) وتعرض `shopEmptyStateHtml()` بدل البيانات — رسالة تحذير (⚠️) + نص "تحقّق من اتصالك بالإنترنت وحاول مجدداً" (مفتاح ترجمة `shop_retry_hint`، متوفر بالعربية والإنجليزية والكردية) + زر `🔄 إعادة التحميل` يستدعي `window.retryShopLoad()` الذي يُعيد `syncFromSupabase()` ثم يُعيد رسم الصفحة الحالية. النمط مبني على نفس أسلوب حالة خطأ تحميل بيانات التعليم الموجودة أصلاً (`retryEducationLoad` / `edu_error_load`).
- **الكوميت:** فرع `claude/cleanup-product-descriptions-pklosx`، كوميت `4ec01f4`.

### أيقونات الفئات (`CAT_ICONS`)

- مجموعة SVG خطية من مكتبة Lucide (ISC License)، معرّفة في `index.html` بعد ~2445، مفاتيحها مطابقة **حرفياً** لمعرّفات فئات Supabase الـ13 الحقيقية (`salt`, `supplements`, `filtration`, `tools`, `control`, `probidio`, `cat_tanks`, `cat_lighting`, `cat_1777829753816`, `cat_1778361718370`, `cat_1782669820912`, `cat_1777422837524`, `colors`).
- لا يوجد fallback على إيموجي `categories.icon` — إن لم يوجد مفتاح مطابق تظهر البطاقة بلا أيقونة (فراغ أفضل من رمز مكرر/غير متسق). عمود `categories.icon` بقاعدة البيانات لم يُعدَّل ولا يُستخدَم في العرض.
- تم التحقق برمجياً: 13 مفتاح فريد، لا تكرار في مسارات SVG، كل عنصر يحوي `viewBox` وعلامات متوازنة.

### عدّاد المنتجات بالفئة وإخفاء الفئات الفارغة

- `catVisibleCount(c)` تُحسب من `products.filter(p=>!p.hidden&&p.category===c.id)` — العدّاد المعروض للزبون لا يشمل المنتجات المخفية أبداً.
- `visibleCats()` تُستخدم بدل `CATS` الخام في: صفحة الفئات (`renderCategoriesPage`)، معاينة الرئيسية (`renderHome`)، وقائمة فلتر المتجر (`renderCatSelects` → `#categoryFilter`). أي فئة بلا منتجات مرئية لا تظهر بهذه الثلاثة أماكن.
- قائمة فئة الأدمن (`#adminCategory`) تبقى عمداً على `CATS` الكاملة — الأدمن يحتاج تعيين منتج لأي فئة حتى لو فارغة/مخفية حالياً.
- وصف بطاقة الفئة يُخفى إذا كان مكرراً لاسمها، عبر نفس `descIsDup()` المستخدمة ببطاقات المنتج.
