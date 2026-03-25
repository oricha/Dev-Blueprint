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

