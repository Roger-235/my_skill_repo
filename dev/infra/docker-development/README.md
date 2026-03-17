# docker-development

## 用途

生成生產品質的 Dockerfile 與 Docker Compose 配置，包含多階段建構、安全強化，以及開發與生產環境分離。

## 觸發方式

當使用者要求將應用程式容器化、建立 Dockerfile 或 docker-compose.yml、最佳化現有容器設置，或建立以容器為基礎的開發工作流程時觸發。

## 使用步驟

1. 分析專案結構——語言、執行環境、套件管理器、入口點
2. 選擇基礎映像策略（slim/alpine/distroless）
3. 設計多階段 Dockerfile（deps → builder → production）
4. 應用安全強化（非 root 使用者、.dockerignore、HEALTHCHECK）
5. 依需求生成 docker-compose.yml 與 .dockerignore
6. 提供快速啟動指令

## 規則

### 必須
- 所有已編譯語言與 Node.js 生產映像使用多階段建構
- 最終階段以非 root 使用者執行應用程式
- 生成 Dockerfile 時同步建立 .dockerignore
- 固定基礎映像版本（例如 `node:20.11-alpine3.19`），不使用 `latest`
- 生產 Dockerfile 包含 `HEALTHCHECK`

### 禁止
- 在沒有 .dockerignore 排除 .env 的情況下使用 `COPY . .`
- 在 Dockerfile 或 docker-compose.yml 中硬編碼 Secret
- 在生產映像中暴露不必要的連接埠
- 在生產階段安裝開發依賴
- 未經明確說明需求不使用 `--privileged` 模式

## 範例

### 正確用法

使用者：「將我的 FastAPI 應用容器化用於生產。」

生成多階段 `Dockerfile`：`builder` 階段使用 `python:3.12` 安裝依賴；`production` 階段使用 `python:3.12-slim`，僅複製 venv 與應用程式碼，建立 `appuser`，設定 `USER appuser`，加入 `HEALTHCHECK`，暴露 8000 埠。

### 錯誤用法

生成 `FROM python:latest`、`COPY . .`、`RUN pip install -r requirements.txt`、`CMD python app.py`——使用 `latest`、單一階段、複製 .env、以 root 執行、無健康檢查。
