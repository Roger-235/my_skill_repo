# pr-description-writer

從 `git diff` 和 commit 歷史自動生成完整的 Pull Request 描述。輸出包含 Summary（為什麼）、Changes（改了什麼）、Testing 指引、Breaking Changes 和 Related Issues。

## 與 pr-review-expert 的差異

| | pr-description-writer | pr-review-expert |
|--|----------------------|-----------------|
| **時機** | 開 PR 前，寫描述 | PR 已開，審查內容 |
| **輸入** | `git diff main..HEAD` | 現有 PR 程式碼 |
| **輸出** | PR 描述文字 | 審查意見與建議 |

## 觸發方式

- "write PR description"、"generate PR body"、"寫 PR 描述"
- "open PR"、"PR 說明"

## 輸出結構

```
## Summary      ← 為什麼要做這個變更（1–3句）
## Changes      ← 改了什麼，逐項說明
## Type of Change  ← feat / fix / refactor / breaking / ...
## Testing      ← 如何驗證正確性
## Breaking Changes  ← 若有 API/DB/env 破壞性變更
## Screenshots  ← UI 變更時附上截圖
## Related Issues   ← Closes #xxx
```

## 自動偵測 checklist 項目

| diff 中出現 | 自動加入 |
|------------|--------|
| auth / permission 相關 | `- [ ] Security review completed` |
| 資料庫 migration | `- [ ] Migration tested on staging` |
| `.env` 變數 | `- [ ] .env.example updated` |
| public API 變更 | `- [ ] API docs updated` |
| 新增相依套件 | `- [ ] Dependency audit run` |
