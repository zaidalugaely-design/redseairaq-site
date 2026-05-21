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
      return res(headers, 200, { ok: true });
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
        created_at: family.created_at || new Date().toISOString()
      });
      return res(headers, 200, { ok: true });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* PATCH FISH FAMILY — update only name_ar / name_ku */
  if (action === 'patch_fish_family') {
    const { id, name_ar, name_ku } = body;
    if (!id) return res(headers, 400, { error: 'id مطلوب' });
    const patch = {};
    if (name_ar !== undefined) patch.name_ar = name_ar;
    if (name_ku !== undefined) patch.name_ku = name_ku;
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
    const { id, care_level, diet, reef_safe, image_url, notes, needs_review } = body;
    if (!id) return res(headers, 400, { error: 'id مطلوب' });
    try {
      const patch = {};
      if (care_level   !== undefined) patch.care_level   = care_level;
      if (diet         !== undefined) patch.diet         = diet;
      if (reef_safe    !== undefined) patch.reef_safe    = reef_safe;
      if (image_url    !== undefined) patch.image_url    = image_url;
      if (notes        !== undefined) patch.notes        = notes;
      if (needs_review !== undefined) patch.needs_review = needs_review;
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

SEARCH STRATEGY (search by scientific name, not common name):
1. First search: "fishbase.se ${scientific_name || common_name_en}" — get biological facts (size, habitat, natural diet)
2. Second search: "${scientific_name || common_name_en} aquarium care reef safe" — get hobbyist care requirements

CLASSIFICATION RULES:
- care_level: "easy" = hardy and forgiving for beginners | "medium" = needs some experience | "hard" = expert only
- diet: "carnivore" = eats live/frozen meaty foods | "herbivore" = primarily algae/plant-based | "omnivore" = accepts both
- reef_safe: "reef_safe" = completely safe with corals and invertebrates | "caution" = generally ok but watch inverts | "with_caution" = known to nip corals | "no" = will destroy corals or eat invertebrates
- image_url: a direct URL to a clear species photo from fishbase.se or similar scientific source, or null
- notes_en: 3-5 sentences covering max adult size, minimum tank size, behavior, feeding, and reef compatibility notes

CRITICAL: Use your expert marine biology knowledge to fill in values you are confident about, even when web search results are not perfectly formatted. You know the care requirements of common reef fish well — use that knowledge. Only return {"not_found":true} for species so obscure you have no information at all.

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

    const prompt = `Translate ALL of the following fields into Arabic, English, and Kurdish (Sorani). Auto-detect the input language. Return ONLY a JSON object — no markdown, no extra text — with this structure:
{"ar":{"field_name":"..."},"en":{"field_name":"..."},"ku":{"field_name":"..."}}

Fields:
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
          system: 'You are a marine biology translator. Auto-detect the input language and translate all provided fields into Arabic, English, and Kurdish (Sorani). scientific_name fields must never be translated. Return ONLY a JSON object with keys: ar, en, ku for each field. No extra text.',
          messages: [{ role: 'user', content: prompt }]
        })
      });
      if (!aiRes.ok) {
        const err = await aiRes.json().catch(() => ({}));
        throw new Error(err?.error?.message || `Anthropic HTTP ${aiRes.status}`);
      }
      const aiData = await aiRes.json();
      const rawText = aiData.content?.[0]?.text || '{}';
      let translations;
      try { translations = JSON.parse(rawText); }
      catch { throw new Error('استجابة غير صالحة من الذكاء الاصطناعي'); }
      return res(headers, 200, { translations });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  /* UPLOAD EDU IMAGE — رفع صورة إلى Supabase Storage */
  if (action === 'upload_edu_image') {
    if (!adminJwt) return res(headers, 401, { error: 'Unauthorized' });
    const { image_data, file_name, content_type } = body;
    if (!image_data || !file_name) return res(headers, 400, { error: 'image_data and file_name required' });

    const bucket = 'education-images';
    const uploadPath = `${Date.now()}-${file_name}`;

    // ensure bucket exists (idempotent)
    await fetch(`${SB_URL}/storage/v1/bucket`, {
      method: 'POST',
      headers: { 'Authorization': `Bearer ${SB_SERVICE_KEY}`, 'Content-Type': 'application/json' },
      body: JSON.stringify({ id: bucket, name: bucket, public: true })
    }).catch(() => {});

    try {
      const buf = Buffer.from(image_data, 'base64');
      const upRes = await fetch(`${SB_URL}/storage/v1/object/${bucket}/${uploadPath}`, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${SB_SERVICE_KEY}`,
          'Content-Type': content_type || 'image/webp',
          'x-upsert': 'true'
        },
        body: buf
      });
      if (!upRes.ok) {
        const err = await upRes.json().catch(() => ({}));
        throw new Error(err?.error || err?.message || `Storage ${upRes.status}`);
      }
      const publicUrl = `${SB_URL}/storage/v1/object/public/${bucket}/${uploadPath}`;
      return res(headers, 200, { url: publicUrl });
    } catch (e) { return res(headers, 500, { error: e.message }); }
  }

  return res(headers, 400, { error: `action غير معروف: ${action}` });
};

function res(headers, status, body) {
  return { statusCode: status, headers, body: JSON.stringify(body) };
}
