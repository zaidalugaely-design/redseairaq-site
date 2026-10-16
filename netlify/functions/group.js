/**
 * group.js — redseairaq.com/group
 * يحوّل الزائر لرابط كروب واتساب الحالي المحفوظ بجدول site_settings
 * (المفتاح whatsapp_group_link). يتغيّر الرابط من لوحة الأدمن:
 * «تغيير رابط كروب واتساب» — بلا أي تعديل كود أو نشر جديد.
 *
 * إذا تعذّر الوصول لقاعدة البيانات لأي سبب، يُستخدم FALLBACK_LINK حتى لا
 * يطلع للزائر خطأ أبداً.
 */

const SB_URL = process.env.SUPABASE_URL || 'https://glhmmrovxyijtzjaldtf.supabase.co';
const SB_SERVICE_KEY = process.env.SB_SERVICE_KEY;
const FALLBACK_LINK = 'https://chat.whatsapp.com/Eu0VL9PXlK2B6F3eidXpbr';
const VALID = /^https:\/\/chat\.whatsapp\.com\/[A-Za-z0-9]{10,40}$/;

async function currentLink() {
  if (!SB_SERVICE_KEY) return FALLBACK_LINK;
  const ctrl = new AbortController();
  const timer = setTimeout(() => ctrl.abort(), 4000);
  try {
    const r = await fetch(
      `${SB_URL}/rest/v1/site_settings?key=eq.whatsapp_group_link&select=value`,
      {
        headers: { apikey: SB_SERVICE_KEY, Authorization: `Bearer ${SB_SERVICE_KEY}` },
        signal: ctrl.signal
      }
    );
    if (!r.ok) return FALLBACK_LINK;
    const rows = await r.json();
    const v = rows && rows[0] && rows[0].value;
    return VALID.test(v || '') ? v : FALLBACK_LINK;
  } catch (_) {
    return FALLBACK_LINK;
  } finally {
    clearTimeout(timer);
  }
}

exports.handler = async function () {
  const link = await currentLink();
  return {
    statusCode: 302,
    headers: { Location: link, 'Cache-Control': 'no-store' },
    body: ''
  };
};
