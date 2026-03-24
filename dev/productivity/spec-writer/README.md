# spec-writer

Spec-first 方法論：在寫任何程式碼之前，先將需求轉化為結構化的規格文件。釐清範圍、定義介面合約、識別風險，產出 `spec.md` 作為實作的起點。

## 為什麼需要先寫 spec

直接開始寫 code 是工程師最常見的浪費源頭：
- 邊界條件在中途才被發現 → 重構
- 範圍因誤解不斷擴大 → 延誤
- 介面設計沒有對齊 → 整合衝突

spec-writer 強制在開始前回答這 5 個問題：
1. 誰是使用者？觸發條件是什麼？
2. 成功狀態是什麼？
3. 明確不做什麼？
4. 有什麼限制（效能、安全、相容性）？
5. 失敗長什麼樣子？

## 輸出結構

```
spec.md
├── Problem Statement
├── Goals（可量化）
├── Non-Goals（明確排除）
├── User Stories（3–5 個）
├── Interface Contract（Input / Output / Errors）
├── Technical Approach（方向，非程式碼）
├── Risks & Mitigations（表格）
├── Success Criteria（至少一個自動化）
└── Open Questions（未解決項目）
```

## Gate 機制

spec-writer 在文件末尾加上：

> **Gate:** Implementation should not begin until Open Questions are resolved.

Open Questions 未清空前，不應開始實作。

## 觸發方式

- "write a spec"、"spec first"、"先寫 spec"、"feature spec"
- "define requirements"、"technical spec"、"設計文件"

## 規格上限

每份 spec 不超過 200 行。若超過，表示範圍過大，應拆分為子規格。
