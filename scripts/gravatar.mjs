import { createHash } from 'node:crypto';
import { writeFileSync, mkdirSync } from 'node:fs';

const email = 'olafur.g@gmail.com';
const size = 200;
const hash = createHash('md5').update(email).digest('hex');
const url = `https://gravatar.com/avatar/${hash}?s=${size}`;

console.log(`Downloading Gravatar for ${email}...`);
const res = await fetch(url);
if (!res.ok) {
  console.error(`Failed to download Gravatar: ${res.statusText}`);
  process.exit(1);
}

mkdirSync('public/images', { recursive: true });
writeFileSync('public/images/gravatar.png', Buffer.from(await res.arrayBuffer()));
console.log('Gravatar saved to public/images/gravatar.png');
