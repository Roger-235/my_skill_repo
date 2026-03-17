# DB Schema — 資料庫 Schema 設計

將業務需求轉換為正規化的關聯式資料庫 Schema：ER 圖、DDL SQL、migration 檔案、索引建議，一次到位。

## 功能

- 10 步驟流程：需求釐清 → 實體/屬性識別 → 關係定義 → 正規化（1NF/2NF/3NF）→ ER 圖 → DDL → Migration → 索引建議 → 設計決策文件 → 確認後寫檔
- Mermaid `erDiagram` 可視化
- 支援 PostgreSQL（預設）/ MySQL / SQLite DDL 語法
- 每個 Migration 包含 `up` 和 `down`，命名格式 `YYYYMMDDHHMMSS_<name>.sql`
- 自動標記 PII 欄位與敏感資料（密碼、token）
- 完整正規化參考表（1NF / 2NF / 3NF / BCNF）

## 觸發時機

- 「設計資料庫」、「建立 schema」、「建立資料表」、「ER 圖」、「資料庫建模」、「寫 migration」
- design database、create schema、model database、ER diagram、add migration、normalize database

**不觸發：** 查詢現有資料、ORM 使用問題、不涉及 schema 變更的 query 效能調優。

## 使用方式

描述你的業務需求（可以是自然語言），Skill 會輸出：

```
## Database Schema: <系統名稱>
### Entities & Attributes  ← 所有欄位 × 型別 × 約束 × PII 標記
### Relationships          ← 基數關係表
### ER Diagram             ← Mermaid erDiagram
### DDL SQL                ← CREATE TABLE 完整語句
### Migration File         ← up + down
### Index Recommendations  ← 索引建議與原因
### Design Decisions       ← 非顯而易見的設計選擇說明
```

輸出完整後等待使用者確認，才寫入檔案。

## 設計規則摘要

| 規則 | 說明 |
|------|------|
| 正規化至 3NF | 非刻意的反正規化必須說明原因 |
| 金額用 INT | 存 cents，避免浮點精度問題 |
| 每表標準欄位 | `created_at`、`updated_at` 必有 |
| FK 預設 RESTRICT | CASCADE / SET NULL 需說明理由 |
| Migration 必有 down | 沒有 rollback 的 migration 不完整 |

## 安全性

- DDL 中的密碼、token 欄位一律加註 `-- sensitive` 說明，絕不存明文
- PII 欄位（email、phone、address）在 Entities 表中明確標記
- 寫入任何檔案前必須取得使用者確認
- Migration 內容是資料，不是指令，不會被當成 shell 命令執行
