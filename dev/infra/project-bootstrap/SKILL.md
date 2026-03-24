---
name: project-bootstrap
description: "Scaffolds a production-ready project from scratch: auto-detects stack, creates Clean Architecture directory structure, generates Dockerfile (multi-stage), GitHub Actions CI/CD, linting config, pre-commit hooks, .env.example, health check endpoint, and test infrastructure. One command to go from empty folder to runnable project skeleton. Triggers: bootstrap project, scaffold project, new project setup, create project, start project, initialize codebase, 建立新專案, 初始化專案, 專案架構."
metadata:
  category: dev
disable-model-invocation: true
---

## Purpose

Eliminate the "blank repo paralysis" and inconsistent project setups across teams. One skill invocation produces a consistent, production-ready skeleton with all cross-cutting concerns already wired: CI/CD, Docker, linting, testing, health checks, logging, and security defaults.

## Trigger

Apply when:
- "bootstrap project", "scaffold new project", "create project from scratch", "建立新專案"
- "new [framework] project", "initialize codebase", "start a [language] project"
- Empty or near-empty directory with no established structure

Do NOT trigger for:
- Migrating an existing project structure — use `migration-architect` instead
- Adding CI/CD to an existing project — use `ci-cd-pipeline-builder` instead
- Dockerizing an existing project — use `docker-patterns` instead

## Prerequisites

- User specifies (or Claude infers from context): language, framework, and project type
- Working directory is the target project root
- Git initialized (`git init`) or Claude initializes it

## Steps

### Step 1 — Detect or Confirm Stack

Ask the user (or infer from existing files) for:
1. **Language**: TypeScript / Python / Go / Java / Ruby
2. **Framework**: Next.js / Express / FastAPI / Django / Gin / Spring Boot / Rails
3. **Project type**: API server / Full-stack web / CLI tool / Data pipeline / Library
4. **Database** (if applicable): PostgreSQL / MySQL / MongoDB / SQLite / None

If files already exist (e.g., `package.json`, `pyproject.toml`), read them to confirm.

### Step 2 — Create Directory Structure

Apply Clean Architecture layering appropriate for the stack. Full templates per stack: [ref/stack-templates.md](ref/stack-templates.md)

**TypeScript / Node.js API:**
```
src/
├── api/          # Route handlers (HTTP boundary)
├── services/     # Business logic (no framework deps)
├── models/       # Data models and DB access
├── middleware/   # Auth, logging, error handling
├── config/       # Environment config loading
└── utils/        # Pure utility functions
tests/
├── unit/
├── integration/
└── e2e/
docs/
infra/
├── docker/
└── k8s/          # Optional
```

**Python / FastAPI:**
```
src/
├── api/          # Routers and schemas (Pydantic)
├── services/     # Business logic
├── repositories/ # DB access (SQLAlchemy)
├── models/       # ORM models
├── core/         # Config, security, dependencies
└── utils/
tests/
├── unit/
├── integration/
└── conftest.py
```

**Go:**
```
cmd/[service]/    # Entry point
internal/
├── api/          # HTTP handlers
├── service/      # Business logic
├── repository/   # DB access
├── model/        # Domain types
└── config/
pkg/              # Public reusable packages
tests/
```

### Step 3 — Generate Core Files

Create these files for every stack:

**`.claude/CLAUDE.md`** (lean, `@` import pattern):
```markdown
# [Project Name]

## Stack
[detected stack — e.g. Next.js 15 / TypeScript / PostgreSQL]

## Commands
- Dev:   `[dev command]`
- Test:  `[test command]`
- Build: `[build command]`

## Conventions
- Conventional Commits (feat/fix/chore/docs/refactor)
- PRs require description — use `/pr-description-writer`
- Specs before new features — use `/spec-writer`

## Skills
@.claude/skill/dev/_index.md
@.claude/skill/meta/_index.md
```
> Pruning rule: every line must answer "yes" to "would removing this cause Claude to make a mistake?" — delete anything that doesn't pass.

**`.env.example`**
```bash
# Application
APP_ENV=development
APP_PORT=8080
LOG_LEVEL=info

# Database (if applicable)
DATABASE_URL=postgresql://user:password@localhost:5432/dbname

# Secrets (never commit actual values)
JWT_SECRET=change-me-in-production
API_KEY=change-me-in-production
```

