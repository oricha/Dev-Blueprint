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

