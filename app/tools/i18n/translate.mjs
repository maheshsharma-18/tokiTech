import fs from 'fs/promises';
import path from 'path';
import translate from 'google-translate-api-x';

const target = process.argv[2] || 'te'; // default Telugu
const enPath = path.join(process.cwd(), 'lib', 'l10n', 'app_en.arb');
const targetPath = path.join(process.cwd(), 'lib', 'l10n', `app_${target}.arb`);

function isMetaKey(k) { return k.startsWith('@'); }

async function main() {
const enJson = JSON.parse(await fs.readFile(enPath, 'utf8'));
let tgtJson = {};
try { tgtJson = JSON.parse(await fs.readFile(targetPath, 'utf8')); } catch (_) {}

for (const [key, value] of Object.entries(enJson)) {
if (isMetaKey(key)) continue;
// Keep existing translations; only translate missing or empty
if (tgtJson[key] && String(tgtJson[key]).trim().length > 0) continue;

if (typeof value !== 'string') { tgtJson[key] = value; continue; }
try {
  const res = await translate(value, { from: 'en', to: target });
  tgtJson[key] = res.text;
  // console.log(`Translated ${key}: ${value} -> ${res.text}`);
} catch (e) {
  console.warn('Failed to translate', key, e.message);
  tgtJson[key] = value; // fallback to English
}
}

// Preserve metadata if present
for (const [k, v] of Object.entries(enJson)) {
if (isMetaKey(k)) tgtJson[k] = v;
}

await fs.writeFile(targetPath, JSON.stringify(tgtJson, null, 2) + '\n', 'utf8');
console.log(`Updated ${targetPath}`);
}
main().catch(err => { console.error(err); process.exit(1); });