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

