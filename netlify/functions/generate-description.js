/**
 * generate-description.js — Red Sea Iraq
 * Dedicated function for AI-powered product description generation.
 * Calls Claude API server-side; ANTHROPIC_API_KEY never leaves the server.
 */

const crypto = require('crypto');

const JWT_SECRET      = process.env.JWT_SECRET;
const ANTHROPIC_API_KEY = process.env.ANTHROPIC_API_KEY;

const ALLOWED_ORIGINS = [
  'https://redseairaq.com',
  'https://www.redseairaq.com',
  'http://localhost',
  'http://127.0.0.1',
  'null'
];

function corsHeaders(origin) {
  const allowed = ALLOWED_ORIGINS.includes(origin) ? origin : ALLOWED_ORIGINS[0];
  return {
    'Access-Control-Allow-Origin' : allowed,
    'Access-Control-Allow-Headers': 'Content-Type, Authorization',
    'Access-Control-Allow-Methods': 'POST, OPTIONS',
    'Content-Type': 'application/json'
  };
}

function verifyToken(token) {
  try {
    const [header, body, sig] = token.split('.');
    const expected = crypto.createHmac('sha256', JWT_SECRET)
      .update(`${header}.${body}`).digest('base64url');
    if (sig !== expected) return null;
    const payload = JSON.parse(Buffer.from(body, 'base64url').toString());
    if (payload.exp < Date.now()) return null;
    return payload;
  } catch { return null; }
}

exports.handler = async function(event) {
  const origin  = event.headers.origin || event.headers.Origin || 'null';
  const headers = corsHeaders(origin);

  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers, body: '' };
  if (event.httpMethod !== 'POST')
    return { statusCode: 405, headers, body: JSON.stringify({ error: 'Method not allowed' }) };

  /* ── Auth ── */
  const authHeader = event.headers.authorization || event.headers.Authorization || '';
  const token      = authHeader.replace('Bearer ', '').trim();
  const payload    = token ? verifyToken(token) : null;
  if (!payload || payload.role !== 'admin')
    return { statusCode: 401, headers, body: JSON.stringify({ error: 'غير مصرح — يرجى تسجيل الدخول' }) };

  /* ── Parse body ── */
  let body;
  try { body = JSON.parse(event.body || '{}'); }
  catch { return { statusCode: 400, headers, body: JSON.stringify({ error: 'Invalid JSON' }) }; }

  const { name, category, stock, specs } = body;
  if (!name) return { statusCode: 400, headers, body: JSON.stringify({ error: 'name مطلوب' }) };

  /* ── Key check ── */
  if (!ANTHROPIC_API_KEY) {
    console.error('ANTHROPIC_API_KEY is not set in Netlify environment variables');
    return { statusCode: 500, headers, body: JSON.stringify({ error: 'Anthropic API key not configured' }) };
  }

  const stockMap = { available: 'متوفر', preorder: 'حجز مسبق', soon: 'قريباً', out: 'غير متوفر' };

  const systemPrompt =
`You MUST use the web_search tool to search for this exact product on redseafish.com before writing any description.
Search query: site:redseafish.com [product name]
If you cannot find the product on redseafish.com, respond with exactly: NOT_FOUND
Do NOT guess, hallucinate, or use any information not found on redseafish.com.
NEVER mention country of origin or manufacturing location.
If you find the product, write a 3-4 sentence Arabic marketing description based only on what you found on redseafish.com.`;

  const userContent =
`Product: "${name}"
Category: ${category || 'N/A'}
Status: ${stockMap[stock] || stock}${specs ? '\nSpecs:\n' + specs : ''}

Search redseafish.com for this product now. If found, write a 3-4 sentence Arabic description. If not found, respond: NOT_FOUND`;

  const callClaude = (msgs, forceSearch) => fetch('https://api.anthropic.com/v1/messages', {
    method: 'POST',
    headers: {
      'Content-Type'   : 'application/json',
      'x-api-key'      : ANTHROPIC_API_KEY,
      'anthropic-version': '2023-06-01',
      'anthropic-beta' : 'web-search-2025-03-05'
    },
    body: JSON.stringify({
      model     : 'claude-sonnet-4-6',
      max_tokens: 1024,
      system    : systemPrompt,
      tools     : [{ type: 'web_search_20250305', name: 'web_search' }],
      ...(forceSearch ? { tool_choice: { type: 'tool', name: 'web_search' } } : {}),
      messages  : msgs
    })
  });

  try {
    let messages = [{ role: 'user', content: userContent }];
    let r = await callClaude(messages, true);
    if (!r.ok) throw new Error(await r.text());
    let data = await r.json();

    /* agentic loop — handles tool_use stop_reason */
    let loops = 0;
    while (data.stop_reason === 'tool_use' && loops++ < 4) {
      messages = [
        ...messages,
        { role: 'assistant', content: data.content },
        {
          role   : 'user',
          content: data.content
            .filter(c => c.type === 'tool_use')
            .map(c => ({ type: 'tool_result', tool_use_id: c.id, content: [] }))
        }
      ];
      r = await callClaude(messages, false);
      if (!r.ok) throw new Error(await r.text());
      data = await r.json();
    }

    const text = (data.content || [])
      .filter(c => c.type === 'text')
      .map(c => c.text)
      .join('')
      .trim();

    if (!text || /NOT_FOUND/i.test(text)) {
      return { statusCode: 200, headers, body: JSON.stringify({ desc: null, notFound: true }) };
    }

    return { statusCode: 200, headers, body: JSON.stringify({ desc: text }) };
  } catch (e) {
    console.error('generate-description error:', e.message);
    return { statusCode: 502, headers, body: JSON.stringify({ error: 'API error: ' + e.message }) };
  }
};
