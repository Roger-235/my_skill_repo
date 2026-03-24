# standup-notes

從 git 歷史自動生成每日站會報告。讀取過去 24 小時的 commit、當前分支狀態和 open PR，產出 Yesterday / Today / Blockers 三段式 Slack-ready markdown。

## 使用場景

每天早上站會前 30 秒內產出報告，不用靠記憶回想昨天做了什麼。

## 觸發方式

- "standup"、"站會"、"每日報告"、"generate standup"
- "what did I do yesterday"、"寫站會"

## 輸出格式

```
*Standup — 2026-03-23 — 開發者名稱*

*Yesterday*
• [TICKET-123] 完成 OAuth token 更新 — 已合併
• [TICKET-124] 修復 /api/orders N+1 查詢 — PR 等待審查

*Today*
• [TICKET-125] 開始 payment webhook handler
• 清理 review queue（2 個 PR 待處理）

*Blockers*
• PR #142 等 @alice review 已超過 2 天
```

## 資料來源

| 資料 | 指令 |
|------|------|
| 昨日 commits | `git log --since="24 hours ago" --author="$(git config user.name)"` |
| 當前工作 | `git branch --show-current` + `git status --short` |
| 未解決 TODO | `git diff HEAD~5..HEAD \| grep "TODO\|FIXME\|BLOCKED"` |
| Open PR 狀態 | `gh pr list --author @me --state open` |

## 規則

- 每個 bullet 必須包含 ticket ID（若有）
- 涵蓋最後一個工作日（週一站會涵蓋週五）
- 總輸出不超過 10 行
- 等待超過 1 個工作日的外部 review PR 自動標為 blocker
