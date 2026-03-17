# aws-solution-architect

## 用途

設計完整的 AWS 雲端架構，依據 AWS Well-Architected Framework 六大支柱選擇服務、規劃網路拓撲、IAM 策略、成本估算，並產出架構圖與設計文件。

## 觸發方式

當使用者要求：
- 設計、規劃或審查 AWS 架構或雲端解決方案
- 選擇適合特定工作負載的 AWS 服務
- 估算 AWS 成本或定義 IAM 策略
- 觸發關鍵詞：「design AWS architecture」、「AWS solution」、「cloud architecture AWS」、「deploy on AWS」、「AWS infrastructure design」

## 使用步驟

1. 分類工作負載類型與存取模式
2. 依 Well-Architected Framework 六大支柱評估
3. 設計運算層（EC2、Lambda、ECS/Fargate、EKS 等）
4. 設計資料層（資料庫與儲存服務選擇）
5. 設計網路（VPC、子網路、安全群組、負載平衡器、CDN）
6. 設計 IAM（最小權限原則、角色與策略）
7. 設計可觀測性（CloudWatch、X-Ray、告警）
8. 估算各服務月費
9. 識別風險與緩解措施
10. 輸出架構文件與 Mermaid 架構圖

## 規則

### 必須
- 必須套用 Well-Architected Framework 六大支柱
- 必須遵循最小權限 IAM 原則
- 可用性 SLA 有要求時必須設計 Multi-AZ
- 必須提供按服務分項的成本估算
- 必須識別單點故障並提出緩解方案

### 禁止
- 禁止將資料庫放在公有子網路
- 禁止推薦硬編碼憑證，必須使用 Secrets Manager 或 Parameter Store
- 禁止忽略已聲明的合規要求
- 禁止省略網路設計細節
- 禁止在未說明理由的情況下推薦服務

## 範例

### 正確用法

```
使用者：為每秒 500 請求的 REST API 與 PostgreSQL 資料庫設計 AWS 架構。
→ 輸出完整文件：ECS Fargate 運算、RDS Aurora PostgreSQL Multi-AZ、ElastiCache、ALB + CloudFront、VPC 私有子網路、IAM 任務角色、CloudWatch 可觀測性、成本估算約 $300/月、風險識別。
```

### 錯誤用法

```
使用者：為 REST API 設計 AWS 架構。
回應：用 EC2 當伺服器，RDS 當資料庫，S3 存檔案，全部放 us-east-1。
→ 錯誤原因：無 Well-Architected 分析、無服務選擇理由、無網路設計、無 IAM、無可觀測性、無成本估算。
```
