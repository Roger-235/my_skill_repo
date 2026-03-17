# CI/CD Pipeline — CI/CD 流水線設計與設定

設計並設定完整的 CI/CD pipeline，涵蓋所有階段從程式碼檢查到正式環境部署，支援 GitHub Actions、GitLab CI 等主流系統。

## 功能

- 識別專案技術棧（語言、建構工具、測試框架、部署目標）
- 設計 pipeline 階段：lint → test → build → security scan → deploy-staging → deploy-prod
- 產生對應 CI 系統的 YAML 設定檔
- 設定套件快取以縮短建構時間
- 確保所有機密使用 CI secret store，不硬編碼
- 定義部署條件（staging 自動部署，production 需手動核准或版本 tag）

## 觸發時機

- 「設定 CI/CD」、「建立 pipeline」、「自動化部署流程」
- "set up CI", "GitHub Actions", "CI/CD pipeline", "build pipeline"

**不觸發**：執行正式環境部署時，使用 `deploy-ops`。

## 使用方法

提供專案技術棧與部署目標後，skill 會產生完整的 pipeline 設定檔與所需 secret 清單。

**輸出包含：**
- pipeline YAML 設定檔（.github/workflows/ci.yml 或等效路徑）
- Pipeline 階段說明
- 需在 CI secret store 設定的環境變數清單

## 前置需求

- 已知專案語言、建構工具、測試框架
- 已知部署目標（雲端平台、容器 registry 等）
- 有權限設定 CI secret store

## 安全性

- 所有憑證必須透過 CI secret store 注入，嚴禁硬編碼在設定檔中
- Production 部署必須先通過 staging 驗證，並設定手動核准關卡
