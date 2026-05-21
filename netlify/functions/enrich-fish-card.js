/**
 * enrich-fish-card.js — Red Sea Iraq
 * Phase 2: AI-powered fish card enrichment via FishBase + WetWebMedia.
 * Calls Claude API server-side; ANTHROPIC_API_KEY never leaves the server.
 */

const crypto = require('crypto');

const JWT_SECRET        = process.env.JWT_SECRET;
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

const VALID_CARE = new Set(['easy', 'medium', 'hard']);
const VALID_DIET = new Set(['carnivore', 'herbivore', 'omnivore']);
const VALID_REEF = new Set(['reef_safe', 'caution', 'with_caution', 'no']);

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

  const { common_name_en, scientific_name } = body;
  if (!common_name_en && !scientific_name)
    return { statusCode: 400, headers, body: JSON.stringify({ error: 'common_name_en أو scientific_name مطلوب' }) };

  /* ── Key check ── */
  if (!ANTHROPIC_API_KEY) {
    console.error('ANTHROPIC_API_KEY is not set');
    return { statusCode: 500, headers, body: JSON.stringify({ error: 'Anthropic API key not configured' }) };
  }

  const systemPrompt =
`You are a marine biology expert. Search FishBase (fishbase.se) first, then WetWebMedia (wetwebmedia.com) for the given species. Always search by scientific name. Extract care level, diet type, reef compatibility, a good image URL, and key care facts. Return ONLY a JSON object with keys: care_level, diet, reef_safe, image_url, notes_en. No extra text.

Allowed values:
- care_level: "easy" | "medium" | "hard"
- diet: "carnivore" | "herbivore" | "omnivore"
- reef_safe: "reef_safe" | "caution" | "with_caution" | "no"
- image_url: direct URL to a fish photo, or null
- notes_en: 3-5 sentences covering size, behavior, tank requirements, compatibility. null if not found.

If insufficient data is available after searching, return exactly: {"not_found":true}`;

  const userContent =
`Fish: ${common_name_en || ''}${scientific_name ? ` (${scientific_name})` : ''}

Search FishBase by scientific name first, then WetWebMedia. Return JSON only.`;

  const callClaude = (msgs, forceSearch) => fetch('https://api.anthropic.com/v1/messages', {
    method: 'POST',
    headers: {
      'Content-Type'     : 'application/json',
      'x-api-key'        : ANTHROPIC_API_KEY,
      'anthropic-version': '2023-06-01',
      'anthropic-beta'   : 'web-search-2025-03-05'
    },
    body: JSON.stringify({
      model     : 'claude-sonnet-4-20250514',
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
    while (data.stop_reason === 'tool_use' && loops++ < 5) {
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

    /* Extract JSON from response */
    let parsed;
    try {
      const jsonMatch = text.match(/\{[\s\S]*\}/);
      parsed = JSON.parse(jsonMatch ? jsonMatch[0] : text);
    } catch {
      return { statusCode: 200, headers, body: JSON.stringify({ not_found: true }) };
    }

    if (parsed.not_found) {
      return { statusCode: 200, headers, body: JSON.stringify({ not_found: true }) };
    }

    /* Validate and sanitize */
    const result = {
      care_level: VALID_CARE.has(parsed.care_level) ? parsed.care_level : null,
      diet      : VALID_DIET.has(parsed.diet)        ? parsed.diet       : null,
      reef_safe : VALID_REEF.has(parsed.reef_safe)   ? parsed.reef_safe  : null,
      image_url : (typeof parsed.image_url === 'string' && parsed.image_url.startsWith('http'))
                    ? parsed.image_url : null,
      notes_en  : (typeof parsed.notes_en === 'string' && parsed.notes_en.length > 10)
                    ? parsed.notes_en : null
    };

    return { statusCode: 200, headers, body: JSON.stringify(result) };
  } catch (e) {
    console.error('enrich-fish-card error:', e.message);
    return { statusCode: 502, headers, body: JSON.stringify({ error: 'API error: ' + e.message }) };
  }
};
