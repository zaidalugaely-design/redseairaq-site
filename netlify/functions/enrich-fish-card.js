/**
 * enrich-fish-card.js — Red Sea Iraq
 * Phase 2: AI-powered fish card enrichment.
 * Uses Claude + web_search to extract care data, then falls back to
 * Claude's own marine biology knowledge if search results are incomplete.
 */

const crypto = require('crypto');

const JWT_SECRET = process.env.JWT_SECRET;

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

  const ANTHROPIC_API_KEY = process.env.ANTHROPIC_API_KEY;
  if (!ANTHROPIC_API_KEY) {
    console.error('[enrich] ANTHROPIC_API_KEY not set in Netlify environment variables');
    return { statusCode: 500, headers, body: JSON.stringify({ error: 'Anthropic API key not configured' }) };
  }

  console.log(`[enrich] START — common_name_en="${common_name_en}" scientific_name="${scientific_name}"`);

  /* ── Prompts ── */
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

  console.log(`[enrich] User prompt: ${userContent.replace(/\n/g, ' | ')}`);

  /* ── Claude API call helper ── */
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
      max_tokens: 2048,
      system    : systemPrompt,
      tools     : [{ type: 'web_search_20250305', name: 'web_search' }],
      ...(forceSearch ? { tool_choice: { type: 'tool', name: 'web_search' } } : {}),
      messages  : msgs
    })
  });

  try {
    let messages = [{ role: 'user', content: userContent }];
    let r = await callClaude(messages, true);
    if (!r.ok) {
      const errText = await r.text();
      console.error(`[enrich] Claude API error ${r.status}: ${errText}`);
      throw new Error(errText);
    }
    let data = await r.json();

    console.log(`[enrich] Loop 0 — stop_reason="${data.stop_reason}" content_blocks=${data.content?.length}`);

    /* ── Agentic loop — forward tool calls and their results ── */
    let loops = 0;
    while (data.stop_reason === 'tool_use' && loops++ < 5) {
      /* Log every search query Claude chose */
      const toolCalls = data.content.filter(c => c.type === 'tool_use');
      for (const tc of toolCalls) {
        const query = tc.input?.query || JSON.stringify(tc.input);
        console.log(`[enrich] Loop ${loops} — tool_use id=${tc.id} query="${query}"`);
      }

      /* Forward tool results — for web_search_20250305, pass back any
         tool_result content blocks already present in the response;
         fall back to empty content if none (server-side search) */
      const toolResults = toolCalls.map(tc => {
        const resultBlock = data.content.find(
          c => c.type === 'tool_result' && c.tool_use_id === tc.id
        );
        return {
          type        : 'tool_result',
          tool_use_id : tc.id,
          content     : resultBlock?.content ?? []
        };
      });

      messages = [
        ...messages,
        { role: 'assistant', content: data.content },
        { role: 'user',      content: toolResults  }
      ];

      r = await callClaude(messages, false);
      if (!r.ok) {
        const errText = await r.text();
        console.error(`[enrich] Claude API error loop ${loops} ${r.status}: ${errText}`);
        throw new Error(errText);
      }
      data = await r.json();
      console.log(`[enrich] Loop ${loops} — stop_reason="${data.stop_reason}" content_blocks=${data.content?.length}`);
    }

    /* ── Extract text response ── */
    const text = (data.content || [])
      .filter(c => c.type === 'text')
      .map(c => c.text)
      .join('')
      .trim();

    console.log(`[enrich] Raw text response (first 500 chars): ${text.slice(0, 500)}`);

    if (!text) {
      console.warn('[enrich] Empty text response from Claude');
      return { statusCode: 200, headers, body: JSON.stringify({ not_found: true }) };
    }

    /* ── Parse JSON ── */
    let parsed;
    try {
      const jsonMatch = text.match(/\{[\s\S]*\}/);
      const jsonStr   = jsonMatch ? jsonMatch[0] : text;
      console.log(`[enrich] JSON to parse: ${jsonStr.slice(0, 300)}`);
      parsed = JSON.parse(jsonStr);
    } catch (parseErr) {
      console.error(`[enrich] JSON parse failed: ${parseErr.message} — raw text: ${text.slice(0, 300)}`);
      return { statusCode: 200, headers, body: JSON.stringify({ not_found: true }) };
    }

    console.log(`[enrich] Parsed: care_level=${parsed.care_level} diet=${parsed.diet} reef_safe=${parsed.reef_safe} image_url=${parsed.image_url?.slice(0,60)} not_found=${parsed.not_found}`);

    if (parsed.not_found) {
      console.log('[enrich] Claude returned not_found — no data for this species');
      return { statusCode: 200, headers, body: JSON.stringify({ not_found: true }) };
    }

    /* ── Validate enums ── */
    const careOk = VALID_CARE.has(parsed.care_level);
    const dietOk = VALID_DIET.has(parsed.diet);
    const reefOk = VALID_REEF.has(parsed.reef_safe);
    if (!careOk) console.warn(`[enrich] Invalid care_level="${parsed.care_level}"`);
    if (!dietOk) console.warn(`[enrich] Invalid diet="${parsed.diet}"`);
    if (!reefOk) console.warn(`[enrich] Invalid reef_safe="${parsed.reef_safe}"`);

    const result = {
      care_level: careOk ? parsed.care_level : null,
      diet      : dietOk ? parsed.diet       : null,
      reef_safe : reefOk ? parsed.reef_safe  : null,
      image_url : (typeof parsed.image_url === 'string' && parsed.image_url.startsWith('http'))
                    ? parsed.image_url : null,
      notes_en  : (typeof parsed.notes_en === 'string' && parsed.notes_en.length > 10)
                    ? parsed.notes_en : null
    };

    console.log(`[enrich] SUCCESS — returning: ${JSON.stringify(result).slice(0, 200)}`);
    return { statusCode: 200, headers, body: JSON.stringify(result) };

  } catch (e) {
    console.error(`[enrich] FATAL: ${e.message}`);
    return { statusCode: 502, headers, body: JSON.stringify({ error: 'API error: ' + e.message }) };
  }
};
