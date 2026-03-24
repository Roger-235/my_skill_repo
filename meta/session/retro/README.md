# Retro — Git 驅動週回顧

## 說明

分析 git commit 歷史，產出量化工程週回顧：指標、每人貢獻分析（錨定在真實 commit）、shipping streak、可分享摘要卡。

## 觸發方式

```
retro
retro 14d
retro compare
retro global
週回顧
回顧這週
工程回顧
```

## 三種模式

| 模式 | 指令 | 說明 |
|------|------|------|
| **Standard** | `retro [window]` | 分析指定時間窗（預設 7 天）|
| **Compare** | `retro compare` | 本期 vs 上期並排對比 |
| **Global** | `retro global` | 跨專案發現所有 coding session |

## 輸出內容

- 指標表（commits、LOC、PR 量、測試覆蓋率、shipping streak）
- 本週最佳 ship（引用具體 commit message）
- 每人分析（稱讚 + 成長機會，全部錨定真實 commit）
- 熱點檔案（最常被改動的檔案）
- commit 類型分布（feat / fix / chore / docs / test）
- 反思問題
- 可發推的一行總結

## 核心原則

**所有反饋必須錨定具體 commit**，不接受泛泛稱讚（「大家這週表現很好」不算回顧）。

## 資料儲存

JSON snapshot 儲存至 `.context/retros/<date>.json` 用於趨勢追蹤。
