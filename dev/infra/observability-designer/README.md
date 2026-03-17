# observability-designer

## 用途

為應用程式與基礎設施設計完整的可觀測性方案，涵蓋指標收集、結構化日誌、分散式追蹤與可行的告警規則。

## 觸發方式

當使用者要求建立監控系統、為應用程式新增可觀測性、配置告警、建構日誌管道，或整合分散式追蹤時觸發。

## 使用步驟

1. 評估現狀——確認已有的指標、日誌、追蹤與告警工具
2. 設計三大支柱：指標（OpenTelemetry + Prometheus）、日誌（結構化 JSON + Fluent Bit/Loki）、追蹤（OTEL + Jaeger/Tempo）
3. 設計四黃金訊號告警規則（延遲、流量、錯誤率、飽和度）
4. 生成 OTEL Collector 配置，路由遙測到各後端
5. 描述 Grafana 儀表板面板
6. 定義 SLI 與 SLO

## 規則

### 必須
- 透過 trace_id 關聯日誌、指標與追蹤
- 使用 OpenTelemetry 作為廠商中立的插裝層
- 告警規則至少涵蓋四黃金訊號
- 伴隨可觀測性設計定義 SLO
- 使用 histogram 指標（非 summary）計算延遲分位數

### 禁止
- 設計沒有 runbook 連結或修復指引的告警
- Prometheus scrape 間隔短於 10 秒
- 儲存原始非結構化日誌而不進行解析/結構化
- 對值班工程師無法採取行動的症狀發出告警
- 在 Collector 配置中硬編碼服務端點

## 範例

### 正確用法

使用者：「為 Kubernetes 上的 Node.js 微服務新增可觀測性。」

設計 OTEL Node.js SDK 自動插裝 + OTLP 匯出、Prometheus 指標、Fluent Bit → Loki 日誌管道、Jaeger 追蹤、四黃金訊號告警規則，以及 SLO 目標（99.9% 請求在 500ms 內完成）。

### 錯誤用法

回應「加入 console.log 並用 pm2 monit 監控 CPU 用量」——無結構化日誌、無指標、無追蹤、無告警、無 SLO。
