# Folder Classification — Category Taxonomy & Decision Tree

Every skill belongs to exactly one category. The category determines the parent folder under `.claude/skill/`.

## Category Definitions

| Category | 定義 | 典型 skill 例子 |
|----------|------|----------------|
| `dev` | 程式開發：程式碼審查、重構、測試、除錯 | code-review, webapp-testing |
| `design` | UI/UX 設計：前端樣式、設計系統、無障礙性 | frontend-style |
| `writing` | 文字創作：文章潤色、文件撰寫、翻譯 | article-edit |
| `ops` | 系統操作：版本控制、CI/CD、部署、基礎設施 | commit-writer |
| `data` | 資料處理：資料庫查詢、分析、爬蟲、格式轉換 | — |
| `security` | 資安：弱點掃描、滲透測試、稽核 | — |
| `meta` | Skill 管理：生成、維護、稽核 skill 本身 | skill-maker |
| `business` | 商業策略：C-suite 顧問、行銷、產品、法規合規 | ceo-advisor, cmo-advisor |

## Decision Flow

1. 如果 skill 的主要動作是「寫/改/審查程式碼」→ `dev`
2. 如果主要動作是「設計或實作 UI 介面」→ `design`
3. 如果主要動作是「編輯或產生自然語言文字」→ `writing`
4. 如果主要動作是「操作系統、版本控制、基礎設施」→ `ops`
5. 如果主要動作是「處理、分析、轉換資料」→ `data`
6. 如果主要動作是「發現或防禦安全漏洞」→ `security`
7. 如果主要動作是「管理 skill 本身」→ `meta`
8. 如果主要動作是「商業策略、顧問、行銷、法規」→ `business`
9. 如果橫跨多個類別，選「主要目的」最貼近的那個
