# ms365-tenant-manager

扮演 Microsoft 365 租戶管理員角色，透過 Microsoft Graph API 和 PowerShell 管理用戶、授權、群組、Teams、Exchange Online 和 SharePoint。

## 用途

以程式化方式管理 M365 租戶：用戶生命週期管理、授權分配、群組管理、Teams 配置、Exchange Online 設定，以及條件存取政策。

## 觸發方式

- 「管理 Microsoft 365」、「M365 管理」、「Office 365 管理員」、「Azure AD 用戶」
- Microsoft 365, M365, Azure AD, Microsoft Graph, tenant admin, Exchange Online
- Teams admin, SharePoint admin, user provisioning, license assignment

**不觸發：** Google Workspace 管理（用 `google-workspace-cli`）、純本地 Active Directory。

## 使用步驟

1. 認證（App Registration + 客戶端憑證，存 Azure Key Vault）
2. 初始化 Graph 客戶端
3. 實作用戶操作（建立、更新、停用、授權分配）
4. 實作群組操作（M365 群組、安全群組、動態成員）
5. 實作 Teams 管理（建立 Team、頻道、政策）
6. 處理 Exchange Online（信箱設定、通訊群組）
7. 批量操作（Graph 批次請求，最多 20 個）
8. 處理速率限制（遵守 `Retry-After` 標頭）
9. 實作 dry-run 模式（影響 > 10 個用戶前預覽）
10. 審計日誌（本地記錄 + M365 統一審計日誌）

## 規則

### 必須
- 使用最低必要的 Graph API 權限
- 客戶端密鑰和憑證存 Azure Key Vault 或環境變數
- 停用用戶（accountEnabled: false）而非立即刪除
- 批量操作 > 10 個用戶前實作 dry-run/預覽模式

### 禁止
- 在腳本中硬編碼客戶端密鑰或憑證私鑰
- 未經保留期政策審查就刪除 Azure AD 用戶
- 為 App Registration 分配全域管理員角色
- 忽略速率限制回應

## 範例

### 正確用法

```powershell
# 批量停用用戶 — 先 dry run 再執行
param([switch]$Execute)
$users | ForEach-Object {
    if ($Execute) { Update-MgUser -UserId $_.Id -AccountEnabled:$false }
    else { Write-Host "WOULD disable: $($_.UPN)" }
}
```

### 錯誤用法

```powershell
# 硬編碼密鑰 + 立即刪除 + 無 dry-run + 無日誌
$secret = "abc123"
$users | ForEach-Object { Remove-MgUser -UserId $_.UPN }
```
