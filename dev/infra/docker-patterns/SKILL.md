---
name: docker-patterns
description: "Dockerfile and Docker Compose best practices: minimal base images, multi-stage builds, non-root users, layer caching, and .dockerignore. Trigger when: Dockerfile, Docker, containerize, docker-compose, container best practices, multi-stage build, 容器化, 寫 Dockerfile, Docker 優化, docker 設定."
metadata:
  category: dev
  version: "1.0"
---

# Docker Patterns

Produces secure, minimal, and efficiently-cached Docker images using multi-stage builds, non-root users, and proper layer ordering.

## Purpose

Produce secure, minimal, and efficiently-cached Docker images using multi-stage builds, non-root users, and proper layer ordering to reduce image size, attack surface, and CI build times.

## Trigger

Apply when the user requests:
- "Dockerfile", "Docker", "containerize", "docker-compose", "container best practices"
- "multi-stage build", "Docker optimization", "write a Dockerfile"
- "容器化", "寫 Dockerfile", "Docker 優化", "docker 設定"

Do NOT trigger for:
- Kubernetes configuration (different domain and tooling)
- CI/CD pipeline setup — use a dedicated ci-cd-pipeline skill

## Prerequisites

- Docker installed on the target machine
- Knowledge of the application's runtime and build requirements (language, runtime version, build tools)

## Steps

1. **Choose a minimal base image** — prefer distroless, `alpine`, or `-slim` variants over full OS images; always use specific version tags (e.g., `node:20-alpine`), never `latest`
2. **Use multi-stage builds** — define a `builder` stage with all build tools installed; define a separate `runtime` stage using a minimal base; copy only the compiled artifact or production files from the builder to the runtime stage
3. **Set a non-root user** — create a dedicated user and group with minimal permissions in the runtime stage; set `USER` before the final `CMD`/`ENTRYPOINT`; never run production containers as root
4. **Optimize layer caching** — copy dependency manifests (`package.json`, `requirements.txt`, `go.mod`/`go.sum`, `Cargo.toml`) before copying source code so that the dependency installation layer is cached across builds that only change source files
5. **Create .dockerignore** — exclude: `node_modules/`, `.git/`, `*.log`, `.env`, local config files, test directories, documentation, and any development-only assets
6. **Write docker-compose for local development** — use bind-mount volumes for hot reload; define service dependencies with `depends_on`; expose only the ports needed; load secrets from `.env` file, never hard-code them

## Output Format

```
## Docker Configuration: <service name>

### Image Analysis
Base image: <chosen image and reason>
Estimated final size: ~X MB

### Dockerfile
<multi-stage Dockerfile content>

### .dockerignore
<.dockerignore content>

### docker-compose.yml (local dev)
<docker-compose content if applicable>
```

## Rules

### Must
- Always use specific image tags (e.g., `node:20-alpine`, `python:3.12-slim`), never `latest`
- Always run as a non-root user in the final runtime stage
- Always include a `.dockerignore` to prevent cache-busting and secret leaks
- Always separate build-time dependencies from runtime dependencies using multi-stage builds
- Copy dependency manifests before source code to maximize layer cache hits

### Never
- Never store secrets in `Dockerfile` `ENV` or `ARG` instructions that persist to the final image — use runtime environment variables or secret mounts instead
- Never `COPY . .` the entire build context without a `.dockerignore`
- Never install development tools (`gcc`, `make`, `npm`, build compilers) in the final runtime stage
- Never use `RUN apt-get install` without `--no-install-recommends` and without cleaning up the apt cache in the same layer

## Examples

### Good Example

```dockerfile
# Stage 1: build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build

# Stage 2: runtime
FROM node:20-alpine AS runtime
WORKDIR /app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
USER appuser
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

Node.js app: `builder` stage uses `node:20-alpine` to install dependencies and compile TypeScript; `runtime` stage copies only `dist/` and `node_modules`; runs as non-root `appuser`.

### Bad Example

```dockerfile
FROM node:latest
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

> Why this is bad: Uses `node:latest` — the image version is unpredictable and will cause non-reproducible builds. Single-stage build means the final image contains all dev dependencies, build tools, and source files, resulting in a large image. Copies the entire repo (including `.env` and `node_modules`) without a `.dockerignore`. Runs as root, which means a container escape gives an attacker root on the host.
