#!/usr/bin/env bash
# =============================================================================
# SampleProject bootstrap script
# Generates an AI-agent-optimised project scaffold.
# Usage: bash init-sampleproject.sh          (runs in current dir)
#        bash init-sampleproject.sh MyDir    (runs in MyDir/)
# =============================================================================
set -euo pipefail

ROOT="${1:-.}"
mkdir -p "$ROOT"
cd "$ROOT"

echo "→ Creating directory skeleton..."
mkdir -p \
  docs/decisions \
  docs/runbooks \
  .claude/hooks \
  .claude/skills/build \
  .claude/skills/test \
  tools/scripts \
  tools/prompts \
  src/api \
  src/persistence

# =============================================================================
# CLAUDE.md  – root "brain" of the repo
# =============================================================================
cat > CLAUDE.md << 'EOF'
# CLAUDE.md — Project Brain

This file is the primary context document for AI agents working in this repository.
Read it fully before making any changes. Keep it updated as the project evolves.

---

## 1. What This Project Is About

> **TODO:** Replace this section with a 2–3 sentence description of the product,
> its purpose, and its target users.

SampleProject is a base template optimised for AI-assisted development workflows.
It provides memory, scoped context, and reusable skills so agents (Claude, Codex,
Cursor, etc.) can work autonomously and accurately.

---

## 2. Tech Stack

| Layer       | Technology         | Notes                              |
|-------------|--------------------|------------------------------------|
| Runtime     | Node.js 20 / Java  | TBD per module                     |
| API         | REST / GraphQL     | See `src/api/`                     |
| Database    | PostgreSQL         | Migrations in `src/persistence/`   |
| Auth        | JWT / OAuth 2.0    | —                                  |
| CI/CD       | GitHub Actions     | Workflows in `.github/workflows/`  |
| Deployment  | Docker + Fargate   | See `docs/runbooks/deploy.md`      |

---

## 3. Main Data Models

> **TODO:** List the core domain entities here once defined.

```
User { id, email, role, createdAt }
Project { id, ownerId, name, status, createdAt }
```

---

## 4. Project Structure (high-level)

```
.
├── CLAUDE.md              ← you are here (root context)
├── README.md
├── docs/
│   ├── architecture.md
│   ├── decisions/         ← ADRs
│   └── runbooks/          ← operational guides
├── .claude/
│   ├── settings.json      ← agent permissions & tool config
│   ├── hooks/             ← pre/post-task automation
│   └── skills/            ← reusable agent workflows
├── tools/
│   ├── scripts/           ← utility scripts
│   └── prompts/           ← reusable prompt templates
└── src/
    ├── api/               ← backend module (has its own CLAUDE.md)
    └── persistence/       ← DB layer, migrations, AI memory
```

---

## 5. Absolute Rules for AI Agents

1. **Do NOT auto-commit on every file change.** Only commit when explicitly asked
   or when a skill step instructs you to.
2. **Do NOT run database migrations automatically.** Always confirm with the user
   before executing any destructive DB operation.
3. **Keep CLAUDE.md updated.** If you add a module, data model, or technology,
   update the relevant section above.
4. **Prefer editing existing files over creating new ones** unless a new file is
   clearly necessary.
5. **No over-engineering.** Implement only what is asked. Do not add extra
   abstractions, error-handling, or features speculatively.
6. **Security first.** Never log secrets, never commit `.env` files, never
   introduce SQL injection / XSS / command-injection vulnerabilities.
7. **Living docs.** When you make an architectural decision, record it as an ADR
   in `docs/decisions/`.

---

## 6. Available Skills (shortcuts)

| Skill      | Location                        | What it does                        |
|------------|---------------------------------|-------------------------------------|
| `/build`   | `.claude/skills/build/SKILL.md` | Compile, lint, fix errors, report   |
| `/test`    | `.claude/skills/test/SKILL.md`  | Run tests, fix failures, summarise  |

EOF

# =============================================================================
# README.md
# =============================================================================
cat > README.md << 'EOF'
# SampleProject

> A base template optimised for AI-assisted development with Claude, Codex,
> Cursor, and similar agents.

## Features

