# playwright-mcp-setup

## 用途

指導完整設置 `@playwright/mcp` MCP 伺服器，讓 Claude 獲得直接的瀏覽器控制能力，用於自動化測試、網頁爬取與 UI 互動任務。

## 觸發方式

當使用者想透過 `@playwright/mcp` MCP 伺服器賦予 Claude 直接瀏覽器控制能力、透過 MCP 設置瀏覽器自動化，或將 Playwright 配置為 Claude 可用工具時觸發。

## 使用步驟

1. 安裝 Chromium 瀏覽器：`npx playwright install chromium`
2. 編輯 Claude Desktop 配置檔案，加入 playwright MCP 伺服器設定
3. 完全關閉並重新啟動 Claude Desktop（或重啟 Claude Code 工作階段）
4. 驗證瀏覽器工具可用（如 browser_navigate、browser_screenshot）
5. 測試設置：請 Claude「截取 https://example.com 的螢幕截圖」
6. 選擇性固定版本號以確保可重現性

## 規則

### 必須
- 安裝前驗證 Node.js 18+
- 提供平台特定的配置檔案路徑（macOS / Windows / Linux）
- 包含重啟步驟——MCP 伺服器僅在啟動時載入
- 提供測試指令驗證設置是否正常
- 說明有頭（headed）與無頭（headless）模式的取捨

### 禁止
- 建議全域安裝 `@playwright/mcp`（`npm install -g`）——應使用 `npx`
- 跳過重啟步驟——這是常見的設置失敗原因
- 在配置中使用硬編碼的 npx 絕對路徑
- 指導使用者手動以獨立伺服器執行——Claude 管理伺服器生命週期

## 範例

### 正確用法

使用者：「如何用 Playwright MCP 賦予 Claude 瀏覽器控制？」

提供完整設置：安裝 Chromium、顯示 claude_desktop_config.json 的精確 JSON 配置、說明有頭與無頭模式、指示重啟 Claude Desktop，並提供測試提示以驗證工具可用。

### 錯誤用法

回應「用 `npm install playwright` 安裝 Playwright 並配置 MCP 伺服器。」——套件名稱錯誤（應為 `@playwright/mcp`）、無配置 JSON、無重啟指示、無驗證步驟。
