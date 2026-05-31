const SB_URL = process.env.SUPABASE_URL || 'https://glhmmrovxyijtzjaldtf.supabase.co';
const SITE   = 'https://redseairaq.com';

const CRAWLER_RE = /whatsapp|facebookexternalhit|facebot|twitterbot|linkedinbot|telegrambot|slackbot|discordbot|googlebot|bingbot/i;

exports.handler = async function(event) {
  const id = (event.queryStringParameters || {}).id;
  if (!id) {
    return { statusCode: 302, headers: { Location: SITE }, body: '' };
  }

  const ua = event.headers['user-agent'] || '';
  const isCrawler = CRAWLER_RE.test(ua);

  if (!isCrawler) {
    return {
      statusCode: 302,
      headers: { Location: `${SITE}/#/product/${id}` },
      body: ''
    };
  }

  /* Crawler: fetch product and return OG meta page */
  const SB_KEY = process.env.SB_SERVICE_KEY;
  let product = null;
  try {
    const res = await fetch(
      `${SB_URL}/rest/v1/products?id=eq.${encodeURIComponent(id)}&select=name,desc,image&limit=1`,
      {
        headers: {
          'apikey':        SB_KEY,
          'Authorization': `Bearer ${SB_KEY}`,
          'Accept':        'application/json'
        }
      }
    );
    const data = await res.json();
    product = Array.isArray(data) && data[0];
  } catch (e) {
    console.error('[og-preview] supabase error:', e.message);
  }

  if (!product) {
    return {
      statusCode: 302,
      headers: { Location: `${SITE}/#/product/${id}` },
      body: ''
    };
  }

  const title = esc(product.name || 'Red Sea Iraq');
  const desc  = esc(product.desc || 'منتج Red Sea الأصلي — الوكيل الحصري في العراق');
  const image = esc(product.image || '');
  const url   = `${SITE}/product/${id}`;

  return {
    statusCode: 200,
    headers: { 'Content-Type': 'text/html; charset=utf-8', 'Cache-Control': 'public, max-age=300' },
    body: `<!DOCTYPE html>
<html lang="ar">
<head>
  <meta charset="utf-8">
  <meta property="og:title" content="${title}">
  <meta property="og:description" content="${desc}">
  <meta property="og:image" content="${image}">
  <meta property="og:url" content="${url}">
  <meta property="og:type" content="product">
  <meta property="og:site_name" content="Red Sea Iraq">
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="${title}">
  <meta name="twitter:description" content="${desc}">
  <meta name="twitter:image" content="${image}">
  <meta http-equiv="refresh" content="0;url=${SITE}/#/product/${id}">
</head>
<body>جاري التحويل...</body>
</html>`
  };
};

function esc(str) {
  return String(str)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}
