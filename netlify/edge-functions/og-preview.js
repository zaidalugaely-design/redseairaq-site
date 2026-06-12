const SITE    = 'https://redseairaq.com';
const SB_URL  = 'https://glhmmrovxyijtzjaldtf.supabase.co';
const SB_KEY  = 'sb_publishable_hzVe29KIzQ2h72PuHBLZ5Q_M6BLVkaI';
const CRAWLER = /facebookexternalhit|facebot|whatsapp|twitterbot|linkedinbot|slackbot|googlebot|bingbot|discordbot|telegrambot/i;

export default async function(request, context) {
  const url   = new URL(request.url);
  const match = url.pathname.match(/^\/product\/(.+)$/);
  if (!match) return context.next();

  const id = decodeURIComponent(match[1]);

  const ua = request.headers.get('user-agent') || '';

  if (!CRAWLER.test(ua)) {
    return context.next(); // real browser — serve index.html, boot() handles routing
  }

  /* Crawler: fetch product and return OG meta HTML */
  let product  = null;
  try {
    const res = await fetch(
      `${SB_URL}/rest/v1/products?id=eq.${encodeURIComponent(id)}&select=name,description,image&limit=1`,
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
  } catch (_) { /* fall through */ }

  const redirect = `${SITE}/#/product/${encodeURIComponent(id)}`;
  if (!product) {
    return new Response(
      `<!DOCTYPE html><html><head><meta charset="utf-8"><meta http-equiv="refresh" content="0;url=${redirect}"><script>location.replace('${redirect}')</script></head><body></body></html>`,
      { status: 200, headers: { 'Content-Type': 'text/html; charset=utf-8', 'Cache-Control': 'no-store' } }
    );
  }

  const title = esc(product.name || 'Red Sea Iraq');
  const desc  = esc((product.description || 'منتج Red Sea الأصلي — الوكيل الحصري في العراق').slice(0, 150));
  const image = esc(product.image || '');
  const ogUrl = `${SITE}/product/${encodeURIComponent(id)}`;

  return new Response(`<!DOCTYPE html>
<html lang="ar">
<head>
  <meta charset="utf-8">
  <meta property="og:title" content="${title}">
  <meta property="og:description" content="${desc}">
  <meta property="og:image" content="${image}">
  <meta property="og:url" content="${ogUrl}">
  <meta property="og:type" content="product">
  <meta property="og:site_name" content="Red Sea Iraq">
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="${title}">
  <meta name="twitter:description" content="${desc}">
  <meta name="twitter:image" content="${image}">
  <meta http-equiv="refresh" content="0;url=${redirect}">
  <script>location.replace('${redirect}')</script>
</head>
<body>جاري التحويل...</body>
</html>`, {
    status: 200,
    headers: { 'Content-Type': 'text/html; charset=utf-8', 'Cache-Control': 'public, max-age=300' }
  });
}

function esc(str) {
  return String(str)
    .replace(/&/g, '&amp;').replace(/</g, '&lt;')
    .replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}
