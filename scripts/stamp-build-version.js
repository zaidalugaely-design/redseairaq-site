#!/usr/bin/env node
'use strict';

/* يُشغَّل بعد نسخ index.html إلى dist/ أثناء بناء Netlify.
   يستبدل قيمة <meta name="version"> بمعرّف نشر حقيقي (COMMIT_REF، أو DEPLOY_ID احتياطياً،
   أو الوقت الحالي محلياً خارج Netlify) بحيث تقرأه الصفحة عبر BUILD_ID في index.html
   وتُبطل تلقائياً كاش كل الزوار من أي نشر سابق — انظر قسم CACHE في index.html. */

const fs = require('fs');
const path = require('path');

const target = path.join(__dirname, '..', 'dist', 'index.html');
const buildId = process.env.COMMIT_REF || process.env.DEPLOY_ID || String(Date.now());

let html = fs.readFileSync(target, 'utf8');
const before = html;
html = html.replace(
  /<meta name="version" content="[^"]*">/,
  `<meta name="version" content="${buildId}">`
);

if (html === before) {
  throw new Error('stamp-build-version: <meta name="version"> tag not found in dist/index.html');
}

fs.writeFileSync(target, html);
console.log('[stamp-build-version] BUILD_ID =', buildId);
