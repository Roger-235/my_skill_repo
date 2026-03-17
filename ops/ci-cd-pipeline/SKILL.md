---
name: ci-cd-pipeline
description: "CI/CD pipeline design and configuration guide for GitHub Actions, GitLab CI, and similar systems. Trigger when: set up CI, GitHub Actions, CI/CD pipeline, build pipeline, automated testing pipeline, 設定 CI/CD, 建立 pipeline, 自動化部署流程, CI 設定."
metadata:
  category: ops
  version: "1.0"
---

# CI/CD Pipeline

Designs and configures CI/CD pipelines for any language and CI system, covering all stages from lint to production deployment with secrets management and caching best practices.

## Purpose

Guide the complete CI/CD pipeline setup: identify the project stack, choose the CI system, design pipeline stages, write the configuration, configure caching and secrets, and define deployment promotion conditions.

## Trigger

Apply when user requests:
- "set up CI", "GitHub Actions", "CI/CD pipeline", "build pipeline", "automated testing pipeline"
- "設定 CI/CD", "建立 pipeline", "自動化部署流程", "CI 設定"

Do NOT trigger for:
- Executing a production deployment after the pipeline is live — use `deploy-ops`
- Debugging a failing CI run without setting up a new pipeline — handle inline

## Prerequisites

- Project language, build tool, and test framework must be known
- Deployment target must be identified (e.g., cloud provider, container registry, server)
- Access to the CI system's secret store to configure credentials

## Steps

1. **Identify project type** — language, build tool (npm, Maven, Go modules, etc.), test framework, and deployment target
2. **Choose the CI system** — select from GitHub Actions, GitLab CI, CircleCI, or other based on repository host and team preference
3. **Design pipeline stages** — define the full stage chain: lint → test → build → security scan → deploy (staging) → deploy (production)
4. **Write the pipeline configuration** — create the workflow file with each stage as a separate job; include job dependencies and branch conditions
5. **Configure dependency caching** — cache package manager artifacts (node_modules, pip cache, Go module cache) to reduce build times
6. **Set up secrets management** — reference all credentials from the CI secret store using environment variable syntax; never hardcode values
7. **Define deployment conditions** — staging deploys automatically on every push to main; production deployment requires successful staging deployment plus manual approval or a version tag

## Output Format

File path: `.github/workflows/ci.yml` (or equivalent for the chosen CI system)

```
## CI/CD Pipeline: <project name>

**CI System:** <GitHub Actions / GitLab CI / CircleCI / etc.>
**Stack:** <language + build tool + test framework>
**Deployment target:** <platform>

### Pipeline Stages
lint → test → build → security-scan → deploy-staging → deploy-prod

### Configuration
\`\`\`yaml
<pipeline YAML content>
\`\`\`

### Required Secrets
Configure these in the CI secret store — never commit values to the repository:
- <SECRET_NAME>: <description of what it is>
```

## Rules

### Must
- All credentials must reference the CI secret store — never hardcode tokens, passwords, or keys in config files
- Every pull request must pass lint and test stages before merge is allowed — enforce with branch protection rules
- Production deployment must require successful staging deployment first — never skip staging
- Include dependency caching for every language-specific package manager used

### Never
- Never hardcode secrets or credentials in pipeline configuration files
- Never skip the test stage to speed up builds
- Never commit pipeline config files containing actual secret values
- Never deploy to production without a rollback path defined in the pipeline or deployment system

## Examples

### Good Example

User: "Set up CI/CD for a Node.js app on GitHub Actions that deploys to Fly.io."

```
## CI/CD Pipeline: my-node-app

**CI System:** GitHub Actions
**Stack:** Node.js 20 + npm + Jest
**Deployment target:** Fly.io

### Pipeline Stages
lint → test → build → security-scan → deploy-staging → deploy-prod

### Configuration
\`\`\`yaml
name: CI/CD

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npm run lint

  test:
    needs: lint
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npm test

  deploy-staging:
    needs: test
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: superfly/flyctl-actions/setup-flyctl@master
      - run: flyctl deploy --app my-node-app-staging
        env:
          FLY_API_TOKEN: ${{ secrets.FLY_API_TOKEN }}

  deploy-prod:
    needs: deploy-staging
    if: startsWith(github.ref, 'refs/tags/v')
    environment: production
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: superfly/flyctl-actions/setup-flyctl@master
      - run: flyctl deploy --app my-node-app
        env:
          FLY_API_TOKEN: ${{ secrets.FLY_API_TOKEN }}
\`\`\`

### Required Secrets
- FLY_API_TOKEN: Fly.io deploy token — generate at fly.io/user/personal_access_tokens
```

### Bad Example

```
\`\`\`yaml
name: deploy
on: [push]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - run: |
          FLY_API_TOKEN=fo1_abc123secret flyctl deploy
\`\`\`
```

> Why this is bad: Hardcodes a real API token directly in the workflow file — anyone with repo access can read it. No lint or test stages. No caching. Deploys to production on every push to any branch. No staging gate. No rollback path.