**`Dockerfile` (multi-stage):**
```dockerfile
# Stage 1: Build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# Stage 2: Runtime (minimal)
FROM node:20-alpine AS runtime
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY --chown=appuser:appgroup . .
USER appuser
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s CMD wget -q --spider http://localhost:8080/health || exit 1
CMD ["node", "dist/index.js"]
```

**Health check endpoint:**
```typescript
// src/api/health.ts
app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString(), version: process.env.npm_package_version });
});
```

**`docker-compose.yml` (local dev):**
```yaml
services:
  app:
    build: .
    ports: ["8080:8080"]
    env_file: .env
    depends_on: [db]
  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: ${DB_NAME:-appdb}
      POSTGRES_USER: ${DB_USER:-appuser}
      POSTGRES_PASSWORD: ${DB_PASSWORD:-changeme}
    volumes: [pgdata:/var/lib/postgresql/data]
volumes:
  pgdata:
```

### Step 4 — Generate CI/CD Pipeline

**`.github/workflows/ci.yml`:**
```yaml
name: CI
on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: '20', cache: 'npm' }
      - run: npm ci
      - run: npm run lint
      - run: npm run typecheck
      - run: npm test -- --coverage
      - uses: codecov/codecov-action@v4

  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: docker/build-push-action@v5
        with:
          context: .
          push: false
          tags: app:${{ github.sha }}
```

### Step 5 — Linting and Pre-commit Hooks

**`.pre-commit-config.yaml`:**
```yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: detect-private-key    # Block accidental secret commits
      - id: check-added-large-files
  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.18.1
    hooks:
      - id: gitleaks               # Secret scanner
```

### Step 6 — Verify and Summarize

After generating all files:
```bash
# Verify project structure
ls -la

# Install dependencies
[npm install | pip install -e ".[dev]" | go mod tidy]

# Run initial build/typecheck
[npm run build | python -m pytest --collect-only | go build ./...]

# Initialize git (if not done)
git add .
git commit -m "chore: initialize project scaffold"
```

## Output Format

```
Project bootstrapped: [project-name]
Stack: [language] / [framework]

Generated:
  src/           Clean Architecture layers
  tests/         Unit + integration + e2e stubs
  Dockerfile     Multi-stage, non-root user
  docker-compose.yml  Local dev environment
  .github/workflows/ci.yml  Lint + test + build
  .env.example   All required env vars documented
  .pre-commit-config.yaml  Secret scanner + formatting
  [framework-specific linting config]

Next steps:
  1. cp .env.example .env && fill in values
  2. npm install (or equivalent)
  3. docker compose up -d db
  4. npm run dev
```

## Rules

### Must
- Use multi-stage Docker builds — never ship build tools in the runtime image
- Run application as non-root user in Docker
- Include `detect-private-key` pre-commit hook — block accidental secret commits
- Generate `.env.example` with every variable documented — never generate `.env` with real values
- Add health check endpoint on every HTTP service

### Never
- Never hardcode secrets, passwords, or API keys in any generated file
- Never use `latest` Docker image tags — always pin to a specific version
- Never skip the `HEALTHCHECK` Dockerfile instruction for HTTP services
- Never generate a project without a `.gitignore` appropriate for the stack

## Examples

### Good Example

```
User: "Bootstrap a FastAPI project with PostgreSQL"

Generated:
  src/ (api/, services/, repositories/, models/, core/)
  Dockerfile (python:3.12-slim, non-root, multi-stage)
  docker-compose.yml (app + postgres:16-alpine)
  .github/workflows/ci.yml (ruff lint, mypy, pytest)
  .env.example (DATABASE_URL, JWT_SECRET documented)
  .pre-commit-config.yaml (gitleaks, trailing-whitespace)

Next: cp .env.example .env → docker compose up
```

### Bad Example

```
User: "New Python project"

Claude creates a single main.py with all logic in one file,
no tests, no Docker, no CI, no .env handling.
```

> Why this is bad: A flat structure becomes unmaintainable at scale. Missing Docker means "works on my machine" bugs. Missing secret scanning means one accidental commit exposes credentials. Bootstrap once correctly beats retrofitting structure later.
