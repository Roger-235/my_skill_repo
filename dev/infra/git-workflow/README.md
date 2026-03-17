# Git Workflow — Git 工作流程規範

定義並執行一致的 Git 工作流程，包含分支命名、Conventional Commits 提交訊息格式、原子提交、PR 結構與合併策略。

## 功能

- 定義分支命名規範：`<type>/<issue-number>-<short-description>`
- 套用 Conventional Commits 格式：`<type>(<scope>): <description>`
- 確保每個 commit 只包含一個邏輯變更（原子提交）
- 提供標準 PR 模板：包含說明、測試計劃、截圖
- 建議合併策略：feature 分支使用 squash merge，release 分支使用 merge commit
- 說明主分支保護設定（要求 review、CI 通過、禁止直接推送）

## 觸發時機

**手動觸發**：
- 「git workflow」、「branching strategy」、「commit conventions」、「conventional commits」
- 「PR template」、「git best practices」、「how to write commit messages」
- 「分支策略」、「commit 規範」、「PR 格式」、「git 流程」

**不觸發**：
- 解決 merge conflict → 改用 debug
- 審查 PR 中的程式碼 → 改用 code-review

## 使用方法

告訴 Claude 你的專案名稱或具體需求，skill 會輸出完整的工作流程規範：

**輸出格式範例**：

```
## Git Workflow: <專案名稱>

### Branch Naming
Pattern: <type>/<issue>-<short-description>
Types: feat | fix | chore | docs | refactor | test
Example: feat/42-user-authentication

### Commit Format
<type>(<scope>): <short description>

[optional body: explain WHY this change was made]

[optional footer: Closes #42]

### PR Template
**Title:** <conventional commit format>
**Description:** <what changed and why>
**Test plan:** <how to verify the change>
**Screenshots:** <if UI change>

### Merge Strategy
Feature branches → Squash merge (clean linear history)
Release branches → Merge commit (preserve release context)
```

常見的 type 類型說明：
- `feat` — 新功能
- `fix` — 錯誤修復
- `chore` — 維護性工作（更新依賴、設定等）
- `docs` — 文件變更
- `refactor` — 重構（不改變行為）
- `test` — 新增或修改測試

## 前置需求

- Git 儲存庫必須已存在（`git init` 或已 clone）
- 主分支名稱必須已知（main 或 master）

## 安全性

- 禁止直接推送到 main/master，所有變更必須經由 PR
- 禁止在共用分支上使用 `git push --force`（必要時僅允許使用 `--force-with-lease`）
- 禁止將格式調整與邏輯變更混入同一個 commit，以確保 `git bisect` 可靠運作
- 禁止使用無意義的提交訊息（「fix stuff」、「update」、「WIP」等）
