/**
 * api.js — Red Sea Iraq · Secure API Gateway
 * كل العمليات الحساسة تمر من هنا فقط
 * المتغيرات السرية في Netlify Environment Variables حصراً
 *
 * Actions المدعومة:
 *   login          → تحقق من كلمة المرور وأرجع JWT
 *   save_product   → حفظ/تعديل منتج (يحتاج auth)
 *   toggle_hide    → إخفاء/إظهار منتج (يحتاج auth)
 *   delete_product → حذف منتج (يحتاج auth)
 *   save_order     → حفظ طلب جديد (عام — من الزوار)
 *   get_orders     → جلب الطلبات (يحتاج auth)
 *   update_order   → تحديث حالة طلب (يحتاج auth)
 *   save_blog      → حفظ مقال (يحتاج auth)
 *   delete_blog    → حذف مقال (يحتاج auth)
 *   sync           → جلب المنتجات والفئات (عام)
 */

const crypto = require('crypto');

/* ── helpers ── */
const SB_URL = process.env.SUPABASE_URL || 'https://glhmmrovxyijtzjaldtf.supabase.co';
const SB_SERVICE_KEY = process.env.SB_SERVICE_KEY; /* service_role key — لا يُكشف أبداً */
const ADMIN_PASS_HASH = process.env.ADMIN_PASS_HASH; /* sha256 لكلمة المرور */
const JWT_SECRET = process.env.JWT_SECRET; /* سر توقيع الـ tokens */
const BUILD_HOOK = process.env.NETLIFY_BUILD_HOOK;

function triggerRebuild() {
  if (!BUILD_HOOK) { console.log('[rebuild] NETLIFY_BUILD_HOOK not set — skipped'); return; }
  fetch(BUILD_HOOK, { method: 'POST' })
    .then(r => console.log('[rebuild] hook fired, status:', r.status))
    .catch(e => console.error('[rebuild] hook error:', e.message));
}

const ALLOWED_ORIGINS = [
  'https://redseairaq.com',
  'https://www.redseairaq.com',
  'http://localhost',
  'http://127.0.0.1',
  'null' /* file:// للتطوير المحلي */
];

/* ── CORS headers ── */
function corsHeaders(origin) {
  const allowed = ALLOWED_ORIGINS.includes(origin) ? origin : ALLOWED_ORIGINS[0];
  return {
    'Access-Control-Allow-Origin' : allowed,
    'Access-Control-Allow-Headers': 'Content-Type, Authorization',
    'Access-Control-Allow-Methods': 'POST, OPTIONS',
    'Content-Type': 'application/json'
  };
}

/* ── SHA-256 ── */
function sha256(str) {
  return crypto.createHash('sha256').update(str, 'utf8').digest('hex');
}

/* ── JWT بسيط بدون مكتبات خارجية ── */
function signToken(payload) {
  const header  = Buffer.from(JSON.stringify({ alg: 'HS256', typ: 'JWT' })).toString('base64url');
  const body    = Buffer.from(JSON.stringify(payload)).toString('base64url');
  const sig     = crypto.createHmac('sha256', JWT_SECRET).update(`${header}.${body}`).digest('base64url');
  return `${header}.${body}.${sig}`;
}

function verifyToken(token) {
  try {
    const [header, body, sig] = token.split('.');
    const expected = crypto.createHmac('sha256', JWT_SECRET).update(`${header}.${body}`).digest('base64url');
    if (sig !== expected) return null;
    const payload = JSON.parse(Buffer.from(body, 'base64url').toString());
    if (payload.exp < Date.now()) return null; /* منتهي الصلاحية */
    return payload;
  } catch { return null; }
}

/* ── Supabase fetch ── */
async function sb(method, path, body) {
  const res = await fetch(`${SB_URL}/rest/v1${path}`, {
    method,
    headers: {
      'apikey'       : SB_SERVICE_KEY,
      'Authorization': `Bearer ${SB_SERVICE_KEY}`,
      'Content-Type' : 'application/json',
      'Prefer'       : 'resolution=merge-duplicates,return=minimal'
    },
    body: body ? JSON.stringify(body) : undefined
  });
  if (!res.ok) {
    const err = await res.json().catch(() => ({}));
    throw new Error(err?.message || `Supabase HTTP ${res.status}`);
  }
  const text = await res.text();
  return text ? JSON.parse(text) : null;
}

/* ── Rate limiting بسيط في الذاكرة ── */
const attempts = new Map();
function checkRateLimit(ip) {
  const now = Date.now();
  const rec = attempts.get(ip) || { count: 0, until: 0 };
  if (now < rec.until) return { blocked: true, secs: Math.ceil((rec.until - now) / 1000) };
  if (rec.count >= 5) {
    attempts.set(ip, { count: 0, until: now + 60000 });
    return { blocked: true, secs: 60 };
  }
  return { blocked: false };
}
function recordFail(ip) {
  const rec = attempts.get(ip) || { count: 0, until: 0 };
  attempts.set(ip, { ...rec, count: rec.count + 1 });
}
function clearFail(ip) { attempts.delete(ip); }

