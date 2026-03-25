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

