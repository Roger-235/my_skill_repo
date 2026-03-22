# 代碼規範審查器（Code Convention Auditor）

掃描代碼檔案，對照命名、格式、匯入順序、語言慣用寫法等規範，產出**繁體中文**違規報告。

## 用途

- 掃描 TypeScript / Python / Go 代碼，比對命名與格式規範
- 優先讀取專案自定義規範（`CLAUDE.md`、ESLint、mypy、golangci），無自定義時使用語言預設值
- 輸出中文優先級違規報告（HIGH / MEDIUM / LOW），每條違規附具體位置與可直接套用的修正建議
- 使用者確認後套用修正，並重新掃描確認清零

## 與其他品質工具的差異

| 工具 | 重點 |
|------|------|
| `code-convention-auditor` | 命名、格式、匯入、語言慣用寫法 → **中文報告** |
| `code-quality` | SOLID 原則、設計氣味、複雜度 |
| `code-reviewer` | PR 整體審查：架構、效能、安全 |
| `pr-review-expert` | 深度 PR 審查：模式、邊界案例 |

## 觸發方式

```
檢查代碼規範          → 指定檔案或目錄的規範審查
代碼風格              → 同上
命名規範              → 聚焦命名項目
check code conventions → 英文觸發
convention audit       → 英文觸發
```

## 輸出格式

報告按嚴重度分組（HIGH → MEDIUM → LOW），每條違規含：
- **位置**：`檔名:行號`
- **規範**：違反的規範名稱
- **問題**：中文說明
- **修正建議**：可直接套用的代碼

最後給出 **通過 / 不通過** 判定（有 HIGH 未解決 → 不通過）。

## 規範來源（優先順序）

1. 專案 `CLAUDE.md` 中的 conventions 段落
2. `.editorconfig` / `eslint.config.js` / `pyproject.toml` / `.golangci.yml`
3. 語言內建預設值（詳見 [SKILL.md ref/default-conventions.md](ref/default-conventions.md)）