- **Global + scoped context** via root and module-level `CLAUDE.md` files
- **Reusable agent skills** (`.claude/skills/`) — no more copy-pasting prompts
- **Living documentation** (`docs/`) maintained by the AI as the project grows
- **Automation hooks** (`.claude/hooks/`) for Slack/Telegram notifications,
  pre-commit checks, and more
- **Utility scripts** (`tools/scripts/`) for common development chores

## Quick Start

```bash
# 1. Clone / use as template
git clone <repo-url> my-project && cd my-project

# 2. Install dependencies (adjust to your stack)
npm install          # or: mvn install / pip install -r requirements.txt

# 3. Copy environment variables
cp .env.example .env && $EDITOR .env

# 4. Run locally
npm run dev
```

## Project Layout

```
CLAUDE.md         Agent brain (start here)
README.md         This file
docs/             Architecture, ADRs, runbooks
.claude/          AI agent config, hooks, skills
tools/            Scripts and prompt templates
src/              Application source code
```

## Documentation

| Document | Description |
|----------|-------------|
| [Architecture](docs/architecture.md) | System design & diagram |
| [ADR Index](docs/decisions/00-index.md) | Architecture decision log |
| [Deploy runbook](docs/runbooks/deploy.md) | How to ship to production |
| [Migrations runbook](docs/runbooks/migrations.md) | DB migration guide |

## Contributing

1. Read `CLAUDE.md` before making changes.
2. Record any significant decision as an ADR in `docs/decisions/`.
3. Run `/build` and `/test` skills before opening a PR.

EOF

# =============================================================================
# docs/architecture.md
# =============================================================================
cat > docs/architecture.md << 'EOF'
# Architecture

> Keep this document updated. AI agents should update it when a new module,
> service, or significant design change is introduced.

---

## System Overview

> **TODO:** Replace with a 3–5 sentence description of how the system works end-
> to-end (user → client → API → DB → external services).

---

## High-Level Diagram

```
┌─────────────┐     HTTPS      ┌──────────────┐     SQL      ┌──────────────┐
│   Client    │ ─────────────► │   API (src/) │ ───────────► │  PostgreSQL  │
│ (Web / App) │                │              │              │              │
└─────────────┘                └──────┬───────┘              └──────────────┘
                                      │
                                      │  Events / Queues
                                      ▼
                               ┌──────────────┐
                               │ External Svc │
                               │ (Email, S3…) │
                               └──────────────┘
```

---

## Modules

| Module              | Path              | Responsibility                    |
|---------------------|-------------------|-----------------------------------|
| API                 | `src/api/`        | HTTP handlers, business logic     |
| Persistence         | `src/persistence/`| DB models, migrations, AI memory  |

---

## Key Design Decisions

See [`docs/decisions/`](decisions/) for the full ADR log.

EOF

# =============================================================================
# docs/decisions/00-index.md
# =============================================================================
cat > docs/decisions/00-index.md << 'EOF'
# Architecture Decision Records (ADR) — Index

This folder records all significant architectural choices made in this project.
AI agents must create a new ADR file here whenever they introduce or recommend
a technology, pattern, or structural change.

## How to Create an ADR

1. Copy the template below into a new file: `NN-short-title.md`
2. Fill in all sections.
3. Add a row to the table in this index file.

### ADR Template

```markdown
# ADR-NN: Title

**Date:** YYYY-MM-DD
**Status:** Proposed | Accepted | Deprecated | Superseded by ADR-XX

## Context
Why does this decision need to be made?

## Decision
What was decided?

## Consequences
What are the trade-offs and implications?
```

---

## Decision Log

| #  | Title                          | Status   | Date       |
|----|--------------------------------|----------|------------|
| 00 | ADR index and process          | Accepted | 2024-01-01 |

EOF

# =============================================================================
# docs/runbooks/deploy.md
# =============================================================================
cat > docs/runbooks/deploy.md << 'EOF'
# Runbook: Deploy to Production

> **Audience:** Developers and AI agents performing a production release.
> Update this document whenever the deployment process changes.

---

## Prerequisites

- [ ] All tests passing (`/test` skill shows green)
- [ ] Build succeeds (`/build` skill shows no errors)
- [ ] PR approved and merged to `main`
- [ ] Environment variables set in the target environment

---

## Steps

### 1. Build the production artefact

```bash
npm run build         # or: mvn package -DskipTests
```

