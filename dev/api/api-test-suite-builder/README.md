# api-test-suite-builder

## 用途

為 API 端點產出涵蓋 Happy Path、驗證錯誤、認證/授權、邊界條件與安全性測試的完整可執行測試套件，支援主流測試框架（Jest/Supertest、pytest/httpx、Go testing 等）。

## 觸發方式

當使用者要求：
- 為 API 建立、生成或撰寫測試
- 為 API 端點或服務建立整合測試或契約測試
- 改善 API 測試覆蓋率
- 觸發關鍵詞：「build API tests」、「generate API test suite」、「write API tests」、「test this API」、「create integration tests for API」

## 使用步驟

1. 解析 API（端點、方法、請求/回應 Schema）
2. 確認測試框架（依專案語言偵測或確認）
3. 為每個端點規劃測試類別（Happy Path、驗證錯誤、認證、邊界條件、安全性）
4. 生成 Happy Path 測試（有效輸入、成功回應、Schema 斷言）
5. 生成驗證錯誤測試（缺少必填欄位、無效類型、邊界值）
6. 生成認證測試（無 Token、過期 Token、權限不足、錯誤租戶）
7. 生成邊界條件測試（空集合、大型 Payload、特殊字元、冪等性）
8. 生成安全性測試（SQL Injection、XSS、路徑遍歷、IDOR、Mass Assignment）
9. 輸出附有測試計畫摘要的可執行測試程式碼

## 規則

### 必須
- 每個受保護端點必須包含認證測試（無 Token、過期 Token、錯誤權限範圍）
- 必須斷言回應 Schema 結構，而非僅檢查狀態碼
- 每個接受使用者輸入的端點至少包含一個安全性測試
- 測試名稱必須具描述性
- 必須斷言敏感欄位（密碼、Secret、Token）不出現在回應中

### 禁止
- 禁止在測試檔案中使用真實憑證或正式環境 URL
- 禁止撰寫依賴執行順序的測試
- 禁止以「內部端點」為由跳過認證測試
- 禁止僅斷言狀態碼而不斷言回應主體結構
- 禁止生成修改共享狀態但未清理的測試

## 範例

### 正確用法

```
使用者：為 GET /api/v1/users/:id（JWT 認證，回傳使用者物件）撰寫測試。
→ 輸出測試計畫摘要 + 可執行測試程式碼，涵蓋：有效 ID + 有效 Token（Happy）、無效 UUID（驗證）、無 Token/過期 Token/低權限（認證）、已刪除 ID（邊界）、IDOR 攻擊/路徑遍歷（安全性）。
```

### 錯誤用法

```
使用者：為 GET /api/v1/users/:id 撰寫測試。
回應：
it('gets user', async () => {
  const res = await request(app).get('/api/v1/users/1');
  expect(res.status).toBe(200);
});
→ 錯誤原因：僅一個測試、無認證測試、無驗證測試、無安全性測試、無 Schema 斷言、使用硬編碼 ID、未傳送 Token、測試名稱不具描述性。
```
