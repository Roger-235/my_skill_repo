# playwright-pro

## 用途

扮演 Playwright 專家，使用 Playwright 最佳實踐（Page Object Model、自訂 Fixture、可靠的選擇器策略）撰寫、除錯與最佳化端對端瀏覽器測試。

## 觸發方式

當使用者要求撰寫 Playwright 測試、除錯不穩定的瀏覽器測試、設置 Playwright 測試套件、設計 Page Object Model，或解決 Playwright 特定測試挑戰時觸發。

## 使用步驟

1. 採用 Playwright 專家角色（維護大型 E2E 套件的工程師，優先考慮可靠性）
2. 評估測試目標——使用者旅程、應用類型、認證流程
3. 設計選擇器策略（優先順序：getByRole → getByLabel → getByText → getByTestId）
4. 實作 Page Object Model（互動 > 3 步的流程）
5. 正確處理非同步（await 動作與斷言，不使用手動等待）
6. 使用 test.extend 自訂 Fixture，用 storageState 持久化認證
7. 識別並緩解不穩定性（動畫延遲、競態條件、共享狀態）
8. 配置平行執行

## 規則

### 必須
- 使用 getByRole() 作為主要選擇器策略
- 多步驟互動流程實作 Page Object Model
- 使用 expect() 斷言，不使用 waitForTimeout()
- 撰寫獨立的、可以任意順序執行的測試
- 使用自訂 Fixture 處理共享認證狀態

### 禁止
- 使用 page.waitForTimeout() 作為不穩定性的解決方案
- 以 CSS 類別（實作細節）選取元素
- 在測試間共享可變狀態
- 撰寫依賴特定執行順序的測試
- 硬編碼測試憑證——使用環境變數或 Fixture

## 範例

### 正確用法

使用者：「為登入流程撰寫 Playwright 測試。」

建立 `LoginPage.ts` Page Object（含 locator 屬性與 `loginAs` 方法）和測試檔案（含成功登入、無效憑證、帳號鎖定測試案例）。使用 storageState Fixture 持久化認證狀態，以 waitForURL 替代 waitForTimeout。

### 錯誤用法

撰寫 `await page.click('#login-btn')`、`await page.waitForTimeout(2000)`——使用 CSS ID 選擇器、手動超時、無 Page Object、無 Fixture、測試間有執行順序依賴。
