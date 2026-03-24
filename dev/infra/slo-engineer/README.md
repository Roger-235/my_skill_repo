# slo-engineer

定義服務的 SLI（衡量什麼）、SLO（目標是什麼）、Error Budget（允許多少失敗）和 Burn Rate Alert（何時警報）。輸出 `slo-spec.md` 規格文件和 Prometheus/alertmanager 配置。

## 核心概念

```
SLI = 衡量服務品質的指標（例：99.2% 的請求在 300ms 內回應）
SLO = 對 SLI 的目標（例：P95 延遲 < 300ms 達到 99.5%）
Error Budget = 允許違反 SLO 的空間 = 1 - SLO
Burn Rate = 目前消耗 error budget 的速度倍率
```

## SLO 目標選擇指南

| 目標 | 月度 Error Budget | 適合場景 |
|------|-----------------|---------|
| 99.0% | 7h 18m | 內部工具、批次作業 |
| 99.5% | 3h 39m | 非關鍵生產 API |
| 99.9% | 43m 48s | 標準生產服務 |
| 99.95% | 21m 54s | 高流量面向使用者服務 |
| 99.99% | 4m 22s | 支付、認證、核心基礎設施 |

**黃金法則：** SLO = 過去 90 天實測可靠性 - 一個 9。不要設你還沒達到的目標。

## Burn Rate Alert 設計

| 警報 | 倍率 | 視窗 | 嚴重性 | 意義 |
|------|------|------|--------|------|
| 立即呼叫 | 14.4× | 1h | P0 | 2 小時內耗盡 30 天 budget |
| 呼叫 | 6× | 6h | P1 | 5 天內耗盡 30 天 budget |
| 建票 | 3× | 72h | P2 | 10 天內耗盡 30 天 budget |

## Error Budget Policy

| Budget 剩餘 | 行動 |
|------------|------|
| > 50% | 正常發布節奏 |
| 10–50% | 發布前加強審查 |
| < 10% | 凍結非關鍵變更 |
| 耗盡 | 宣告事故，找出根因後才能繼續發布 |

## 觸發方式

- "SLO"、"SLI"、"error budget"、"服務等級"、"99.9%"
- "burn rate alert"、"服務可靠性"、"reliability target"
