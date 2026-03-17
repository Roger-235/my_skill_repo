# api-design-reviewer

## 用途

審查 REST、GraphQL 或 RPC API 設計的一致性、命名規範、安全性、版本控制、錯誤處理與開發者體驗，產出嚴重性分級的問題清單與修復建議。

## 觸發方式

當使用者要求：
- 審查、審計或評估 API 設計、規格或 Schema
- 檢查 OpenAPI/Swagger 規格、GraphQL SDL 或 gRPC proto 檔案
- 改善 API 的可用性、一致性或安全性
- 觸發關鍵詞：「review API design」、「audit API」、「check API spec」、「evaluate REST API」、「review OpenAPI spec」、「review GraphQL schema」

## 使用步驟

1. 識別 API 類型與涵蓋範圍
2. 檢查命名規範（資源名稱、路徑、欄位、列舉值）
3. 檢查 HTTP 語義（REST：方法使用、狀態碼、冪等性）
4. 檢查版本控制策略
5. 檢查請求/回應設計（結構一致性、分頁模式、欄位命名）
6. 檢查錯誤回應完整性
7. 檢查安全性（敏感資料暴露、授權範圍、限流標頭）
8. 檢查開發者體驗（可發現性、文件完整性、向後相容性）
9. 輸出嚴重性分級的結構化審查報告

## 規則

### 必須
- 必須檢查回應與 URL 中的敏感資料暴露，評為 Critical/High
- 必須驗證 REST API 的 HTTP 方法語義
- 必須檢查錯誤回應完整性
- 每個問題必須有嚴重性、分類、位置與描述
- High 及以上嚴重性問題必須附修復建議（前後對比）
- 必須包含「設計優點」章節

### 禁止
- 禁止在修復建議中包含密碼、Token 或 Secret 的範例值
- 禁止將命名不一致評為 High 或 Critical
- 禁止省略最終判決
- 禁止建議破壞性變更而不標記為破壞性
- 禁止對 GraphQL 和 REST 套用完全相同的檢查項目

## 範例

### 正確用法

```
使用者：審查這個 REST API：POST /createUser, GET /getUser/:id, DELETE /removeUser/:id
→ 輸出結構化審查報告：識別動詞路徑問題（High）、無版本控制（Medium）、命名不一致（Low），附修復建議，判決為「需要修改」。
```

### 錯誤用法

```
使用者：審查這個 REST API：POST /createUser, GET /getUser/:id
回應：API 看起來還好，但可能需要更 RESTful 的命名並加入版本控制。對小型專案來說還可以。
→ 錯誤原因：無結構化問題清單、無嚴重性評級、無具體修復建議、無安全性檢查、判決模糊。
```