### 2. Run database migrations (if any)

> ⚠️ Always take a DB snapshot before running migrations in production.

```bash
npm run db:migrate
```

### 3. Deploy

```bash
# Example: push Docker image and update ECS service
docker build -t sampleproject:$(git rev-parse --short HEAD) .
docker push <registry>/sampleproject:$(git rev-parse --short HEAD)
# Update your ECS / Kubernetes manifest here
```

### 4. Smoke test

```bash
curl -sf https://<production-url>/health | jq .
```

### 5. Notify the team

Post in the `#deployments` Slack channel with the deployed version and any
notable changes.

---

## Rollback

```bash
# Re-deploy the previous image tag
docker pull <registry>/sampleproject:<previous-tag>
# Update manifest to previous tag and re-deploy
```

EOF

# =============================================================================
# docs/runbooks/migrations.md
# =============================================================================
cat > docs/runbooks/migrations.md << 'EOF'
# Runbook: Database Migrations

> AI agents must never run migrations automatically. Always confirm with the
> user before executing any command in this runbook.

---

## Create a New Migration

```bash
npm run db:migration:create -- --name describe_your_change
# Edit the generated file in src/persistence/migrations/
```

## Run Pending Migrations

```bash
# Local / staging
npm run db:migrate

# Production — take a snapshot first!
npm run db:migrate:prod
```

## Rollback Last Migration

```bash
npm run db:migrate:undo
```

## Check Migration Status

```bash
npm run db:migrate:status
```

---

## Guidelines for AI Agents

1. Never run `db:migrate:prod` without explicit user approval.
2. Always review the generated migration SQL before applying.
3. Prefer additive migrations (add columns / tables) over destructive ones
   (drop columns / tables) and leave a deprecation window.

EOF

# =============================================================================
# .claude/settings.json
# =============================================================================
cat > .claude/settings.json << 'EOF'
{
  "projectName": "SampleProject",
  "description": "AI-agent-optimised project template",

  "permissions": {
    "allow": [
      "Bash(npm run *)",
      "Bash(git status)",
      "Bash(git diff *)",
      "Bash(git log *)",
      "Bash(git add *)",
      "Bash(git commit *)",
      "Bash(node tools/scripts/*)"
    ],
    "deny": [
      "Bash(git push --force*)",
      "Bash(rm -rf *)",
      "Bash(DROP TABLE*)",
      "Bash(npm run db:migrate:prod)"
    ]
  },

  "tools": {
    "web_search": true,
    "file_read": true,
    "file_write": true,
    "bash": true
  },

  "context": {
    "always_include": [
      "CLAUDE.md",
      "docs/architecture.md"
    ]
  },

  "hooks": {
    "post_task": ".claude/hooks/notify-slack.sh",
    "pre_commit": ".claude/hooks/pre-commit-check.sh"
  }
}
EOF

# =============================================================================
# .claude/hooks/notify-slack.sh
# =============================================================================
cat > .claude/hooks/notify-slack.sh << 'EOF'
#!/usr/bin/env bash
# Hook: post_task — fires after the AI agent finishes a task.
# Sends a Slack notification with the task summary.
#
# Required env vars:
#   SLACK_WEBHOOK_URL  – Incoming Webhook URL from Slack App settings
#   SLACK_CHANNEL      – e.g. "#dev-notifications"
#
# The agent runtime passes task metadata via stdin as JSON:
#   { "task": "...", "status": "success|error", "summary": "..." }

set -euo pipefail

if [[ -z "${SLACK_WEBHOOK_URL:-}" ]]; then
  echo "SLACK_WEBHOOK_URL not set — skipping Slack notification." >&2
  exit 0
fi

INPUT=$(cat)
TASK=$(echo "$INPUT"    | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('task','unknown task'))")
STATUS=$(echo "$INPUT"  | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('status','unknown'))")
SUMMARY=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('summary',''))")

ICON=":white_check_mark:"
[[ "$STATUS" == "error" ]] && ICON=":x:"

PAYLOAD=$(cat <<JSON
{
  "channel": "${SLACK_CHANNEL:-#dev-notifications}",
  "text": "$ICON *AI agent finished:* $TASK\n$SUMMARY"
}
JSON
)

