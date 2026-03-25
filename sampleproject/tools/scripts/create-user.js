#!/usr/bin/env node
/**
 * tools/scripts/create-user.js
 *
 * Seed script: creates one or more test users directly in the database,
 * bypassing the UI. Safe to run against local and staging environments.
 *
 * Usage:
 *   node tools/scripts/create-user.js
 *   node tools/scripts/create-user.js --count 5
 *   node tools/scripts/create-user.js --email custom@example.com --role admin
 *
 * Required env vars:
 *   DATABASE_URL  – e.g. postgres://user:pass@localhost:5432/mydb
 *
 * TODO: Replace the stub below with your actual DB client and User model.
 */

'use strict';

const args = process.argv.slice(2);
const get  = (flag, fallback) => {
  const idx = args.indexOf(flag);
  return idx !== -1 ? args[idx + 1] : fallback;
};

const count = parseInt(get('--count', '1'), 10);
const email = get('--email', null);
const role  = get('--role', 'user');

async function createUser(index) {
  const userEmail = email ?? `test-user-${Date.now()}-${index}@example.com`;

  // TODO: Replace with real DB call, e.g.:
  //   const user = await prisma.user.create({ data: { email: userEmail, role } });
  console.log(`[stub] Created user: { email: "${userEmail}", role: "${role}" }`);
}

(async () => {
  console.log(`Creating ${count} test user(s) with role="${role}"...`);
  for (let i = 0; i < count; i++) await createUser(i);
  console.log('Done.');
})();
