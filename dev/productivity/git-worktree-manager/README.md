# git-worktree-manager

## 用途

設定並管理 git worktree，讓工程師能同時在多個分支上工作，無需切換上下文或使用 stash。

## 觸發方式

當使用者想同時處理多個分支、需要在保持目前工作完整的同時審查 PR、詢問 git worktree，或需要管理現有的 worktree 設定時觸發。

關鍵字：`git worktree`、`parallel branches`、`multiple branches`、`worktree`、`linked worktree`、`git checkout parallel`

## 使用步驟

1. **說明模型** — worktree 是在不同目錄中的分支獨立簽出；所有 worktree 共用同一個 `.git` 物件儲存庫。
2. **建立 worktree** — `git worktree add <路徑> <分支>` 或 `git worktree add -b <新分支> <路徑> [起始點]`。
3. **列出現有 worktree** — `git worktree list` 顯示所有路徑、HEAD 與鎖定狀態。
4. **在 worktree 中工作** — `cd <路徑>` 後正常操作；提交會出現在共用的儲存庫中。
5. **鎖定 worktree**（選用）— `git worktree lock <路徑> --reason "說明"` 用於長期工作。
6. **移除 worktree** — 先提交或 stash 變更，再執行 `git worktree remove <路徑>`；僅在工作目錄乾淨時才使用 `--force`。
7. **清除失效條目** — `git worktree prune` 移除手動刪除目錄後留下的失效參考。
8. **裸儲存庫工作流程**（進階）— 使用 `git clone --bare` 並以 worktree 作為主要簽出機制。

## 規則

### 必須

- 建立 worktree 時顯示完整路徑，以避免分支之間的混淆。
- 在新增前確認分支尚未在其他 worktree 中簽出（git 會拒絕，但應清楚說明錯誤原因）。
- 手動刪除目錄後建議執行 `git worktree prune`。
- 使用裸儲存庫時，將目錄命名為 `<專案>.git` 或 `<專案>/` 以清楚辨識。

### 禁止

- 禁止在兩個 worktree 中同時簽出同一個分支——git 會拒絕此操作。
- 禁止在未執行 `git worktree prune` 的情況下以 `rm -rf` 刪除 worktree 目錄。
- 禁止在 worktree 有未提交變更時使用 `--force` 執行 `git worktree remove`。
- 禁止將 worktree 目錄放置在主工作樹內部（會造成巢狀 git 儲存庫的混亂）。

## 範例

### 正確用法

```bash
# 在保持功能分支完整的同時處理緊急修復
git worktree add ../myproject-hotfix hotfix/payment-fix

# 在新 worktree 中建立新分支
git worktree add -b feature/new-dashboard ../myproject-dashboard main

# 列出所有 worktree
git worktree list
# /home/user/myproject          abc1234 [main]
# /home/user/myproject-hotfix   def5678 [hotfix/payment-fix]

# 完成後移除
git worktree remove ../myproject-hotfix

# 裸儲存庫設定
git clone --bare https://github.com/org/repo repo.git
cd repo.git && git worktree add ../repo-main main
```

### 錯誤用法

```bash
# 嘗試簽出已存在的分支——git 會報錯
git worktree add ../copy-of-main main

# 未清除就刪除目錄
rm -rf ../myproject-hotfix  # 之後必須執行 git worktree prune

# 將 worktree 放在主樹內部——造成混亂
git worktree add ./branches/hotfix hotfix/fix
```
