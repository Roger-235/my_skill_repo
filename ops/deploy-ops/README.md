# Deploy Ops — 正式環境部署操作指南

以結構化部署前清單、分步驟執行、健康檢查與回滾程序，確保每次正式環境部署安全、可記錄、可還原。

## 功能

- 執行部署前清單（CI 測試、staging 驗證、DB migration 測試、回滾計畫）
- 公告部署視窗，通知相關人員
- 執行平台特定部署指令
- 立即進行健康檢查（HTTP 狀態碼、DB 連線、關鍵 endpoint 延遲）
- 部署後 15 分鐘監控（錯誤率、p99 延遲、CPU/記憶體）
- 記錄每次部署（版本、時間戳記、部署者、結果）
- 偵測異常時立即觸發回滾並驗證還原成功

## 觸發時機

- 「正式環境部署」、「上線流程」、「回滾」、「部署清單」
- "deploy to production", "production release", "rollback", "deployment checklist"

**不觸發**：設定 CI/CD pipeline 時，使用 `ci-cd-pipeline`。

## 使用方法

提供版本號與部署目標後，skill 會帶領完成完整的部署流程並輸出結構化記錄。

**輸出格式：**
```
## Deployment: <版本>

### Pre-Deploy Checklist
### Deployment Steps
### Health Check Results
### Monitoring Summary (15 min)
### Post-Deploy Notes
```

## 前置需求

- 該版本所有 CI 測試必須通過
- 已在 staging 成功部署並驗證
- 回滾計畫已記錄
- 部署者具備正式環境部署權限

## 安全性

- 正式環境部署前必須先通過 staging，禁止跳過
- 禁止在尖峰流量期間部署，除非獲得書面核准
- 每次部署必須留有完整記錄，便於事後審計
