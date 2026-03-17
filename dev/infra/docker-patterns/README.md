# Docker Patterns — Docker 最佳實踐

使用多階段建置、非 root 使用者與正確的層級順序，產生安全、最小化且具備高效快取的 Docker 映像檔。

## 功能

- 選擇最小化的基礎映像（distroless、alpine、slim 變體）
- 使用多階段建置（multi-stage build）分離建置工具與執行環境
- 設定非 root 使用者，降低容器被攻破時的風險
- 最佳化層級快取順序：先複製依賴清單，再複製原始碼
- 生成 `.dockerignore` 防止快取失效與機密洩漏
- 提供本地開發用的 `docker-compose.yml`，支援熱重載

## 觸發時機

**手動觸發**：
- 「Dockerfile」、「Docker」、「containerize」、「docker-compose」
- 「container best practices」、「multi-stage build」、「Docker optimization」
- 「容器化」、「寫 Dockerfile」、「Docker 優化」、「docker 設定」

**不觸發**：
- Kubernetes 設定（不同領域與工具）
- CI/CD 流程設定 → 改用專屬的 ci-cd-pipeline skill

## 使用方法

告訴 Claude 你的應用程式語言、執行環境版本與主要需求，skill 會輸出完整的 Docker 設定：

**輸出格式範例**：

```
## Docker Configuration: <服務名稱>

### Image Analysis
Base image: <選擇的映像檔及原因>
Estimated final size: ~X MB

### Dockerfile
<多階段 Dockerfile 內容>

### .dockerignore
<.dockerignore 內容>

### docker-compose.yml (local dev)
<docker-compose 內容（如適用）>
```

**Node.js 多階段建置範例**：

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

## 前置需求

- Docker 已安裝於目標機器
- 已知應用程式的執行環境與建置需求（語言、runtime 版本、建置工具）

## 安全性

- 永遠使用具體的映像標籤（如 `node:20-alpine`），禁止使用 `latest`
- 執行階段映像必須使用非 root 使用者
- 禁止在 `Dockerfile` 的 `ENV` 或 `ARG` 指令中儲存機密（會保存到最終映像中）
- 必須建立 `.dockerignore` 以防止 `.env` 等機密檔案被複製進映像
- 禁止在執行階段安裝建置工具（`gcc`、`make`、`npm` 等）
- `apt-get install` 必須加上 `--no-install-recommends` 並在同一層清除快取
