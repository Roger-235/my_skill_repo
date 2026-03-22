# unified-quality-auditor

統一品質閘道：一個指令同時審查 Skill 檔案與源碼，合併輸出優先級報告。

## 用途

自動偵測目標路徑中的檔案類型：

- 找到 `SKILL.md` → 執行 C1–C18 skill 診斷
- 找到源碼（`.ts` / `.py` / `.go`）→ 執行命名、格式、匯入規範審查
- 兩者都有 → 同時執行，結果合併輸出

## 觸發方式

```
unified quality audit
quality gate
check skill and code
統一品質審查
檢查 skill 跟 code
全面品質掃描
全掃
```

## 輸出格式

```
## Unified Quality Report: <目標路徑>

Scanned: N SKILL.md · N source files

### CRITICAL / HIGH / MEDIUM / LOW
| # | Source  | File | Check | Evidence | Fix |
    [SKILL] 或 [CODE] 標記來源

### 判定
PASS / FAIL
```

## 與其他 Skill 的關係

| 情況 | 使用 |
|------|------|
| 只掃 skill 庫 | `skill-diagnostics` |
| 只掃源碼規範 | `code-convention-auditor` |
| 兩者都要掃 | **`unified-quality-auditor`** ← 本 skill |
| 資安漏洞掃描 | `security-audit` |
| 新建 skill 後驗證 | `skill-audit` |

## 規則

- 每條違規標記 `[SKILL]` 或 `[CODE]`
- 目標含兩種檔案時兩個 check 都必須跑
- 套用修正前必須等使用者確認
