# Orchestrating Swarms — Claude Code 多 Agent 協調指南

掌握 Claude Code 的 TeammateTool 和 Task 系統，實現平行專家協作、流水線任務、自組織蜂群等多 agent 模式。

## 功能

- 啟動 Agent 團隊（Leader + Teammates），透過 Inbox 收發訊息
- 建立帶依賴關係的 Task 清單，依賴完成後自動解鎖下一個任務
- 六種協調模式：平行審查、流水線、蜂群自組織、研究+實作、計畫審批、多檔協作重構
- 三種執行後端：in-process（最快）、tmux（可視）、iTerm2（macOS 分割視窗）

## 觸發時機

- 「協調多個 agent」、「平行程式審查」、「multi-agent 協作」
- 「swarm agents」、「TeammateTool」、「spawn subagent」
- 「pipeline with dependencies」、「divide-and-conquer」

**不觸發**：單一 agent 任務、不需要協調的簡單循序工作

## 使用方法

快速啟動（平行專家模式）：

```javascript
// 1. 建立團隊
Teammate({ operation: "spawnTeam", team_name: "code-review" })

// 2. 同時派出多個專家
Task({ team_name: "code-review", name: "security", subagent_type: "general-purpose",
  prompt: "審查安全漏洞，完成後傳送結果給 team-lead", run_in_background: true })

Task({ team_name: "code-review", name: "performance", subagent_type: "general-purpose",
  prompt: "審查效能問題，完成後傳送結果給 team-lead", run_in_background: true })

// 3. 查看結果
// cat ~/.claude/teams/code-review/inboxes/team-lead.json

// 4. 關閉並清理
Teammate({ operation: "requestShutdown", target_agent_id: "security" })
Teammate({ operation: "requestShutdown", target_agent_id: "performance" })
Teammate({ operation: "cleanup" })
```

完整模式範例：`ref/patterns.md`
完整流程範例：`ref/workflows.md`
全部 TeammateTool 操作：`ref/operations.md`

## 核心概念

- **Leader**：建立團隊的 agent，負責協調、接收結果
- **Teammate**：加入團隊的 agent，透過 inbox 溝通、從 Task 清單領取工作
- **Task 依賴**：`addBlockedBy` 設定依賴，前置任務完成後自動解鎖

## 安全性

- 每個 teammate 在獨立 context 執行，互不干擾
- Shutdown 前必須等待 `shutdown_approved` 確認，不可強制終止
- `broadcast` 成本高，優先使用 `write` 對特定 teammate 發訊息
