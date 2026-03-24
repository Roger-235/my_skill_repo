# Canary — 部署後回歸監控

## 說明

部署完成後持續監控線上環境，比對預先擷取的 baseline，只在**有變化**時發出警報，避免誤報。

## 觸發方式

```
canary https://myapp.com
canary https://myapp.com --duration 5m
canary https://myapp.com --baseline
canary https://myapp.com --quick
部署後監控
上線後巡邏
```

## 使用流程

```
# 部署前：擷取 baseline
canary https://myapp.com --baseline

# 部署後：開始監控（預設 10 分鐘）
canary https://myapp.com
```

## 監控項目

| 訊號 | 警報閾值 | 嚴重度 |
|------|---------|--------|
| 新增 console error | 任何基線沒有的 error | HIGH |
| 載入時間 | > 2× baseline | HIGH |
| 頁面失敗 | HTTP 4xx/5xx | CRITICAL |
| 失效連結 | 404（基線沒有的） | MEDIUM |

## 核心設計原則

**Change-detection，非絕對值**：基線已有 3 個 error、現在還是 3 個 → 健康。新增 1 個 error → 警報。這大幅降低誤報率。

## 需求

- Playwright MCP 瀏覽器工具可用
- 目標 URL 可存取
