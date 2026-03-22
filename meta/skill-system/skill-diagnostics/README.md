# Skill Diagnostics

針對**現有** skill 的主動健診工具，掃描結構缺陷、斷連結、漸進式揭露違規與內容品質問題。

## 用途

- 主動掃描任何現有 skill（單一或全庫）
- 發現 C14 斷連結（`ref/` 檔案不存在）— 運行時靜默失敗最難發現的問題
- 發現 C13 漸進式揭露違規（純參考內容超過 50 行但未移至 `ref/`）
- 發現 C10 不可測試的 Rule（"be clear", "ensure quality" 等）
- 發現 C17/C18 README 缺失或非中文

## 與其他稽核工具的差異

| 工具 | 觸發時機 | 重點 |
|------|---------|------|
| `skill-audit` | skill-maker 完成後（單一新 skill） | 結構 + 衝突 + 重複 + 資安 |
| `skill-library-lint` | skill-maker / skill-edit 後（全庫） | 命名、index、guide 完整性 |
| `skill-security-auditor` | 安裝第三方 skill 前 | 靜態資安掃描 |
| **skill-diagnostics** | **隨時主動觸發** | **內容品質、斷連結、PD 違規** |

## 觸發方式

```
診斷 skill              → 單一 skill 健診
找出 skill 的問題        → 單一 skill 健診
skill health check      → 單一 skill 健診
掃描 skill 問題          → 批次全庫健診
```

## 輸出格式

依嚴重度分組（CRITICAL → HIGH → MEDIUM → LOW），每個問題含：
- 所在 skill 路徑
- 違反的檢查項目（C1–C18）
- 具體證據（章節名、行號、引用片段）
- 具體修復方式

最後給出 **PASS / FAIL 判定**（有 CRITICAL 或 HIGH 未解決 → FAIL）。

## 檢查清單摘要

18 項檢查涵蓋：frontmatter 格式、章節結構完整性、Rule 可測試性、Examples 完整性、漸進式揭露、ref 連結有效性、行數限制、README 存在與語言。

詳見 [SKILL.md](SKILL.md) 的 Content Checklist 表格。
