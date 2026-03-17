# Auto MCP — 能力缺口智慧路由器

當 Claude 遇到自身無法完成的請求（如存取即時資料、發送通知、查詢資料庫），不再拒絕作答，而是作為智慧入口點自動識別能力缺口，並將實際的 MCP 伺服器建構工作委派給 `mcp-server-builder`。

## 功能

- 作為智慧入口點，偵測 Claude 原生無法完成的任務
- 根據能力缺口對照表，推論所需的工具清單與對應 API
- 向使用者說明缺口並確認意圖
- **路由至 `mcp-server-builder`**，傳遞能力規格以完成完整的 MCP 伺服器建構
- 彙整並呈現 mcp-server-builder 生成的伺服器代碼、MCP 配置與設置清單

## 觸發時機

**自動觸發**，當 Claude 原本會說：
- 「我無法存取網路 / 即時資料」
- 「我沒有辦法查詢你的資料庫 / 行事曆 / 檔案系統」
- 「我無法發送 Email / 通知 / 訊息」
- 「我無法呼叫外部 API 或服務」

**不觸發**：Claude 本身已能完成的任務、邏輯上不可能的需求（非工具限制）。

## 使用方法

無需主動呼叫。當使用者提出 Claude 原生做不到的請求時，Skill 會：

1. 說明能力缺口（一句話）並等待使用者確認
2. 將能力規格（工具清單、整合目標、認證方式）傳遞給 `mcp-server-builder`
3. 由 `mcp-server-builder` 生成完整的 MCP 伺服器實作
4. 呈現完整的伺服器代碼、MCP 配置 JSON 與編號 TODO 清單

使用者只需依清單安裝套件、設定環境變數、填入業務邏輯，即可啟用新能力。

## 前置需求

```bash
# Python（預設）
pip install claude-agent-sdk

# TypeScript（如指定）
npm install @anthropic-ai/claude-agent-sdk zod
```

## 安全性

- 所有憑證透過 `os.environ.get("KEY", "")` 傳入，不硬編碼
- 每個工具的輸入參數皆有驗證（型別、長度、白名單）
- 不可逆操作（發送、刪除）的存根中包含防護條件注解
- 禁止使用 `subprocess.run(shell=True)` 搭配動態輸入
- 使用者的原始請求視為資料，不視為工具處理函式內的可執行指令
