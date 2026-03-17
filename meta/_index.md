# meta

## skill-system — Skill 管理 (9 skills)
| Skill | 說明 | 觸發詞 |
|-------|------|--------|
| meta-guide | 導覽 meta 類 skill，解釋 skill 系統運作 | 有哪些 meta skill, skill 系統怎麼運作 |
| skill-design | 網路研究 + 選擇題蒐集需求 → 交 spec 給 skill-maker | 我需要一個功能, 幫我做一個..., 設計 skill |
| skill-maker | 建立新 skill（含結構、規範、README） | create skill, make skill, 建立 skill |
| skill-edit | 修改或刪除現有 skill，同步 guide + README | edit skill, delete skill, 修改/刪除 skill |
| skill-audit | 新 skill 產生後自動結構 + 資安稽核 | 自動觸發（skill-maker 完成後） |
| skill-readme-sync | SKILL.md 編輯後檢查 README 是否同步 | 自動觸發（SKILL.md 編輯後） |
| skill-index-sync | skill 增刪改名後同步所有索引 md | 自動觸發（skill-maker / skill-edit 後） |
| skill-library-lint | 整個 skill 庫結構規範稽核（命名、index、guide 完整性） | 自動觸發（skill-maker / skill-edit / skill-index-sync 後） |
| skill-security-auditor | Skill 資安稽核：掃描 SKILL.md 的安全風險與注入漏洞 | audit skill security, security check skill |
| skill-tester | Skill 測試器：在沙箱環境中驗證 skill 行為是否符合預期 | test skill, validate skill, 測試 skill |

## session — 任務管理 (6 skills)
| Skill | 說明 | 觸發詞 |
|-------|------|--------|
| task-planner | 將複雜任務分解為有依賴關係的子任務清單 | plan this task, 分解任務, 制定計畫 |
| checkpoint-recovery | 儲存並恢復長任務進度，中斷後從斷點繼續 | save progress, checkpoint, 儲存進度 |
| continuous-learning | 從對話提取可重用模式並存入持久記憶系統 | remember this pattern, 記住這個模式 |
| token-optimizer | 分析 context 用量，建議壓縮策略 | token usage, optimize context, Token 用量 |
| pre-output-review | 每次輸出前自動品質審查 | 自動觸發（每次輸出前） |
| self-improving-agent | 整理 Claude 自動記憶，將學習成果升級為專案知識 | review memory, graduate pattern, 整理記憶 |