/* ════════════════════════════════
   MAIN HANDLER
════════════════════════════════ */
exports.handler = async function(event) {
  const origin = event.headers.origin || event.headers.Origin || 'null';
  const headers = corsHeaders(origin);

  /* Preflight */
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers, body: '' };
  if (event.httpMethod !== 'POST')    return { statusCode: 405, headers, body: JSON.stringify({ error: 'Method not allowed' }) };

  /* تحقق من أن المتغيرات موجودة */
  if (!SB_URL || !SB_SERVICE_KEY || !ADMIN_PASS_HASH || !JWT_SECRET) {
    console.error('Missing env vars. Required: SB_SERVICE_KEY, ADMIN_PASS_HASH, JWT_SECRET');
    return { statusCode: 500, headers, body: JSON.stringify({ error: 'Server misconfigured' }) };
  }

  let body;
  try { body = JSON.parse(event.body || '{}'); }
  catch { return { statusCode: 400, headers, body: JSON.stringify({ error: 'Invalid JSON' }) }; }

  const { action } = body;
  const ip = event.headers['x-forwarded-for']?.split(',')[0]?.trim() || 'unknown';

  /* ── عمليات لا تحتاج auth ── */

  /* LOGIN */
  if (action === 'login') {
    const rl = checkRateLimit('login_' + ip);
    if (rl.blocked) return res(headers, 429, { error: `محاولات كثيرة — انتظر ${rl.secs} ثانية` });

    const { password } = body;
    if (!password) return res(headers, 400, { error: 'كلمة المرور مطلوبة' });

    const hash = sha256(password);
    if (hash !== ADMIN_PASS_HASH) {
      recordFail('login_' + ip);
      return res(headers, 401, { error: 'كلمة المرور غير صحيحة' });
    }

    clearFail('login_' + ip);
    const token = signToken({ role: 'admin', iat: Date.now(), exp: Date.now() + 4 * 60 * 60 * 1000 }); /* 4 ساعات */
    return res(headers, 200, { token });
  }

  /* SAVE ORDER — من الزوار */
  if (action === 'save_order') {
    const { order } = body;
    if (!order?.id) return res(headers, 400, { error: 'بيانات الطلب ناقصة' });
    try {
      await sb('POST', '/orders', {
        id: order.id, customer_phone: order.ph, customer_city: order.city,
        customer_area: order.area, customer_notes: order.notes || '',
        items: JSON.stringify(order.items), subtotal: order.sub,
        delivery: order.del, total: order.tot, status: 'new',
        created_at: new Date().toISOString()
      });
      return res(headers, 200, { ok: true });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* SYNC — قراءة عامة */
  if (action === 'sync') {
    try {
      const [products, categories, blog, reference] = await Promise.all([
        sb('GET', '/products?order=sort_order.asc,created_at.desc&limit=500', null),
        sb('GET', '/categories?order=sort_order.asc&limit=100', null),
        sb('GET', '/blog_posts?order=created_at.desc&limit=100&select=id,slug,title,excerpt,category,tags,image_url,created_at', null),
        sb('GET', '/reference_topics?order=sort_order.asc,created_at.desc&limit=200&select=id,slug,title,excerpt,category,tags,image,hidden,product_links,created_at,updated_at', null)
      ]);
      return res(headers, 200, { products: products||[], categories: categories||[], blog: blog||[], reference: reference||[] });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* ════════════════════════════════
     من هنا — كل شيء يحتاج AUTH
  ════════════════════════════════ */
  const authHeader = event.headers.authorization || event.headers.Authorization || '';
  const token = authHeader.replace('Bearer ', '').trim();
  const payload = token ? verifyToken(token) : null;

  if (!payload || payload.role !== 'admin') {
    return res(headers, 401, { error: 'غير مصرح — يرجى تسجيل الدخول' });
  }

  /* SAVE PRODUCT */
  if (action === 'save_product') {
    const { item } = body;
    if (!item?.id || !item?.name) return res(headers, 400, { error: 'بيانات المنتج ناقصة' });
    try {
      await sb('POST', '/products', {
        id: item.id, category: item.category, name: item.name,
        price: item.price, currency: item.currency || 'IQD',
        badge: item.badge || '', stock: item.stock,
        image: item.image || '', description: item.desc || '',
        hidden: !!item.hidden,
        specs: JSON.stringify(item.specs || []),
        variants: JSON.stringify(item.variants || []),
        updated_at: new Date().toISOString()
      });
      triggerRebuild();
      return res(headers, 200, { ok: true });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* UPLOAD PRODUCT IMAGE */
  if (action === 'upload_product_image') {
    const { data } = body;
    if (!data || !data.startsWith('data:')) return res(headers, 400, { error: 'بيانات الصورة غير صالحة' });
    const commaIdx = data.indexOf(',');
    if (commaIdx === -1) return res(headers, 400, { error: 'تنسيق data URI غير صحيح' });
    const header  = data.slice(0, commaIdx);
    const b64     = data.slice(commaIdx + 1);
    const mimeMatch = header.match(/data:([^;]+)/);
    const mime    = mimeMatch ? mimeMatch[1].toLowerCase() : 'image/webp';
    const ext     = mime === 'image/png' ? 'png' : mime === 'image/jpeg' ? 'jpg' : 'webp';
    const filename = `product-images/${Date.now()}.${ext}`;
    const buffer  = Buffer.from(b64, 'base64');
    try {
      const upRes = await fetch(`${SB_URL}/storage/v1/object/products/${filename}`, {
        method: 'POST',
        headers: {
          apikey:          SB_SERVICE_KEY,
          Authorization:   `Bearer ${SB_SERVICE_KEY}`,
          'Content-Type':  mime,
          'x-upsert':      'true'
        },
        body: buffer
      });
      if (!upRes.ok) {
        const err = await upRes.text();
        throw new Error(`Storage ${upRes.status}: ${err.slice(0, 200)}`);
      }
      const url = `${SB_URL}/storage/v1/object/public/products/${filename}`;
      return res(headers, 200, { url });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* TOGGLE HIDE */
  if (action === 'toggle_hide') {
    const { id, hidden } = body;
    if (!id) return res(headers, 400, { error: 'id مطلوب' });
    try {
      await sb('PATCH', `/products?id=eq.${encodeURIComponent(id)}`, {
        hidden: !!hidden, updated_at: new Date().toISOString()
      });
      return res(headers, 200, { ok: true });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* DELETE PRODUCT */
  if (action === 'delete_product') {
    const { id } = body;
    if (!id) return res(headers, 400, { error: 'id مطلوب' });
    try {
      await sb('DELETE', `/products?id=eq.${encodeURIComponent(id)}`, null);
      return res(headers, 200, { ok: true });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* GET ORDERS */
  if (action === 'get_orders') {
    try {
      const orders = await sb('GET', '/orders?order=created_at.desc&limit=50', null);
      return res(headers, 200, { orders: orders || [] });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* UPDATE ORDER STATUS */
  if (action === 'update_order') {
    const { id, status } = body;
    const validStatuses = ['new', 'preparing', 'shipped', 'delivered', 'cancelled'];
    if (!id || !validStatuses.includes(status)) return res(headers, 400, { error: 'بيانات غير صحيحة' });
    try {
      await sb('PATCH', `/orders?id=eq.${encodeURIComponent(id)}`, {
        status, updated_at: new Date().toISOString()
      });
      return res(headers, 200, { ok: true });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* SAVE BLOG */
  if (action === 'save_blog') {
    const { post } = body;
    if (!post?.id || !post?.title) return res(headers, 400, { error: 'بيانات المقال ناقصة' });
    try {
      await sb('POST', '/blog_posts', {
        id: post.id, slug: post.slug, title: post.title,
        excerpt: post.excerpt || '', content: post.content || '',
        category: post.category || 'عام',
        tags: JSON.stringify(post.tags || []),
        image_url: post.image_url || '',
        published: post.published !== false,
        created_at: post.created_at || new Date().toISOString(),
        updated_at: new Date().toISOString()
      });
      return res(headers, 200, { ok: true });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* DELETE BLOG */
  if (action === 'delete_blog') {
    const { id } = body;
    if (!id) return res(headers, 400, { error: 'id مطلوب' });
    try {
      await sb('DELETE', `/blog_posts?id=eq.${encodeURIComponent(id)}`, null);
      return res(headers, 200, { ok: true });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* SAVE REFERENCE TOPIC */
  if (action === 'save_reference') {
    const { topic } = body;
    if (!topic?.id || !topic?.title) return res(headers, 400, { error: 'بيانات الموضوع ناقصة' });
    try {
      await sb('POST', '/reference_topics', {
        id: topic.id, slug: topic.slug || topic.id,
        title: topic.title, excerpt: topic.excerpt || '',
        content_markdown: topic.content_markdown || '',
        category: topic.category || 'عام',
        tags: JSON.stringify(topic.tags || []),
        related_topics: JSON.stringify(topic.related_topics || []),
        image: topic.image || '',
        product_links: JSON.stringify(topic.product_links || []),
        seo_title: topic.seo_title || topic.title,
        meta_description: topic.meta_description || topic.excerpt || '',
        hidden: !!topic.hidden,
        sort_order: topic.sort_order || 0,
        created_at: topic.created_at || new Date().toISOString(),
        updated_at: new Date().toISOString()
      });
      return res(headers, 200, { ok: true });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* DELETE REFERENCE TOPIC */
  if (action === 'delete_reference') {
    const { id } = body;
    if (!id) return res(headers, 400, { error: 'id مطلوب' });
    try {
      await sb('DELETE', `/reference_topics?id=eq.${encodeURIComponent(id)}`, null);
      return res(headers, 200, { ok: true });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* SAVE FISH FAMILY */
  if (action === 'save_fish_family') {
    const { family } = body;
    if (!family?.id) return res(headers, 400, { error: 'id العائلة مطلوب' });
    try {
      await sb('POST', '/fish_families', {
        id: family.id, name_ar: family.name_ar,
        name_en: family.name_en || '', name_ku: family.name_ku || '',
        cover_image_url: family.cover_image_url ?? null,
        sort_order: family.sort_order ?? 0,
        created_at: family.created_at || new Date().toISOString()
      });
      return res(headers, 200, { ok: true });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* PATCH FISH FAMILY — update only name_ar / name_ku */
  if (action === 'patch_fish_family') {
    const { id, name_ar, name_ku, cover_image_url, sort_order } = body;
    if (!id) return res(headers, 400, { error: 'id مطلوب' });
    const patch = {};
    if (name_ar          !== undefined) patch.name_ar          = name_ar;
    if (name_ku          !== undefined) patch.name_ku          = name_ku;
    if (cover_image_url  !== undefined) patch.cover_image_url  = cover_image_url;
    if (sort_order       !== undefined) patch.sort_order       = sort_order;
    if (!Object.keys(patch).length) return res(headers, 400, { error: 'لا توجد حقول للتحديث' });
    try {
      await sb('PATCH', `/fish_families?id=eq.${encodeURIComponent(id)}`, patch);
      return res(headers, 200, { ok: true });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* DELETE FISH FAMILY */
  if (action === 'delete_fish_family') {
    const { id } = body;
    if (!id) return res(headers, 400, { error: 'id مطلوب' });
    try {
      await sb('DELETE', `/fish_families?id=eq.${encodeURIComponent(id)}`, null);
      return res(headers, 200, { ok: true });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* GET FISH FAMILIES */
  if (action === 'get_fish_families') {
    try {
      const data = await sb('GET', '/fish_families?select=*&order=created_at.asc&limit=200', null);
      return res(headers, 200, { families: data || [] });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* SAVE FISH CARD */
  if (action === 'save_fish_card') {
    const { card } = body;
    if (!card?.id) return res(headers, 400, { error: 'id السمكة مطلوب' });
    try {
      await sb('POST', '/fish_cards', {
        id: card.id, family_id: card.family_id || null,
        common_name_ar: card.common_name_ar || '', common_name_en: card.common_name_en || '',
        common_name_ku: card.common_name_ku || '', scientific_name: card.scientific_name || '',
        care_level: card.care_level || 'medium', diet: card.diet || 'omnivore',
        reef_safe: card.reef_safe || 'caution', notes: card.notes || '',
        image_url: card.image_url || null,
        created_at: card.created_at || new Date().toISOString()
      });
      return res(headers, 200, { ok: true });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* DELETE FISH CARD */
  if (action === 'delete_fish_card') {
    const { id } = body;
    if (!id) return res(headers, 400, { error: 'id مطلوب' });
    try {
      await sb('DELETE', `/fish_cards?id=eq.${encodeURIComponent(id)}`, null);
      return res(headers, 200, { ok: true });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* ENRICH FISH CARD — patch only enriched fields, preserves all others */
  if (action === 'enrich_fish_card') {
    const { id, care_level, diet, reef_safe, image_url, notes, needs_review, is_visible } = body;
    if (!id) return res(headers, 400, { error: 'id مطلوب' });
    try {
      const patch = {};
      if (care_level   !== undefined) patch.care_level   = care_level;
      if (diet         !== undefined) patch.diet         = diet;
      if (reef_safe    !== undefined) patch.reef_safe    = reef_safe;
      if (image_url    !== undefined) patch.image_url    = image_url;
      if (notes        !== undefined) patch.notes        = notes;
      if (needs_review !== undefined) patch.needs_review = needs_review;
      if (is_visible   !== undefined) patch.is_visible   = is_visible;
      if (!Object.keys(patch).length) return res(headers, 400, { error: 'لا توجد حقول للتحديث' });
      await sb('PATCH', `/fish_cards?id=eq.${encodeURIComponent(id)}`, patch);
      return res(headers, 200, { ok: true });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* ENRICH FISH CARD AI — Claude + web_search to extract care data */
  if (action === 'enrich_fish_card_ai') {
    const ANTHROPIC_KEY = process.env.ANTHROPIC_API_KEY;
    if (!ANTHROPIC_KEY) return res(headers, 500, { error: 'ANTHROPIC_API_KEY غير مضبوط' });

    const { common_name_en, scientific_name } = body;
    if (!common_name_en && !scientific_name)
      return res(headers, 400, { error: 'common_name_en أو scientific_name مطلوب' });

    const VALID_CARE = new Set(['easy', 'medium', 'hard']);
    const VALID_DIET = new Set(['carnivore', 'herbivore', 'omnivore']);
    const VALID_REEF = new Set(['reef_safe', 'caution', 'with_caution', 'no']);

    const systemPrompt =
`You are a marine biology and aquarium expert with deep knowledge of reef fish care.

SEARCH STRATEGY (search by scientific name for accuracy):
1. Search Wikimedia Commons for a species image: "site:commons.wikimedia.org ${scientific_name || common_name_en}" — find a direct image URL (must end in .jpg, .jpeg, or .png from upload.wikimedia.org)
2. If no Wikimedia image found, try iNaturalist: "${scientific_name || common_name_en} site:inaturalist.org" — get a photo URL
3. Search for care info: "${scientific_name || common_name_en} aquarium care reef safe" — get hobbyist requirements

IMAGE RULES:
- image_url must be a direct hotlink-friendly URL (upload.wikimedia.org preferred, or inaturalist.org)
- DO NOT use fishbase.se image URLs — they block hotlinking
- If no reliable direct image URL found, return null for image_url

CLASSIFICATION RULES:
- care_level: "easy" = hardy and forgiving for beginners | "medium" = needs some experience | "hard" = expert only
- diet: "carnivore" = eats live/frozen meaty foods | "herbivore" = primarily algae/plant-based | "omnivore" = accepts both
- reef_safe: "reef_safe" = completely safe with corals and invertebrates | "caution" = generally ok but watch inverts | "with_caution" = known to nip corals | "no" = will destroy corals or eat invertebrates
- notes_en: 3-5 sentences covering max adult size, minimum tank size, behavior, feeding, and reef compatibility notes

CRITICAL: Use your expert marine biology knowledge to fill in values you are confident about. Only return {"not_found":true} for species so obscure you have no information at all.

Return ONLY valid JSON: {"care_level":"...","diet":"...","reef_safe":"...","image_url":"...or null","notes_en":"..."}`;

    const userContent = scientific_name
      ? `Scientific name: ${scientific_name}${common_name_en ? `\nCommon name: ${common_name_en}` : ''}\n\nSearch FishBase for this species by scientific name, then search for aquarium care info. Return JSON.`
      : `Common name: ${common_name_en}\n\nSearch for aquarium care info for this species. Return JSON.`;

    const callClaude = (msgs, forceSearch) => fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'Content-Type'     : 'application/json',
        'x-api-key'        : ANTHROPIC_KEY,
        'anthropic-version': '2023-06-01',
        'anthropic-beta'   : 'web-search-2025-03-05'
      },
      body: JSON.stringify({
        model     : 'claude-sonnet-4-6',
        max_tokens: 2048,
        system    : systemPrompt,
        tools     : [{ type: 'web_search_20250305', name: 'web_search' }],
        ...(forceSearch ? { tool_choice: { type: 'tool', name: 'web_search' } } : {}),
        messages  : msgs
      })
    });

    try {
      let messages = [{ role: 'user', content: userContent }];
      let r2 = await callClaude(messages, true);
      if (!r2.ok) {
        const errText = await r2.text();
        throw new Error(errText);
      }
      let data = await r2.json();

      let loops = 0;
      while (data.stop_reason === 'tool_use' && loops++ < 5) {
        const toolCalls = data.content.filter(c => c.type === 'tool_use');
        const toolResults = toolCalls.map(tc => {
          const resultBlock = data.content.find(c => c.type === 'tool_result' && c.tool_use_id === tc.id);
          return { type: 'tool_result', tool_use_id: tc.id, content: resultBlock?.content ?? [] };
        });
        messages = [...messages, { role: 'assistant', content: data.content }, { role: 'user', content: toolResults }];
        r2 = await callClaude(messages, false);
        if (!r2.ok) { const errText = await r2.text(); throw new Error(errText); }
        data = await r2.json();
      }

      const text = (data.content || []).filter(c => c.type === 'text').map(c => c.text).join('').trim();
      if (!text) return res(headers, 200, { not_found: true });

      let parsed;
      try {
        const jsonMatch = text.match(/\{[\s\S]*\}/);
        parsed = JSON.parse(jsonMatch ? jsonMatch[0] : text);
      } catch { return res(headers, 200, { not_found: true }); }

      if (parsed.not_found) return res(headers, 200, { not_found: true });

      const careOk = VALID_CARE.has(parsed.care_level);
      const dietOk = VALID_DIET.has(parsed.diet);
      const reefOk = VALID_REEF.has(parsed.reef_safe);

      return res(headers, 200, {
        care_level: careOk ? parsed.care_level : null,
        diet      : dietOk ? parsed.diet       : null,
        reef_safe : reefOk ? parsed.reef_safe  : null,
        image_url : (typeof parsed.image_url === 'string' && parsed.image_url.startsWith('http')) ? parsed.image_url : null,
        notes_en  : (typeof parsed.notes_en === 'string' && parsed.notes_en.length > 10) ? parsed.notes_en : null
      });
    } catch (e) { return res(headers, 502, { error: 'API error: ' + e.message }); }
  }

  /* RE-ENRICH FISH — FishBase-only, updates care_level/diet/reef_safe only */
  if (action === 're_enrich_fish') {
    const ANTHROPIC_KEY = process.env.ANTHROPIC_API_KEY;
    if (!ANTHROPIC_KEY) return res(headers, 500, { error: 'ANTHROPIC_API_KEY غير مضبوط' });

    const { scientific_name, common_name_en } = body;
    if (!scientific_name && !common_name_en)
      return res(headers, 400, { error: 'scientific_name مطلوب' });

    const VALID_CARE = new Set(['easy', 'medium', 'hard']);
    const VALID_DIET = new Set(['carnivore', 'herbivore', 'omnivore']);
    const VALID_REEF = new Set(['reef_safe', 'caution', 'with_caution', 'no']);

    const systemPrompt =
`You are a marine biology expert. Search FishBase (fishbase.se) for the exact scientific name provided. Extract only:
- care_level: must be exactly 'easy', 'medium', or 'hard'
- diet: must be exactly 'carnivore', 'herbivore', or 'omnivore'
- reef_safe: must be exactly 'reef_safe', 'caution', 'with_caution', or 'no'

STRICT RULES:
- Use scientific name ONLY for searching
- Return null for any field not clearly confirmed by FishBase
- NEVER guess or assume any value
- reef_safe definitions:
  reef_safe = completely safe, will not harm any coral
  caution = generally safe but individual specimens may occasionally nip
  with_caution = frequently problematic, only for experienced reefers
  no = will definitely damage or eat corals and invertebrates
- Return ONLY this JSON with no extra text:
  {"care_level": "...", "diet": "...", "reef_safe": "..."}`;

    const name = scientific_name || common_name_en;
    const userContent = `Scientific name: ${name}\n\nSearch FishBase for this species by scientific name only. Return the three fields as JSON.`;

    const callClaude = (msgs, forceSearch) => fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'Content-Type'     : 'application/json',
        'x-api-key'        : ANTHROPIC_KEY,
        'anthropic-version': '2023-06-01',
        'anthropic-beta'   : 'web-search-2025-03-05'
      },
      body: JSON.stringify({
        model     : 'claude-haiku-4-5-20251001',
        max_tokens: 512,
        system    : systemPrompt,
        tools     : [{ type: 'web_search_20250305', name: 'web_search' }],
        ...(forceSearch ? { tool_choice: { type: 'tool', name: 'web_search' } } : {}),
        messages  : msgs
      })
    });

    try {
      let messages = [{ role: 'user', content: userContent }];
      let r = await callClaude(messages, true);
      if (!r.ok) { const e = await r.text(); throw new Error(e); }
      let data = await r.json();

      let loops = 0;
      while (data.stop_reason === 'tool_use' && loops++ < 5) {
        const toolCalls = data.content.filter(c => c.type === 'tool_use');
        const toolResults = toolCalls.map(tc => {
          const resultBlock = data.content.find(c => c.type === 'tool_result' && c.tool_use_id === tc.id);
          return { type: 'tool_result', tool_use_id: tc.id, content: resultBlock?.content ?? [] };
        });
        messages = [...messages, { role: 'assistant', content: data.content }, { role: 'user', content: toolResults }];
        r = await callClaude(messages, false);
        if (!r.ok) { const e = await r.text(); throw new Error(e); }
        data = await r.json();
      }

      const text = (data.content || []).filter(c => c.type === 'text').map(c => c.text).join('').trim();
      if (!text) return res(headers, 200, { not_found: true });

      let parsed;
      try {
        const m = text.match(/\{[\s\S]*?\}/);
        parsed = JSON.parse(m ? m[0] : text);
      } catch { return res(headers, 200, { not_found: true }); }

      return res(headers, 200, {
        care_level: VALID_CARE.has(parsed.care_level) ? parsed.care_level : null,
        diet      : VALID_DIET.has(parsed.diet)       ? parsed.diet       : null,
        reef_safe : VALID_REEF.has(parsed.reef_safe)  ? parsed.reef_safe  : null
      });
    } catch (e) { return res(headers, 502, { error: 'API error: ' + e.message }); }
  }

  /* CLEAR FISH CARD IMAGES — set image_url = NULL on all cards that have one */
  if (action === 'clear_fish_card_images') {
    try {
      await sb('PATCH', '/fish_cards?image_url=ilike.' + encodeURIComponent('%fishbase.se%'), { image_url: null });
      return res(headers, 200, { ok: true });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* CLEAR DUPLICATE IMAGES — null out image_url for cards sharing the same URL on 3+ cards */
  if (action === 'clear_duplicate_images') {
    const { urls } = body;
    if (!Array.isArray(urls) || !urls.length) return res(headers, 400, { error: 'urls مطلوب' });
    try {
      for (const url of urls) {
        if (typeof url === 'string' && url.startsWith('http')) {
          await sb('PATCH', '/fish_cards?image_url=eq.' + encodeURIComponent(url), { image_url: null });
        }
      }
      return res(headers, 200, { ok: true, cleared: urls.length });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* FIX FISH IMAGE — fetch Wikimedia/iNaturalist image for one card */
  if (action === 'fix_fish_image') {
    const ANTHROPIC_KEY = process.env.ANTHROPIC_API_KEY;
    if (!ANTHROPIC_KEY) return res(headers, 500, { error: 'ANTHROPIC_API_KEY غير مضبوط' });

    const { id, scientific_name, common_name_en } = body;
    if (!id) return res(headers, 400, { error: 'id مطلوب' });

    const searchName = scientific_name || common_name_en || '';
    const sysPr = 'You are a marine biology image finder. Search for a species photo on Wikimedia Commons or iNaturalist. Return ONLY a JSON object: {"image_url":"direct_url_here"} or {"image_url":null} if no hotlink-friendly image found. The URL must be a direct image URL (ending in .jpg, .jpeg, or .png). Never use fishbase.se URLs.';
    const userPr = `Find a direct hotlink-friendly image URL for: ${searchName}\n1. Search: "site:commons.wikimedia.org ${searchName}" — get upload.wikimedia.org URL\n2. Fallback: "${searchName} inaturalist.org photo"\nReturn JSON only.`;

    try {
      const callClaude = (msgs, force) => fetch('https://api.anthropic.com/v1/messages', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'x-api-key': ANTHROPIC_KEY, 'anthropic-version': '2023-06-01', 'anthropic-beta': 'web-search-2025-03-05' },
        body: JSON.stringify({ model: 'claude-sonnet-4-6', max_tokens: 512, system: sysPr, tools: [{ type: 'web_search_20250305', name: 'web_search' }], ...(force ? { tool_choice: { type: 'tool', name: 'web_search' } } : {}), messages: msgs })
      });
      let msgs2 = [{ role: 'user', content: userPr }];
      let r2 = await callClaude(msgs2, true);
      if (!r2.ok) throw new Error(await r2.text());
      let data = await r2.json();
      let loops = 0;
      while (data.stop_reason === 'tool_use' && loops++ < 3) {
        const tcs = data.content.filter(c => c.type === 'tool_use');
        const trs = tcs.map(tc => ({ type: 'tool_result', tool_use_id: tc.id, content: data.content.find(c => c.type === 'tool_result' && c.tool_use_id === tc.id)?.content ?? [] }));
        msgs2 = [...msgs2, { role: 'assistant', content: data.content }, { role: 'user', content: trs }];
        r2 = await callClaude(msgs2, false);
        if (!r2.ok) throw new Error(await r2.text());
        data = await r2.json();
      }
      const text = (data.content || []).filter(c => c.type === 'text').map(c => c.text).join('').trim();
      let image_url = null;
      try {
        const m = text.match(/\{[\s\S]*\}/);
        const parsed = JSON.parse(m ? m[0] : text);
        if (typeof parsed.image_url === 'string' && parsed.image_url.startsWith('http') && !parsed.image_url.includes('fishbase.se'))
          image_url = parsed.image_url;
      } catch { /* no valid image */ }
      if (image_url) {
        await sb('PATCH', `/fish_cards?id=eq.${encodeURIComponent(id)}`, { image_url });
      }
      return res(headers, 200, { image_url });
    } catch (e) { return res(headers, 502, { error: e.message }); }
  }

  /* WRITE ARABIC NOTES — generate Arabic notes for one card using Claude */
  if (action === 'write_arabic_notes') {
    const ANTHROPIC_KEY = process.env.ANTHROPIC_API_KEY;
    if (!ANTHROPIC_KEY) return res(headers, 500, { error: 'ANTHROPIC_API_KEY غير مضبوط' });

    const { id, scientific_name, care_level, diet, reef_safe, notes_en, dry_run } = body;
    if (!id && !dry_run) return res(headers, 400, { error: 'id مطلوب' });
    if (!scientific_name)  return res(headers, 400, { error: 'scientific_name مطلوب' });

    const sysPr =
`You are a marine biology expert writing fish care cards for an Iraqi aquarium store.

For each species, use your knowledge of that EXACT scientific name to write a useful Arabic care guide.

STRUCTURE — exactly 3 bullet points:
• الصعوبة — care difficulty and minimum tank size
• التغذية — what it eats and feeding frequency
• التوافق — reef safe or not, compatible tank mates

RULES:
- Write in simple formal Arabic (فصحى بسيطة)
- Each bullet: 2-3 sentences, practical and specific
- Every species must have DIFFERENT and SPECIFIC information
- Focus on aquarium care, not wild habitat — do NOT mention البرية (the wild) or natural habitat unless it directly explains a critical care requirement
- If you don't have confident knowledge about this exact scientific name, return only: NOT_FOUND
- Never invent facts — if unsure, return NOT_FOUND
- No intro, no conclusion, start directly with bullet points
- No markdown symbols like ** in the output`;

    const userPr =
`Scientific name: ${scientific_name}
Care level: ${care_level || ''}
Diet: ${diet || ''}
Reef safe: ${reef_safe || ''}
Additional info: ${notes_en || ''}`;

    try {
      const aiRes = await fetch('https://api.anthropic.com/v1/messages', {
        method: 'POST',
        headers: { 'x-api-key': ANTHROPIC_KEY, 'anthropic-version': '2023-06-01', 'content-type': 'application/json' },
        body: JSON.stringify({ model: 'claude-sonnet-4-6', max_tokens: 1024, system: sysPr, messages: [{ role: 'user', content: userPr }] })
      });
      if (!aiRes.ok) throw new Error(`Anthropic HTTP ${aiRes.status}`);
      const aiData = await aiRes.json();
      const rawText = (aiData.content?.[0]?.text || '').trim();

      if (!rawText || rawText === 'NOT_FOUND') {
        console.log(`[write_arabic_notes] NOT_FOUND: ${scientific_name}`);
        return res(headers, 200, { ok: false, not_found: true });
      }

      const notesAr = rawText + '\n— تحرير: زيد العكيلي | Red Sea Iraq 🐠';

      if (!dry_run) {
        const notesObj = { ar: notesAr, en: notes_en || '', ku: '' };
        await sb('PATCH', `/fish_cards?id=eq.${encodeURIComponent(id)}`, { notes: notesObj });
      }
      return res(headers, 200, { ok: true, notes_ar: notesAr });
    } catch (e) { return res(headers, 502, { error: e.message }); }
  }

  /* SAVE CORAL CARD */
  if (action === 'save_coral_card') {
    const { card } = body;
    if (!card?.id) return res(headers, 400, { error: 'id المرجانة مطلوب' });
    try {
      await sb('POST', '/coral_cards', {
        id: card.id, name_ar: card.name_ar, name_en: card.name_en || '',
        name_ku: card.name_ku || '', scientific_name: card.scientific_name || '',
        lighting: card.lighting || 'medium', flow: card.flow || 'medium',
        placement: card.placement || 'middle', difficulty: card.difficulty || 'medium',
        feeding: card.feeding || '', notes: card.notes || '',
        image_url: card.image_url || null,
        created_at: card.created_at || new Date().toISOString()
      });
      return res(headers, 200, { ok: true });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* DELETE CORAL CARD */
  if (action === 'delete_coral_card') {
    const { id } = body;
    if (!id) return res(headers, 400, { error: 'id مطلوب' });
    try {
      await sb('DELETE', `/coral_cards?id=eq.${encodeURIComponent(id)}`, null);
      return res(headers, 200, { ok: true });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* TRANSLATE FIELDS — ترجمة تلقائية عبر Claude */
  if (action === 'translate_fields') {
    const ANTHROPIC_KEY = process.env.ANTHROPIC_API_KEY;
    if (!ANTHROPIC_KEY) return res(headers, 500, { error: 'ANTHROPIC_API_KEY غير مضبوط' });

    const { fields } = body;
    if (!fields || typeof fields !== 'object' || !Object.keys(fields).length)
      return res(headers, 400, { error: 'fields مطلوب' });

    const fieldList = Object.entries(fields).map(([k, v]) => `${k}: ${v}`).join('\n');

    const prompt = `Translate the following text into Arabic, English, and Kurdish (Sorani). Return ONLY this JSON — no markdown, no extra text:
{"ar":"...","en":"...","ku":"..."}

Text:
${fieldList}`;

    try {
      const aiRes = await fetch('https://api.anthropic.com/v1/messages', {
        method: 'POST',
        headers: {
          'x-api-key': ANTHROPIC_KEY,
          'anthropic-version': '2023-06-01',
          'content-type': 'application/json'
        },
        body: JSON.stringify({
          model: 'claude-sonnet-4-6',
          max_tokens: 1024,
          system: 'You are a marine biology translator. Translate the given text into Arabic, English, and Kurdish (Sorani). Return ONLY a JSON object: {"ar":"...","en":"...","ku":"..."}. No markdown, no extra text.',
          messages: [{ role: 'user', content: prompt }]
        })
      });
      if (!aiRes.ok) {
        const err = await aiRes.json().catch(() => ({}));
        throw new Error(err?.error?.message || `Anthropic HTTP ${aiRes.status}`);
      }
      const aiData = await aiRes.json();
      const rawText = (aiData.content?.[0]?.text || '').trim();
      /* Strip markdown code fences if Claude wraps the JSON */
      const cleaned = rawText.replace(/^```(?:json)?\s*/i, '').replace(/\s*```$/, '').trim();
      let translations;
      try { translations = JSON.parse(cleaned); }
      catch (parseErr) {
        return res(headers, 500, {
          error: 'استجابة غير صالحة من الذكاء الاصطناعي',
          raw_response: rawText.substring(0, 800)
        });
      }
      /* Normalise to flat {ar,en,ku} — handle nested {"ar":{"notes":"..."}} too */
      const flat = {};
      for (const lang of ['ar','en','ku']) {
        const v = translations[lang];
        flat[lang] = typeof v === 'string' ? v : (v && typeof v === 'object' ? Object.values(v)[0] || '' : '');
      }
      return res(headers, 200, { translations: flat });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* TRANSLATE NOTE BULLET — translate one bullet point to a single target language */
  if (action === 'translate_note_bullet') {
    const ANTHROPIC_KEY = process.env.ANTHROPIC_API_KEY;
    if (!ANTHROPIC_KEY) return res(headers, 500, { error: 'ANTHROPIC_API_KEY not set' });
    const { text, lang } = body;
    if (!text || !lang) return res(headers, 400, { error: 'text and lang required' });
    const langLabel = lang === 'en' ? 'English' : lang === 'ku' ? 'Kurdish (Sorani)' : null;
    if (!langLabel) return res(headers, 400, { error: 'lang must be en or ku' });
    try {
      const aiRes = await fetch('https://api.anthropic.com/v1/messages', {
        method: 'POST',
        headers: { 'x-api-key': ANTHROPIC_KEY, 'anthropic-version': '2023-06-01', 'content-type': 'application/json' },
        body: JSON.stringify({
          model: 'claude-haiku-4-5-20251001',
          max_tokens: 500,
          system: `Translate the Arabic fish care text to ${langLabel}. Return ONLY the translated text, no explanations, no labels.`,
          messages: [{ role: 'user', content: text }]
        })
      });
      if (!aiRes.ok) {
        const err = await aiRes.json().catch(() => ({}));
        throw new Error(err?.error?.message || `Anthropic HTTP ${aiRes.status}`);
      }
      const aiData = await aiRes.json();
      const translated = (aiData.content?.[0]?.text || '').trim();
      return res(headers, 200, { translated });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* UPLOAD EDU IMAGE — رفع صورة إلى Supabase Storage */
  if (action === 'upload_edu_image') {
    if (!payload) return res(headers, 401, { error: 'Unauthorized' });
    const { image_data, file_name, content_type } = body;
    if (!image_data || !file_name) return res(headers, 400, { error: 'image_data and file_name required' });

    const bucket = 'education-images';
    const uploadPath = `${Date.now()}-${file_name}`;

    const doUpload = async () => {
      const buf = Buffer.from(image_data, 'base64');
      return fetch(`${SB_URL}/storage/v1/object/${bucket}/${uploadPath}`, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${SB_SERVICE_KEY}`,
          'Content-Type': content_type || 'image/webp',
          'x-upsert': 'true'
        },
        body: buf
      });
    };

    try {
      let upRes = await doUpload();
      if (!upRes.ok) {
        const errBody = await upRes.json().catch(() => ({}));
        const msg = errBody?.error || errBody?.message || '';
        console.log(`[upload_edu_image] attempt 1 status=${upRes.status} msg=${msg}`);
        /* retry after creating bucket — catches 400 and 404 from missing bucket */
        if (upRes.status === 400 || upRes.status === 404) {
          const bkRes = await fetch(`${SB_URL}/storage/v1/bucket`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${SB_SERVICE_KEY}`, 'Content-Type': 'application/json' },
            body: JSON.stringify({ id: bucket, name: bucket, public: true })
          }).catch(() => null);
          console.log(`[upload_edu_image] bucket create status=${bkRes?.status}`);
          upRes = await doUpload();
        }
        if (!upRes.ok) {
          const err2 = await upRes.json().catch(() => ({}));
          const errMsg = err2?.error || err2?.message || `Storage ${upRes.status}`;
          console.error(`[upload_edu_image] failed: ${errMsg}`);
          throw new Error(errMsg);
        }
      }
      const publicUrl = `${SB_URL}/storage/v1/object/public/${bucket}/${uploadPath}`;
      console.log(`[upload_edu_image] ok: ${publicUrl}`);
      return res(headers, 200, { url: publicUrl });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  return res(headers, 400, { error: `action غير معروف: ${action}` });
};

function res(headers, status, body) {
  return { statusCode: status, headers, body: JSON.stringify(body) };
}
