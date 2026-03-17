# changelog-generator

## 用途

從 git 提交記錄或 PR 元資料產生結構化的 CHANGELOG.md，遵循 Keep a Changelog 格式，並依類型分組呈現版本條目。

## 觸發方式

當使用者請求產生或更新 CHANGELOG.md、需要發布說明、想要彙整兩個版本之間的變更，或正在準備發布並需要面向使用者的變更文件時觸發。

關鍵字：`changelog`、`release notes`、`what changed`、`conventional commits`、`keep a changelog`、`git log release`、`version history`

## 使用步驟

1. **確定範圍** — 識別基準 ref（前一個標籤或提交）與目標 ref（目前標籤、`HEAD` 或目標版本號）。
2. **收集提交** — 擷取範圍內的提交，包含類型、範圍與主旨。
3. **依類型分類**：
   - `feat` → **新增（Added）**
   - `fix` → **修復（Fixed）**
   - `perf`、`refactor` → **變更（Changed）**
   - `BREAKING CHANGE` / `!` 後綴 → **重大變更（Breaking Changes）**（置於區段最上方）
   - `deprecated` → **棄用（Deprecated）**
   - `removed` → **移除（Removed）**
   - `security` → **安全性（Security）**
4. **去重並分組** — 合併相關提交（例如同一問題的多個修復提交）。
5. **為使用者受眾改寫** — 將技術性提交訊息轉換為使用者友善的語言；移除內部參考或工單號碼（除非專案慣例包含它們）。
6. **套用 Keep a Changelog 格式** — 含 ISO 日期的版本標頭、分組區段、最上方的未發布區段。
7. **前置插入至現有 CHANGELOG.md** — 新版本區段置於 `## [Unreleased]` 之下、前一版本之上。
8. **更新 Unreleased 區段** — 新增發布區段後清空該區段。

## 規則

### 必須

- **重大變更**一律作為版本條目的第一個區段。
- 版本標頭使用 ISO 8601 日期格式（`YYYY-MM-DD`）。
- 在檔案底部為每個版本加入比較連結。
- 檔案最上方始終保留 `[Unreleased]` 區段。
- 以過去式的使用者語言撰寫 changelog 條目（「新增深色模式支援」，而非 `feat: add dark mode`）。
- 重大變更條目必須顯著標示，它們直接影響使用者。

### 禁止

- 禁止從 changelog 中省略與安全性相關的變更。
- 禁止以原始提交雜湊或僅有工單號碼作為唯一說明。
- 禁止刪除 `[Unreleased]` 區段——每次發布後將其重設為空白。
- 禁止在面向使用者的 changelog 中包含 `chore`、`test` 或 `ci` 提交（除非影響使用者體驗）。
- 禁止改變版本順序——最新版本始終在最上方。

## 範例

### 正確用法

```markdown
## [2.1.0] - 2026-03-17
### 重大變更
- 從用戶端建構函式中移除 `legacyAuth` 選項；請改用 `authProvider`。

### 新增
- 儀表板深色模式支援（可透過 `theme` prop 設定）。
- 批次匯出為 CSV 現在支援最多 100,000 筆資料。

### 修復
- 套用篩選條件時，分頁不再重設至第 1 頁。

### 安全性
- 更新 `jose` 至 5.2.1 以修復 CVE-2026-1234。

[2.1.0]: https://github.com/org/repo/compare/v2.0.3...v2.1.0
```

### 錯誤用法

```markdown
## v2.1.0
- feat: add dark mode (#432)       ← 原始提交訊息，非使用者友善
- fix things                        ← 過於模糊
- chore: update eslint config       ← 內部變更，非面向使用者
- BREAKING: removed legacyAuth      ← 應置於獨立的重大變更區段
- 2026/03/17                        ← 錯誤的日期格式，應為 2026-03-17
```
