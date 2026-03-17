# performance-profiler

## 用途

透過系統化的效能分析識別並解決應用程式效能瓶頸，涵蓋 CPU、記憶體、I/O 與資料庫查詢問題。

## 觸發方式

當使用者回報應用程式效能緩慢、CPU 或記憶體使用率過高、延遲回退、N+1 查詢問題、記憶體洩漏，或詢問如何對應用程式進行效能分析時觸發。

關鍵字：`performance`、`profiling`、`slow`、`latency`、`cpu hotspot`、`memory leak`、`n+1`、`flame graph`、`profiler`、`bottleneck`

## 使用步驟

1. **量化症狀** — 收集基準指標：p50/p95/p99 延遲、CPU 百分比、記憶體 RSS、GC 暫停時間、資料庫查詢次數。
2. **依語言選擇分析工具**：
   - Node.js：`clinic flame`、`0x`
   - Python：`py-spy`（採樣，無需重啟）、`memray`（記憶體）
   - Go：`go tool pprof`、`net/http/pprof`
   - JVM：async-profiler、Java Flight Recorder
   - 瀏覽器：Chrome DevTools Performance、Lighthouse
   - 資料庫：`EXPLAIN ANALYZE`（PostgreSQL）、慢查詢日誌
3. **在負載下擷取效能分析** — 使用具代表性的流量模式；生產環境使用採樣型分析器（py-spy、async-profiler）。
4. **分析火焰圖** — 找出最寬的幀（耗時最多的部分），聚焦於應用程式程式碼。
5. **識別常見模式** — N+1 查詢、記憶體洩漏、CPU 熱點、事件循環中的阻塞 I/O、鎖定競爭。
6. **實施修復** — 進行有針對性的變更，不做無關的重構。
7. **基準測試比較** — 使用 `wrk`、`hey`、`k6` 或語言的基準測試框架量化改善效果。

## 規則

### 必須

- 效能分析前一律建立可測量的基準值。
- 生產環境使用採樣型分析器以最小化額外負擔。
- 在具代表性的負載下進行效能分析，而非合成的閒置條件。
- 每次只做一個變更並重新基準測試，以隔離效果。
- 以百分比呈現相對基準值的改善，而非僅有絕對值。

### 禁止

- 禁止在停用除錯符號的情況下進行效能分析（混淆的堆疊無法閱讀）。
- 禁止在未降載的情況下在生產環境執行完整插裝分析器。
- 禁止在沒有分析器證據的情況下進行最佳化——不做過早最佳化。
- 禁止以「感覺更快了」作為驗證——必須進行測量。

## 範例

### 正確用法

```bash
# Python：附加到執行中的程序
py-spy record -o profile.svg --pid 12345 --duration 30

# Go：擷取 CPU 效能分析
go tool pprof -http=:9090 http://localhost:6060/debug/pprof/profile?seconds=30

# 資料庫：找出慢查詢
SELECT query, mean_exec_time, calls
FROM pg_stat_statements
ORDER BY mean_exec_time DESC LIMIT 20;
```

```
## 基準測試結果
| 指標        | 之前   | 之後  | 改善幅度 |
|-------------|--------|-------|---------|
| p99 延遲    | 420ms  | 85ms  | -80%    |
| CPU 使用率  | 94%    | 31%   | -67%    |
| 每請求 DB 查詢次數 | 47 | 2 | -96% |
```

### 錯誤用法

```
# 無效能分析數據就進行最佳化
"我重構了這個迴圈，因為它看起來很慢。"

# 接受主觀驗證
"頁面明顯變快了。"（沒有基準測試數據）
```
