# database-schema-designer

## 用途

產出精確、可生產部署的資料庫 Schema DDL，包含 CREATE TABLE 語句、欄位類型、約束條件、索引，以及完整的 UP/DOWN 遷移腳本，支援 PostgreSQL、MySQL、SQLite 與 MongoDB。

## 觸發方式

當使用者要求：
- 為資料模型撰寫或生成 SQL DDL
- 建立資料表定義、約束條件或索引
- 撰寫資料庫遷移腳本或 Schema 變更
- 將資料模型描述轉換為 Schema 程式碼
- 觸發關鍵詞：「design schema」、「write DDL」、「create table」、「database schema」、「write migration」、「schema design」、「define tables」、「model this data」

## 使用步驟

1. 從描述中提取實體與屬性
2. 識別實體關係（一對一、一對多、多對多），規劃連結資料表
3. 選擇主鍵策略（UUID / BIGSERIAL / 複合鍵）
4. 精確定義欄位類型（語義匹配）
5. 新增約束條件（NOT NULL、UNIQUE、CHECK、DEFAULT、外鍵 ON DELETE 行為）
6. 設計索引（主鍵索引、唯一索引、查詢模式索引）
7. 撰寫 UP 與 DOWN 遷移腳本
8. 驗證 Schema（檢查常見問題）

## 規則

### 必須
- PostgreSQL 必須使用 TIMESTAMPTZ，不得使用 TIMESTAMP
- 每個實體資料表必須包含 created_at 和 updated_at
- 每個外鍵必須指定 ON DELETE 行為
- 每個外鍵欄位必須建立索引（PostgreSQL 不自動為 FK 建立索引）
- 每個 UP 遷移必須附帶 DOWN 遷移
- 可變長度字串使用 TEXT，有長度限制需求時才使用 VARCHAR(n)
- 金額使用整數（分/最小單位）並加 CHECK 約束

### 禁止
- 禁止在 Schema 中儲存明文密碼、Token 或 Secret
- 禁止使用 FLOAT 或 DOUBLE 儲存金融資料
- 禁止對邏輯上必填的欄位使用 NULL
- 禁止使用 SQL 保留字作為欄位名稱（不加引號）
- 禁止省略 DOWN 遷移腳本

## 範例

### 正確用法

```sql
-- 正確：金額用整數分儲存
price_cents     INTEGER     NOT NULL CHECK (price_cents >= 0),

-- 正確：外鍵指定 ON DELETE 行為 + 索引
order_id        UUID        NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
CREATE INDEX idx_line_items_order_id ON line_items(order_id);

-- 正確：軟刪除 + 部分索引
deleted_at      TIMESTAMPTZ,
CREATE INDEX idx_products_active ON products(id) WHERE deleted_at IS NULL;
```

### 錯誤用法

```sql
-- 錯誤：金額用 FLOAT（浮點精度問題）
price           FLOAT,

-- 錯誤：必填欄位可為 NULL
user_id         UUID REFERENCES users(id),

-- 錯誤：TIMESTAMP 無時區資訊
created_at      TIMESTAMP DEFAULT NOW(),
```
