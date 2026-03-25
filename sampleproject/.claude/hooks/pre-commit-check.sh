#!/usr/bin/env bash
# Hook: pre_commit — runs before the agent commits code.
# Fails (non-zero exit) to block the commit if checks don't pass.

set -euo pipefail

echo "─── Pre-commit checks ───────────────────────────────"

# 1. Lint
echo "→ Linting..."
npm run lint --if-present

# 2. Unit tests
echo "→ Running tests..."
npm test --if-present

# 3. No secrets in staged files (simple heuristic)
echo "→ Checking for accidental secrets..."
if git diff --cached --name-only | xargs grep -lE \
   '(AKIA[0-9A-Z]{16}|password\s*=\s*["\x27][^"\x27]+["\x27])' 2>/dev/null; then
  echo "ERROR: Possible secret detected in staged files. Aborting commit." >&2
  exit 1
fi

echo "✓ All pre-commit checks passed."
