# ci-cd-pipeline-builder

## 用途

設計並生成適合專案語言、框架與目標部署平台的生產就緒 CI/CD 流水線配置，支援 GitHub Actions、GitLab CI、CircleCI 與 Jenkins。

## 觸發方式

當使用者要求建立或改善 CI/CD 流水線、自動化建構/測試/部署，或生成工作流程配置檔案時觸發。

## 使用步驟

1. 偵測專案語言、框架與現有 CI 配置
2. 確認 CI 平台、目標環境與部署目標
3. 設計流水線階段（lint → test → build → security-scan → deploy）
4. 生成完整的流水線配置檔案，包含快取、平行執行與 Secret 引用
5. 加入失敗通知步驟
6. 列出需要在 CI 平台設定的 Secret 與手動配置步驟

## 規則

### 必須
- 使用平台原生的 Secret 注入機制，絕不硬編碼憑證
- 部署階段前必須有測試階段
- 使用快取依賴目錄以縮短建構時間
- 使用固定版本的 Action（例如 `actions/checkout@v4`）
- lint、test、build 分離為獨立的 job/stage

### 禁止
- 硬編碼 API 金鑰、令牌或密碼
- 生產部署流水線跳過安全掃描
- 生成沒有手動核准關卡或分支限制的生產部署 stage
- Docker 基礎映像使用 `latest` 標籤

## 範例

### 正確用法

使用者：「為我的 Node.js 應用建立 GitHub Actions CI，部署到 AWS ECS。」

生成包含 lint、test、build-and-push（Docker 映像推送至 ECR）、deploy 等獨立 job 的 `.github/workflows/ci.yml`；Secret 以 `${{ secrets.AWS_ACCESS_KEY_ID }}` 引用；deploy job 限定於 `main` 分支；npm 依賴快取；固定版本的 Action。

### 錯誤用法

生成單一 `script:` 區塊執行 `npm install && npm test && scp dist/ user:password@server:/var/www`——硬編碼憑證、無快取、無獨立階段。
