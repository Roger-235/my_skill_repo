# Pipeline Orchestrator — 階層式 Agent Pipeline 自動化

L0 協調器，透過 Skill() 呼叫四個階段協調器，將 Story 從任務分解全自動推進到完成。

## 功能

- 四階段 pipeline：任務分解 → 多 agent 驗證 → 執行 → 品質把關
- 分層委派：L0 orchestrator → L1 coordinators → L2 workers
- 自動故障恢復：checkpoint 機制，context 壓縮後可從中斷處繼續
- 最多 2 次品質 rework 循環，超過自動升級給使用者

## 觸發時機

- 「run pipeline」、「execute story end-to-end」、「pipeline orchestrator」
- 「automate feature pipeline」、「full automation tasks to done」
- Story 已就緒，想要一鍵從任務拆解到完成

**不觸發**：
- 只需要其中一個階段 → 直接呼叫對應 coordinator
- 簡單單步任務

## 架構

```
L0: pipeline-orchestrator (你在這裡)
  ├── Stage 0: task-coordinator      ← 將 Story 拆解成 1-8 個任務
  ├── Stage 1: multi-agent-validator ← 多 agent 驗證計畫（外部 AI 審查）
  ├── Stage 2: story-executor        ← 執行所有任務（派發 worker agents）
  └── Stage 3: quality-gate          ← 審查品質分數；不通過則 rework
```

## 使用方法

```
/pipeline-orchestrator
→ 顯示可用 Story 清單
→ 詢問選擇哪個 Story
→ 一鍵推進到完成
```

## 故障恢復

若執行中斷（context 壓縮、網路問題等），重新呼叫即可：
```
/pipeline-orchestrator
→ 自動讀取 .pipeline/state.json
→ 從最後一個 checkpoint 繼續
```

## 安全性

- 每個階段結束後寫入 checkpoint，確保可中斷恢復
- 品質 FAIL 超過 2 次強制升級給使用者，不自動無限重試
- 所有破壞性操作（git push、檔案刪除）均有確認步驟
