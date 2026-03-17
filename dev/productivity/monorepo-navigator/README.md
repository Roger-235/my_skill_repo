# monorepo-navigator

## 用途

協助工程師在 Nx、Turborepo、Bazel 或 Lerna 管理的 monorepo 中進行導覽與操作，包含了解套件依賴圖、執行受影響的任務、管理相依套件，以及套用一致的跨套件模式。

## 觸發方式

當使用者詢問如何在 monorepo 中工作、需要僅對受影響的套件執行任務、想了解依賴圖、需要新增套件，或詢問 monorepo 專用工具（Nx、Turborepo、Bazel、Lerna）時觸發。

關鍵字：`monorepo`、`nx`、`turborepo`、`bazel`、`lerna`、`workspace`、`affected`、`packages`、`nx graph`、`turbo run`

## 使用步驟

1. **識別工具鏈** — 檢查儲存庫根目錄中的 `nx.json`、`turbo.json`、`lerna.json`、`WORKSPACE` 或 `pnpm-workspace.yaml`。
2. **對應工作區** — 列出所有套件/應用程式及其位置。
3. **了解依賴圖** — 視覺化或描述套件間的相依關係（`nx graph`、`turbo run build --graph`）。
4. **執行受影響任務** — 僅對自基準 ref 以來有變更的套件執行建置/測試：
   - Nx：`nx affected -t test --base=main`
   - Turborepo：`turbo run test --filter=...[origin/main]`
5. **執行特定套件任務** — `nx run <project>:<target>` 或 `turbo run build --filter=@scope/package`。
6. **新增套件** — 依照儲存庫的產生器/範本進行腳手架（`nx generate @nx/js:library`、`turbo gen`）。
7. **管理跨套件相依套件** — 以工作區參考方式新增內部相依套件，驗證圖沒有循環。
8. **快取與 CI 指引** — 說明遠端快取設定（Nx Cloud、Turborepo Remote Cache）以提升 CI 速度。

## 規則

### 必須

- 在給出指令前一律識別工具鏈——不同工具的語法差異顯著。
- 在 CI 中使用 `affected` 指令，避免每次提交都重建整個儲存庫。
- 內部套件以工作區參考方式維護，絕不在同一儲存庫內以已發布的版本固定為相依套件。
- 遵循儲存庫現有的套件命名慣例和目錄結構。
- 新增套件後驗證依賴圖是否為有向無環圖（DAG，無循環）。

### 禁止

- 禁止在僅需執行受影響任務時對所有套件執行完整的 `build`/`test`。
- 禁止在同一個 monorepo 中混用套件管理器。
- 禁止在套件之間引入循環依賴。
- 禁止無意間將內部工作區套件發布到外部登錄庫。
- 禁止跨套件使用硬式編碼的相對路徑——使用工作區別名或 tsconfig 路徑。

## 範例

### 正確用法

```bash
# 僅對受影響套件執行測試
nx affected -t test --base=origin/main --head=HEAD

# 建置 api 及其所有依賴
turbo run build --filter=@acme/api...

# 新增共用函式庫
nx generate @nx/js:library shared-utils --importPath=@acme/shared-utils
```

### 錯誤用法

```bash
# 無篩選條件，重建整個儲存庫——浪費 CI 時間
turbo run build

# 跨套件使用相對路徑——脆弱且易斷
import { helper } from '../../libs/shared/src/index'

# 循環依賴——嚴禁此做法
# packages/a 依賴 packages/b，packages/b 依賴 packages/a
```
