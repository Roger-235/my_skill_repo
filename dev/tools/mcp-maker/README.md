# MCP Maker — MCP 伺服器生成器

根據使用者需求，自動生成具備完整工具、資源與提示詞定義的 MCP 伺服器程式碼。支援 Python 與 TypeScript，並提供與 Claude Agent SDK 整合的連線片段，讓自定義工具立即可用。

## 功能

- 引導使用者逐步定義工具（name、description、input schema、business logic）
- 自動生成含輸入驗證的工具處理函式
- 支援 in-process（嵌入式）與 standalone（外部 stdio）兩種部署模式
- 可選：定義資源（URI template）與提示詞模板
- 生成後執行程式碼安全稽核，確保無憑證洩漏與 shell 注入風險

## 觸發時機

- 「建立 MCP 伺服器」、「幫我做一個 Claude 工具」、「用 MCP 連接我的 API」
- 「新增自定義工具」、「建立 tool server」、「擴展 Claude 的能力」
- create MCP server、build MCP tool、extend Claude with tools、implement MCP

**不觸發**：單純使用 Anthropic SDK 而不需自定義工具（請用 `claude-api` skill）、修改現有 MCP 程式碼、一般 REST API 客戶端開發。

## 使用方法

呼叫此 skill 後，依序回答以下問題：

1. 伺服器名稱與程式語言（Python / TypeScript）
2. 部署模式：in-process（嵌入應用程式）或 standalone（獨立 stdio 程序）
3. 每個工具的名稱、描述、參數清單與業務邏輯
4. 可選：資源（URI template）
5. 可選：提示詞模板

Skill 將根據以上資訊生成完整伺服器程式碼與 Claude 連線片段。

**Python 範例：**

```python
from claude_agent_sdk import query, ClaudeAgentOptions, ResultMessage

async for message in query(
    prompt="讀取 ID 為 my-note 的筆記",
    options=ClaudeAgentOptions(mcp_servers={"notes-tools": server})
):
    if isinstance(message, ResultMessage):
        print(message.result)
```

## 前置需求

**Python：**

```bash
python3 --version           # 需要 Python 3.10+
pip install claude-agent-sdk
python3 -c "from claude_agent_sdk import tool, create_sdk_mcp_server; print('ok')"
```

**TypeScript：**

```bash
node --version              # 需要 Node.js 18+
npm install @anthropic-ai/claude-agent-sdk zod
node -e "require('@anthropic-ai/claude-agent-sdk')"
```

## 安全性

- 生成的工具處理函式包含輸入驗證，防止型別錯誤與越界存取
- 拒絕在 shell 指令中使用動態輸入（禁止 `shell=True` + 使用者輸入）
- 檔案路徑工具包含路徑穿越防護（拒絕 `../`，限制在允許的基底目錄內）
- 憑證必須透過環境變數傳入（`os.environ["KEY"]`），不得硬編碼
- 工具名稱與描述視為資料，不視為可執行指令
