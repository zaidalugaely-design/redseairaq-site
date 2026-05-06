/**
 * Netlify Function: admin-bot
 * وسيط آمن بين لوحة الادمن و OpenAI
 * الـ API key محفوظ في متغيرات البيئة فقط — لا يظهر في الكود أبداً
 */

exports.handler = async function(event) {

  /* ── CORS: نسمح فقط من نفس الدومين ── */
  const allowed = ['https://redseairaq.com', 'https://www.redseairaq.com'];
  const origin  = event.headers.origin || event.headers.Origin || '';
  const isLocal = origin.includes('localhost') || origin.includes('127.0.0.1') || origin === '';

  if (!isLocal && !allowed.includes(origin)) {
    return { statusCode: 403, body: JSON.stringify({ error: 'Forbidden' }) };
  }

  const headers = {
    'Access-Control-Allow-Origin' : isLocal ? '*' : origin,
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Allow-Methods': 'POST, OPTIONS',
    'Content-Type': 'application/json'
  };

  /* ── Preflight ── */
  if (event.httpMethod === 'OPTIONS') {
    return { statusCode: 204, headers, body: '' };
  }

  if (event.httpMethod !== 'POST') {
    return { statusCode: 405, headers, body: JSON.stringify({ error: 'Method not allowed' }) };
  }

  /* ── قراءة الطلب ── */
  let body;
  try { body = JSON.parse(event.body || '{}'); }
  catch { return { statusCode: 400, headers, body: JSON.stringify({ error: 'Invalid JSON' }) }; }

  const { command, products } = body;

  if (!command || !Array.isArray(products)) {
    return { statusCode: 400, headers, body: JSON.stringify({ error: 'command and products required' }) };
  }

  const apiKey = process.env.OPENAI_API_KEY;
  if (!apiKey) {
    return { statusCode: 500, headers, body: JSON.stringify({ error: 'API key not configured' }) };
  }

  /* ── بناء قائمة المنتجات للـ prompt ── */
  const prodList = products.map(p =>
    `id:"${p.id}" | "${p.name}" | فئة:${p.category} | حالة:${p.stock} | مخفي:${!!p.hidden}`
  ).join('\n');

  const hiddenCount = products.filter(p => p.hidden).length;

  const systemPrompt = `أنت مساعد إداري ذكي لمتجر Red Sea Iraq لمنتجات الأحواض البحرية.
مهمتك: تنفيذ أوامر الإخفاء والإظهار للمنتجات بدقة.

قائمة المنتجات الحالية (${products.length} منتج، ${hiddenCount} مخفي):
${prodList}

ردّك يجب أن يكون JSON صرف بدون أي نص خارجه، بهذا الشكل الحرفي:
{
  "reply": "رسالة واضحة بالعربي تشرح ما تم أو ما وجدت",
  "action": "hide" أو "show" أو "info",
  "targets": ["id1", "id2"] — قائمة IDs المنتجات المطلوبة، أو [] للمعلومات فقط
}

قواعد:
- hide = أخفِ المنتجات (targets = IDs المطلوبة)
- show = أظهر المنتجات (targets = IDs المطلوبة)
- info = معلومة فقط بدون تغيير (targets = [])
- ابحث بذكاء: بالاسم أو جزء منه أو الفئة أو الحالة
- لو الأمر غامض وضّح ما فهمته في reply
- لا تضف backticks أو markdown — JSON فقط`;

  /* ── استدعاء OpenAI ── */
  let aiText;
  try {
    const res = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type' : 'application/json',
        'Authorization': `Bearer ${apiKey}`
      },
      body: JSON.stringify({
        model: 'gpt-4o-mini',
        max_tokens: 400,
        temperature: 0,                    /* صفر للحصول على JSON ثابت ودقيق */
        response_format: { type: 'json_object' },
        messages: [
          { role: 'system', content: systemPrompt },
          { role: 'user',   content: command }
        ]
      })
    });

    if (!res.ok) {
      const err = await res.text();
      console.error('OpenAI error:', err);
      return { statusCode: 502, headers, body: JSON.stringify({ error: 'OpenAI error', detail: err }) };
    }

    const data = await res.json();
    aiText = data.choices?.[0]?.message?.content || '{}';

  } catch (e) {
    console.error('fetch error:', e);
    return { statusCode: 502, headers, body: JSON.stringify({ error: 'Network error', detail: e.message }) };
  }

  /* ── تحقق من JSON ── */
  let result;
  try {
    result = JSON.parse(aiText.replace(/```json|```/g, '').trim());
    /* تأكد من وجود الحقول الأساسية */
    if (!result.action) result.action = 'info';
    if (!Array.isArray(result.targets)) result.targets = [];
    if (!result.reply) result.reply = 'تم.';
  } catch (e) {
    return {
      statusCode: 200,
      headers,
      body: JSON.stringify({ reply: 'لم أفهم الأمر، جرب صياغة أوضح.', action: 'info', targets: [] })
    };
  }

  return { statusCode: 200, headers, body: JSON.stringify(result) };
};
