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

