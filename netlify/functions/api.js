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
        sb('GET', '/reference_topics?order=sort_order.asc,created_at.desc&limit=200&select=id,slug,title,excerpt,category,tags,image,hidden,created_at,updated_at', null)
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

  return res(headers, 400, { error: `action غير معروف: ${action}` });
};

function res(headers, status, body) {
  return { statusCode: status, headers, body: JSON.stringify(body) };
}