curl -s -X POST -H 'Content-type: application/json' \
  --data "$PAYLOAD" \
  "$SLACK_WEBHOOK_URL"

echo "Slack notification sent."
EOF
chmod +x .claude/hooks/notify-slack.sh

# =============================================================================
# .claude/hooks/pre-commit-check.sh
# =============================================================================
cat > .claude/hooks/pre-commit-check.sh << 'EOF'
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
EOF
chmod +x .claude/hooks/pre-commit-check.sh

# =============================================================================
# .claude/skills/build/SKILL.md
# =============================================================================
cat > .claude/skills/build/SKILL.md << 'EOF'
# Skill: /build

Invoke this skill with `/build` to compile the project, catch errors, and
leave the working tree in a clean, passing state.

---

## Steps

1. **Install dependencies** (if `node_modules` or equivalent is missing)
   ```bash
   npm install
   ```

2. **Run the build**
   ```bash
   npm run build
   ```

3. **Evaluate the output**
   - If the build **succeeds** → proceed to step 5.
   - If the build **fails** → proceed to step 4.

4. **Fix build errors** (iterate until resolved)
   - Read the compiler / bundler error messages carefully.
   - Locate the offending files and fix the issues.
   - Re-run `npm run build` after each fix.
   - Do NOT move on until the build is green.

5. **Run the linter**
   ```bash
   npm run lint --if-present
   ```
   Fix any lint errors before continuing.

6. **Report**
   - Summarise what was built, any files changed, and confirm the build is green.
   - If you changed source files to fix errors, briefly explain what was wrong.

---

## Notes for the Agent

- Never skip a failing build by commenting out code or disabling type checks.
- If a dependency is missing, add it with `npm install <pkg>` and update
  `package.json` accordingly.
- Do not commit during this skill unless explicitly instructed.

EOF

# =============================================================================
# .claude/skills/test/SKILL.md
# =============================================================================
cat > .claude/skills/test/SKILL.md << 'EOF'
# Skill: /test

Invoke this skill with `/test` to run the full test suite, fix any failures,
and produce a clear summary of results.

---

## Steps

1. **Ensure the build is passing first**
   - Run `/build` if there is any doubt.

2. **Run the full test suite**
   ```bash
   npm test
   ```

3. **Evaluate results**
   - If **all tests pass** → proceed to step 5.
   - If **tests fail** → proceed to step 4.

4. **Fix failing tests** (iterate until resolved)
   - Read each failing test name and assertion carefully.
   - Determine whether the **implementation** or the **test** is wrong:
     - If the implementation is wrong → fix the source code.
     - If the test expectation is outdated → update the test with a comment
       explaining why.
   - Re-run `npm test` after each fix.
   - Do NOT mock away real behaviour to make tests pass artificially.

5. **Run coverage report** (if available)
   ```bash
   npm run test:coverage --if-present
   ```

6. **Report**
   - Total tests: passed / failed / skipped.
   - List any tests you fixed and what the root cause was.
   - Note any coverage regressions.

---

## Notes for the Agent

- Prefer fixing the root cause over patching individual test assertions.
- Never delete a test to make the suite pass.
- If a test requires a running database or external service, note this in the
  report and advise the user to run the dependency first.

EOF

# =============================================================================
# tools/scripts/create-user.js
# =============================================================================
cat > tools/scripts/create-user.js << 'EOF'
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
EOF

# =============================================================================
# tools/prompts/code-review.md
# =============================================================================
cat > tools/prompts/code-review.md << 'EOF'
# Prompt Template: Code Review

Use this template when asking the AI to review a pull request or set of
changed files.

---

## Prompt

```
You are a senior software engineer performing a code review.

**Files changed:** [LIST FILES OR PASTE DIFF]

Please review the changes above and provide feedback on:

1. **Correctness** – Are there any bugs or logical errors?
2. **Security** – Are there SQL injection, XSS, command injection, or secret-
   leakage risks?
3. **Performance** – Are there obvious N+1 queries, unnecessary re-renders, or
   blocking I/O?
4. **Readability** – Is the code clear? Are variable/function names descriptive?
5. **Test coverage** – Are the changes adequately tested?

For each issue found, provide:
- The file name and line number
- A brief description of the problem
- A suggested fix (code snippet if helpful)

Finally, give an overall verdict: **Approve / Request Changes / Needs Discussion**
```

