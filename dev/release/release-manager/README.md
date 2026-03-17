# release-manager

## 用途

協調完整的軟體發布流程——版本號提升、changelog 更新、標籤建立、CI/CD 管線驗證、產出物發布，以及發布後驗證，遵循語意化版本控制與發布分支策略。

## 觸發方式

當使用者想要切出一個發布版本、需要發布函式庫或應用程式的新版本、詢問語意化版本決策、需要管理發布分支，或想要發布檢查清單時觸發。

關鍵字：`release`、`cut a release`、`ship`、`publish`、`semantic versioning`、`version bump`、`release branch`、`tag release`

## 使用步驟

1. **確定版本號提升** — 使用語意化版本控制（SemVer）：
   - **MAJOR**（`x.0.0`）：含有重大變更
   - **MINOR**（`1.x.0`）：向後相容的新功能
   - **PATCH**（`1.2.x`）：僅有向後相容的錯誤修復
   - **預發布**：`1.3.0-alpha.1`、`1.3.0-rc.1` 用於階段性發布
2. **建立或切換至發布分支**（如果使用發布分支策略）：`git checkout -b release/v1.3.0 main`
3. **提升套件清單版本號** — `package.json`、`pyproject.toml`、`Cargo.toml`、`pom.xml` 等。
4. **更新 CHANGELOG.md** — 將 `[Unreleased]` 內容移至含今日日期的新版本區段。
5. **提交版本提升與 changelog** — `git commit -m "chore: release v1.3.0"`
6. **建立附注標籤** — `git tag -a v1.3.0 -m "Release v1.3.0"` 並推送。
7. **驗證發布提交上的 CI** — 確認所有檢查在發布前通過。
8. **發布產出物** — 觸發或確認發布管線（npm publish、twine upload、Docker push、GitHub Release）。
9. **合併回主分支**（如果使用發布分支）。
10. **發布後驗證** — 在乾淨環境中安裝/拉取已發布的產出物並執行煙霧測試。
11. **公告** — 將發布說明張貼至 Slack/Discord/電子郵件，更新文件網站。

## 規則

### 必須

- 嚴格遵循 SemVer——重大變更一律需要提升 MAJOR 版本。
- 為所有發布建立附注標籤（非輕量標籤）——它們包含元資料。
- 在確切的發布提交上驗證 CI，而非僅在主分支上驗證。
- 從乾淨的簽出進行發布，而非開發者帶有未提交變更的本機環境。
- 切出發布後立即在 CHANGELOG.md 中為下一個發布週期啟用 `[Unreleased]` 區段。

### 禁止

- 禁止強制推送已發布至套件登錄庫的標籤。
- 禁止從有未提交變更或骯髒工作樹的分支進行發布。
- 禁止跳過已發布套件的發布後煙霧測試。
- 禁止直接在 `main` 上提升版本號而不包含 changelog 的發布提交。
- 禁止在未明確意圖的情況下在生產部署中使用預發布版本。

## 範例

### 正確用法

```bash
# Node.js 函式庫的完整發布流程
git checkout main && git pull
git checkout -b release/v2.1.0

npm version minor --no-git-tag-version
# 更新 CHANGELOG.md

git add package.json package-lock.json CHANGELOG.md
git commit -m "chore: release v2.1.0"
git tag -a v2.1.0 -m "Release v2.1.0 — 深色模式、CSV 匯出、WebSocket 修復"
git push origin release/v2.1.0 v2.1.0

# CI 通過後
npm publish --access public

# 合併回主分支
git checkout main
git merge release/v2.1.0 --no-ff -m "chore: merge release/v2.1.0 into main"
```

### 錯誤用法

```bash
# 從骯髒的工作樹發布
git status  # 顯示有修改的檔案——應中止操作

# 輕量標籤——無元資料
git tag v2.1.0  # 應使用 -a 旗標與訊息

# 強制推送已發布的標籤
git tag -f v2.1.0 HEAD && git push --force origin v2.1.0
# 破壞已解析舊標籤的套件管理器

# 跳過發布後驗證
npm publish && echo "完成"  # 在乾淨環境中沒有煙霧測試
```
