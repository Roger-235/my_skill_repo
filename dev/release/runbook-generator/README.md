# runbook-generator

## 用途

為服務和基礎設施建立完整的操作 Runbook——標準作業程序、部署步驟、擴縮容操作、事故應對程序與例行維護任務，包含決策樹與回滾說明。

## 觸發方式

當使用者需要記錄如何操作某個服務、需要部署或維護程序的 Runbook、正在準備值班文件，或請求例行工程任務的標準作業程序（SOP）時觸發。

關鍵字：`runbook`、`operational guide`、`sop`、`standard operating procedure`、`ops documentation`、`on-call runbook`、`deployment runbook`

## 使用步驟

1. **識別 Runbook 類型** — 部署、事故應對、維護、擴縮容或還原 Runbook。
2. **定義受眾** — 不熟悉該服務的值班工程師；以對應的層次撰寫。
3. **使用標準章節結構** — 依輸出格式中的順序組織 Runbook。
4. **將指令撰寫為可直接複製貼上的區塊** — 包含每個旗標；不省略。附上預期輸出說明。
5. **為分岐情境新增決策樹** — 「如果 X，前往步驟 N；如果 Y，升級給 @team」。
6. **為每個破壞性或可逆操作加入回滾步驟**。
7. **加入驗證步驟** — 每個重要操作後，明確說明如何確認操作成功。
8. **列出升級聯絡人** — 值班輪換、Slack 頻道、主題專家名稱。
9. **加入修訂歷程** — 底部的日期、作者與變更摘要。

## 規則

### 必須

- 每個指令必須撰寫為完整、可直接複製貼上的區塊——使用明確的 `<placeholder>` 標記填寫欄位。
- 每個修改系統狀態的操作後必須包含驗證步驟。
- 每個破壞性或難以逆轉的操作必須包含回滾步驟。
- 長時間執行的步驟需說明預期持續時間。
- Runbook 必須自成一體——不能僅依賴其他文件的連結。
- 每次事故使用 Runbook 後必須進行審查和更新。

### 禁止

- 禁止撰寫假設讀者已有服務先備知識的 Runbook。
- 禁止省略升級聯絡人。
- 禁止使用模糊的說明，如「重啟服務」，而不指定確切的指令與服務識別符。
- 禁止在未於非生產環境驗證的情況下留下未測試的 Runbook 步驟。
- 禁止在 Runbook 中直接儲存憑證或密鑰——改以參考密鑰管理器路徑。

## 範例

### 正確用法

```markdown
# Runbook：payments-api 部署

## 概覽
- **服務**：payments-api — 處理結帳交易
- **負責人**：#team-payments | 值班：PagerDuty「Payments On-Call」輪換
- **SLO**：POST /v1/charge 成功率 99.9%；p99 < 300ms

## 步驟 1：驗證目前健康狀態
```bash
kubectl get pods -n payments -l app=payments-api
# 預期：所有 Pod 處於 Running 狀態，READY 1/1
```
**驗證**：所有 Pod 顯示 `Running` 且 `READY 1/1`。
**回滾**：`kubectl rollout undo deployment/payments-api -n payments`
```

### 錯誤用法

```markdown
# 支付服務部署
1. 部署新版本到 k8s。
   （無指令、無命名空間、無映像參考）
2. 確認運作正常。
   （無驗證步驟、無指標可查）
3. 若出錯則回滾。
   （無回滾指令、無升級路徑）
```
