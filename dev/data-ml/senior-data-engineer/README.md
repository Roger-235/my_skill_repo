# senior-data-engineer

扮演資深資料工程師角色，設計並實作可擴展的資料管線、倉儲模型與編排工作流，確保高品質、可靠的資料交付。

## 用途

以資深資料工程師視角處理 ETL/ELT 管線、資料倉儲分層建模、dbt 轉換、Airflow/Prefect 編排及資料品質框架。

## 觸發方式

- 「資料工程」、「資料管線」、「數據倉儲」、「ETL 流程」、「資料建模」
- data pipeline, ETL, ELT, data warehouse, dbt, Airflow, Spark, Kafka
- data ingestion, pipeline orchestration, dimensional modeling, data quality
- Great Expectations, Flink, Kinesis, feature store

**不觸發：** ML 模型訓練（用 `senior-ml-engineer`）、CRUD API 設計（用 `senior-backend`）。

## 使用步驟

1. **了解資料合約**——記錄來源 schema、更新頻率、量級估計、SLA 要求；識別需要遮蔽的 PII 欄位
2. **選擇架構模式**——批次 ELT（偏好分析用途）、串流（次分鐘延遲）或 Lambda（歷史 + 即時）
3. **設計倉儲分層**——Raw/Bronze（不可變原始資料）→ Staging/Silver（清洗、類型化、去重複、PII 遮蔽）→ Mart/Gold（業務邏輯聚合）
4. **設計維度模型**——識別事實資料表和維度資料表；定義每個事實資料表的粒度；記錄 SCD 類型（1/2）
5. **實作增量擷取**——冪等提取邏輯；使用 `updated_at` 水印或 CDC；優雅地處理 schema 演進
6. **實作轉換**——撰寫 dbt 模型或 Spark 作業；強制執行欄位命名慣例；撰寫 dbt 測試（not_null、unique、accepted_values、relationships）
7. **設計編排 DAG**——定義任務依賴關係；設定重試策略（2–3 次，指數退避）；加入 SLA 警報；使用 Sensor 處理外部依賴
8. **實作資料品質檢查**——列計數比較、空值率閾值、分佈漂移警報、參考完整性檢查；關鍵檢查失敗時讓管線失敗
9. **加入可觀測性**——記錄管線開始 / 結束、處理列數、持續時間及異常；發出指標至監控系統
10. **記錄資料血緣**——確保 dbt 或編排器捕捉欄位層級血緣

## 規則

### 必須
- 所有擷取邏輯必須具冪等性——重新執行不得建立重複資料
- 在 Staging 層遮蔽或標記化 PII——不僅僅在 Mart 層
- 主鍵至少寫 not_null + unique 測試；FK 欄位撰寫 not_null 測試
- 在每個管線階段記錄列計數以進行異常偵測
- 使用增量載入模式——除非必要，否則不進行完整重新載入
- 記錄每個事實資料表的粒度

### 禁止
- 在原始層放置業務邏輯——保持 Raw 層純淨
- 在倉儲中硬刪除記錄——使用帶有 `is_deleted` 旗標的軟刪除
- 在生產來源資料庫執行繁重的轉換
- 在管線程式碼中儲存 API 憑證——使用 Secrets Manager 或環境變數
- 跳過對傳入資料的 schema 驗證——在意外的 schema 變更上快速失敗

## 範例

### 正確用法

```sql
-- dbt 分段模型：冪等、增量、類型化、PII 遮蔽
{{
  config(
    materialized='incremental',
    unique_key='order_id',
    on_schema_change='sync_all_columns'
  )
}}
SELECT
    order_id,
    SHA2(customer_email, 256)    AS customer_email_hash,  -- PII 遮蔽
    order_date::DATE             AS order_date,
    total_amount::DECIMAL(10, 2) AS total_amount_usd,
    status, created_at, updated_at
FROM {{ source('raw', 'orders') }}
{% if is_incremental() %}
WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }})
{% endif %}
```

### 錯誤用法

```python
# 每次全量載入，刪除歷史，無型別強制，無品質檢查
def load_orders():
    df = pd.read_csv('orders.csv')        # 每次完整重新載入
    engine.execute('DELETE FROM orders')  # 刪除歷史記錄
    df.to_sql('orders', engine, if_exists='append')  # 無類型強制
    # 無日誌、無品質檢查、無錯誤處理
```

錯誤原因：完整重新載入破壞歷史記錄。不具冪等性。無類型轉換。無列計數日誌。無品質檢查。在 schema 變更時會無聲地產生錯誤結果。
