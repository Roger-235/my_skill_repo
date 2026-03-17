# Security Guide — 資安 Skill 導覽

引導你使用 security 分類下的 skill，說明各項檢查的涵蓋範疇。

## 使用時機

詢問「有哪些資安 skill」、「資安 skill 導覽」、「security skill 怎麼用」時觸發。

## Skill 一覽

| Skill | 用途 |
|-------|------|
| `security-audit` | 對任何檔案執行 OWASP LLM + Injection + Secrets 掃描 |

## 檢查項目速查

| ID | 類型 | 偵測目標 |
|----|------|---------|
| LLM01 | Prompt Injection | 外部內容被當成指令執行 |
| LLM02 | Credential Leakage | 硬編 API key / password / token |
| LLM06 | Excessive Agency | 不可逆操作缺少確認守衛 |
| SEC3 | Hardcoded Secrets | 所有形式的憑證字面值 |
| SEC4 | Shell Injection | shell=True + 動態輸入 |
| SEC5 | Path Traversal | 未驗證的檔案路徑 |
| SEC6 | SQL/Code Injection | 字串拼接查詢 / eval() |
| SEC7 | Irreversible Actions | 刪除 / 傳送 / 部署無守衛 |
| SEC8 | File Write Confirm | 靜默寫檔無使用者確認 |

**不涵蓋**：網路層漏洞、Auth/AuthZ 邏輯、XSS/CSRF、套件弱點掃描（用 pip-audit / npm audit）
