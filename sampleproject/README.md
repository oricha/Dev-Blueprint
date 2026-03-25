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

