# google-workspace-cli

透過 API 和 CLI 工具自動化 Google Workspace 管理與資料操作，涵蓋 Gmail、Drive、Calendar、Sheets、Docs 與 Admin SDK。

## 用途

以程式化方式管理 Google Workspace 資源：用戶配置、Drive 組織、Calendar 管理、Sheets 自動化和 Admin SDK 操作，具備適當的認證與配額管理。

## 觸發方式

- 「管理 Google Workspace」、「Google 工作區自動化」、「Google API 整合」
- Google Workspace, Gmail API, Google Drive, Google Calendar, Google Sheets
- Google Admin, service account, OAuth2 Google, manage Google users

**不觸發：** Microsoft 365 管理（用 `ms365-tenant-manager`）、純 SMTP 電子郵件。

## 使用步驟

1. 設置認證（服務帳號或 OAuth2，憑證存環境變數）
2. 初始化 API 客戶端（含指數退避重試）
3. 實作核心操作（Drive/Gmail/Calendar/Sheets/Admin SDK）
4. 處理分頁（循環直到無 `nextPageToken`）
5. 使用批次操作降低配額消耗
6. 套用配額與速率限制處理
7. 寫入前驗證權限
8. 實作 dry-run 模式（用於破壞性操作）
9. 記錄所有操作（含資源 ID，審計追蹤）

## 規則

### 必須
- 憑證存環境變數或 Google Secret Manager
- 所有 API 呼叫實作指數退避重試
- 處理 `nextPageToken` 分頁
- 批量破壞性操作實作 dry-run 確認

### 禁止
- 在原始碼中硬編碼服務帳號 JSON 憑證
- 不經 dry-run 確認就執行批量刪除或權限變更
- 記錄或印出 OAuth2 Token 或服務帳號金鑰

## 範例

### 正確用法

```python
# 從安全路徑載入憑證，含分頁處理
creds = service_account.Credentials.from_service_account_file('/run/secrets/sa.json', scopes=SCOPES)
service = build('drive', 'v3', credentials=creds)
while True:
    resp = service.files().list(pageToken=page_token).execute()
    files.extend(resp.get('files', []))
    if not resp.get('nextPageToken'): break
```

### 錯誤用法

```python
# 憑證硬編碼 + 無分頁 = 資安風險 + 遺失資料
creds_json = '{"private_key":"-----BEGIN RSA..."}'
files = service.files().list().execute()['files']  # 只取第一頁
```
