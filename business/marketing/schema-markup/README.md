# schema-markup

## 用途

為網頁生成並驗證 Schema.org JSON-LD 結構化資料標記，以爭取 Google 豐富摘要（Rich Results）、知識面板及強化版搜尋結果，提升點擊率。

## 觸發方式

當使用者需要為網頁新增結構化資料、排查豐富摘要資格問題、實作特定 schema 類型（FAQ、Product、Review、HowTo、Article、LocalBusiness 等），或稽核現有 schema 錯誤時觸發。

## 使用步驟

1. 根據頁面內容和搜尋目標，從 schema.org 識別正確的 schema 類型。
2. 將頁面內容對應至 schema 屬性——先填必要欄位，再填建議欄位。
3. 生成包含所有適用屬性的 JSON-LD 程式碼區塊。
4. 在適當位置加入巢狀類型（如 Author 內的 Organization、Product 內的 AggregateRating）。
5. 使用 Google 豐富摘要測試工具和 Schema.org 驗證器驗證標記。
6. 說明放置位置：在 `<head>` 或 `<body>` 末端的 `<script type="application/ld+json">` 標籤內。
7. 標記需動態填入的資料（如價格、庫存狀態、評論數量）。
8. 提供各 CMS 的具體實作說明（WordPress、Shopify、Webflow、自訂程式碼）。

## 規則

### 必須

- 預設使用 JSON-LD 格式（Google 的首選格式）
- 包含所選 schema 類型的所有必要屬性
- 確保 schema 資料與頁面可見內容完全一致
- 將輸出包裝在 `<script type="application/ld+json">` 標籤內

### 禁止

- 為頁面上不可見的內容新增 schema 資料（違反 Google 指南）
- 使用已棄用的 schema 類型或屬性
- 除非使用者的 CMS 無法支援 JSON-LD，否則不建議使用 Microdata
- 自行填寫資料數值——應使用佔位符說明，如「請替換為實際價格」

## 範例

### 正確用法

為 FAQPage 生成完整的 JSON-LD，包含 `@context`、`@type`、`mainEntity` 以及完整的 Question 和 Answer 巢狀結構，所有欄位均對應頁面上實際可見的問答內容。

### 錯誤用法

在一篇不含任何產品資訊的文章頁面上，加入帶有五星評價和低價格的 Product schema。
