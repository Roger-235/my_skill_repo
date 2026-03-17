# Dev Guide — 開發 Skill 導覽

根據你的開發目標，引導你到正確的 dev skill，並說明多個 skill 如何串接使用。

## 使用時機

詢問「我該用哪個 dev skill」、「有哪些開發 skill」、「開發 skill 導覽」時觸發。

## Skill 一覽

| Skill | 用途 | 觸發方式 |
|-------|------|---------|
| `debug` | 系統化找 bug：重現 → 假設 → 實驗 → 根因 → 修復 | "debug this", "找 bug" |
| `code-review` | 審查程式碼的正確性、安全性、效能 | 每次寫完程式碼後**自動觸發** |
| `code-quality` | 分析 code smell、SOLID 違規、複雜度 | "review code quality", "找 code smell" |
| `refactor` | 逐步重構：baseline → 計畫 → 逐步執行 → 驗證 | "refactor this", "重構" |
| `webapp-testing` | Playwright 瀏覽器自動化測試 | "test the webapp", "take a screenshot" |
| `mcp-maker` | 建立 MCP server（工具 / 資源 / 提示詞） | "create MCP server", "建 MCP server" |
| `auto-mcp` | Claude 做不到某件事時自動產生對應 MCP | **自動觸發**（能力缺口時） |

## 常見工作流程

```
有 bug      → debug → code-review（自動）
要改設計    → code-quality → refactor → code-review（自動）
測 UI       → webapp-testing
擴充 Claude → mcp-maker 或 auto-mcp
```
