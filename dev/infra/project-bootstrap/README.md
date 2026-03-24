# project-bootstrap

一個指令建出生產就緒的完整專案骨架。自動偵測技術棧，生成 Clean Architecture 目錄結構、多階段 Dockerfile、GitHub Actions CI/CD、linting 配置、pre-commit hooks（含 secret 掃描）、`.env.example`、health check endpoint 和測試基礎設施。

## 生成的檔案

| 檔案 | 功能 |
|------|------|
| `src/` | Clean Architecture 分層（api / services / models / config） |
| `tests/` | Unit + integration + e2e 測試目錄骨架 |
| `Dockerfile` | 多階段建置，非 root 使用者，含 HEALTHCHECK |
| `docker-compose.yml` | 本地開發環境（app + 資料庫） |
| `.github/workflows/ci.yml` | Lint + typecheck + test + Docker build |
| `.env.example` | 所有必要環境變數都有說明 |
| `.pre-commit-config.yaml` | 含 `detect-private-key` + `gitleaks` 防止 secret 外洩 |
| `.gitignore` | 對應技術棧的忽略規則 |

## 支援的技術棧

| 語言 | 框架 |
|------|------|
| TypeScript | Next.js、Express、Fastify |
| Python | FastAPI、Django、Flask |
| Go | Gin、Echo、標準 net/http |
| Java | Spring Boot |

## 安全預設值

- Docker 以非 root 使用者執行
- Docker image tag 鎖定版本（不用 `latest`）
- pre-commit `gitleaks` 阻止 secret 進入 git 歷史
- `.env` 不生成，只生成 `.env.example`（含說明）

## 觸發方式

- "bootstrap project"、"scaffold project"、"建立新專案"
- "new [framework] project"、"initialize codebase"、"初始化專案"

## 與其他 skill 的差異

| 需求 | 使用 Skill |
|------|-----------|
| 從零建立新專案 | `project-bootstrap`（本 skill） |
| 遷移現有專案結構 | `migration-architect` |
| 為現有專案加 CI/CD | `ci-cd-pipeline-builder` |
| 為現有專案容器化 | `docker-patterns` |
