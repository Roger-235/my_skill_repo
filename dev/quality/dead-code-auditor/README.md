# dead-code-auditor

掃描程式庫中的死碼：未使用的 export、zombie function、不可達程式碼路徑、未使用的 import 和套件。產出按移除影響力排序的清單，附 `file:line` 參照。

## 與 tech-debt-tracker 的差異

| | dead-code-auditor | tech-debt-tracker |
|--|-------------------|------------------|
| **焦點** | 可直接刪除的無效程式碼 | 需要重構的技術債 |
| **風險** | 低（移除不影響行為） | 中高（需要重構） |
| **輸出** | 具體刪除清單 | 優先修復計畫 |

## 偵測類別（優先順序）

| 優先 | 類型 | 說明 |
|------|------|------|
| P1 | 未使用的相依套件 | `package.json` / `requirements.txt` 中有但程式碼不用 |
| P1 | `SAFE_DELETE` 不可達程式碼 | `return` 後的程式碼、永遠為 false 的條件 |
| P2 | Zombie exported functions | 有 export 但零個呼叫者 |
| P3 | 未使用的 private functions | 定義了但從未呼叫 |
| P4 | 未使用的 imports | import 了但沒用到 |

## 支援工具

| 語言 | 工具 |
|------|------|
| TypeScript/JS | `ts-unused-exports`、`depcheck`、ESLint `no-unused-vars` |
| Python | `vulture`、`autoflake` |
| Go | `staticcheck`、`go vet` |

## 觸發方式

- "dead code"、"unused code"、"zombie functions"
- "find unused exports"、"死碼"、"未使用的程式碼"
- 遷移後清理、清理 sprint 前的健診

## 重要限制

- 只報告，不自動刪除 — 所有刪除需使用者確認
- 不把「沒有測試」等同於「死碼」
- 透過反射、序列化、magic string 使用的符號不標為死碼
