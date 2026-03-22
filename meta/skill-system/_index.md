# meta / skill-system — Skill 管理

| Skill | 說明 | 觸發詞 |
|-------|------|--------|
| skill-design | 網路研究 + 選擇題蒐集需求 → 交 spec 給 skill-maker | 我需要一個功能, 幫我做一個..., 設計 skill |
| skill-maker | 依據確認的 spec 建立 skill 資料夾與檔案 | create skill, make skill, 建立 skill |
| skill-edit | 修改或刪除現有 skill，同步 guide + README | edit skill, delete skill, 修改/刪除 skill |
| skill-audit | 新 skill 產生後自動結構 + 資安稽核 | 自動觸發（skill-maker 完成後） |
| skill-readme-sync | SKILL.md 編輯後檢查 README 是否同步 | 自動觸發（SKILL.md 編輯後） |
| skill-index-sync | skill 增刪改名後同步所有索引 md | 自動觸發（skill-maker / skill-edit 後） |
| skill-library-lint | 整個 skill 庫結構規範稽核（命名、index、guide 完整性） | 自動觸發（skill-maker / skill-edit / skill-index-sync 後） |
| skill-security-auditor | Skill 資安稽核：掃描 SKILL.md 的安全風險與注入漏洞 | audit skill security, security check skill, 資安稽核 skill |
| skill-tester | Skill 測試器：在沙箱環境中驗證 skill 行為是否符合預期 | test skill, validate skill, 測試 skill |
| skill-diagnostics | 現有 skill 主動健診：斷連結、PD 違規、內容品質、README 同步 | diagnose skill, 找出 skill 的問題, skill 品質檢查 |