EOF

# =============================================================================
# tools/prompts/refactor.md
# =============================================================================
cat > tools/prompts/refactor.md << 'EOF'
# Prompt Template: Refactor

Use this template when asking the AI to refactor an existing module.

---

## Prompt

```
Refactor the following code in [FILE PATH].

Goals:
1. Improve readability without changing external behaviour.
2. Remove duplication — extract repeated logic into shared helpers only when
   it is used in 3+ places.
3. Simplify overly complex conditionals.
4. Do NOT add new features, error handling, or abstractions that aren't needed
   by the current code.

After refactoring:
- Show the full updated file.
- Briefly explain each change and why it improves the code.
- Confirm that no behaviour was changed.
```

EOF

# =============================================================================
# src/api/CLAUDE.md  – scoped context for the API module
# =============================================================================
cat > src/api/CLAUDE.md << 'EOF'
# CLAUDE.md — API Module (src/api/)

> This is a **scoped** context file. It applies only to the `src/api/` module.
> For global rules and project overview, see the root `CLAUDE.md`.

---

## Module Purpose

This directory contains HTTP route handlers, controllers, middleware, and
business-logic services for the application's API layer.

---

## Module Structure

```
src/api/
├── routes/        – Express / Fastify route definitions
├── controllers/   – Request/response handling (thin layer)
├── services/      – Business logic (testable, framework-agnostic)
├── middleware/    – Auth, validation, error-handling middleware
└── dto/           – Data Transfer Objects / request-validation schemas
```

---

## Conventions

- **Controllers stay thin:** Extract all non-trivial logic into a `service`.
- **Validation at the boundary:** Use a DTO/schema (e.g., Zod, Joi) to validate
  every incoming request before it reaches a controller.
- **No direct DB calls in controllers:** Always go through a service, which
  calls a repository in `src/persistence/`.
- **Error handling:** Throw typed errors (e.g., `NotFoundError`,
  `ValidationError`); the global error middleware converts them to HTTP responses.

---

## Local Rules for AI Agents

1. Do not add new routes without a corresponding service and at least one unit
   test.
2. Never put business logic inside a route handler directly.
3. Keep middleware functions pure and side-effect-free where possible.
4. When adding a new endpoint, update `docs/architecture.md` if it introduces
   a new integration or data flow.

EOF

# =============================================================================
# src/persistence/.gitkeep  – placeholder so git tracks the folder
# =============================================================================
cat > src/persistence/.gitkeep << 'EOF'
# This folder holds database models, migration files, and AI agent memory /
# transcript persistence. Add your ORM models and migration scripts here.
#
# Suggested layout:
#   src/persistence/
#   ├── models/          – ORM entity definitions
#   ├── migrations/      – ordered DB migration files
#   └── memory/          – long-term AI agent state / conversation transcripts
EOF

# =============================================================================
# .env.example
# =============================================================================
cat > .env.example << 'EOF'
# Copy this file to .env and fill in real values.
# NEVER commit .env to version control.

DATABASE_URL=postgres://user:password@localhost:5432/sampleproject
JWT_SECRET=change-me
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/XXX/YYY/ZZZ
SLACK_CHANNEL=#dev-notifications
NODE_ENV=development
PORT=3000
EOF

# =============================================================================
# .gitignore
# =============================================================================
cat > .gitignore << 'EOF'
# Environment
.env
.env.local
.env.*.local

# Dependencies
node_modules/
.pnp
.pnp.js

# Build output
dist/
build/
*.class
target/

# Logs
*.log
npm-debug.log*

# OS artefacts
.DS_Store
Thumbs.db

# AI / editor config (keep .claude/ but ignore local overrides)
.claude/settings.local.json

# Test coverage
coverage/
.nyc_output/

# Persistence / memory (may contain sensitive data)
src/persistence/memory/
EOF

echo ""
echo "✓ SampleProject scaffold created successfully."
echo ""
echo "Next steps:"
echo "  1. cd $ROOT"
echo "  2. git init && git add . && git commit -m 'chore: initialise AI-optimised project scaffold'"
echo "  3. cp .env.example .env  &&  edit .env with real values"
echo "  4. Open CLAUDE.md and fill in your project's description, tech stack, and data models."
