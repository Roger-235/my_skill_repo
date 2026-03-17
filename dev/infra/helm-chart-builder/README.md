# helm-chart-builder

## 用途

生成生產就緒的 Helm Chart，包含結構完整的模板、可配置的 Values 檔案，以及 Kubernetes 最佳實踐。

## 觸發方式

當使用者要求建立 Helm Chart、將服務打包供 Kubernetes 以 Helm 部署、生成 Values 檔案，或改善現有 Chart 結構時觸發。

## 使用步驟

1. 建立標準 Helm Chart 目錄結構
2. 撰寫 Chart.yaml 與 values.yaml
3. 定義 _helpers.tpl 中的可重用模板助手
4. 撰寫 deployment.yaml、service.yaml、ingress.yaml 等模板
5. 生成環境特定的 values-staging.yaml 與 values-production.yaml
6. 驗證所有 `{{ .Values.X }}` 引用均存在於 values.yaml

## 規則

### 必須
- 所有可配置值放在 values.yaml，模板中不硬編碼
- 使用 _helpers.tpl 處理所有重複標籤區塊
- 每個 Deployment 模板包含 readinessProbe 與 livenessProbe
- 設定 resources.requests 與 resources.limits
- Ingress、HPA、PDB 使用 `if .Values.X.enabled` 條件守護

### 禁止
- 在模板中硬編碼映像標籤、主機名稱或憑證
- 在 values.yaml 中以明文存儲 Secret
- 省略 .helmignore
- 建立沒有資源限制的 Chart
- 在 templates 目錄中使用 `kind: List` 或原始 manifest

## 範例

### 正確用法

使用者：「為我的 Go API 服務建立 Helm Chart。」

生成完整 Chart 結構，_helpers.tpl 定義標準標籤，deployment.yaml 引用 `{{ .Values.image.repository }}:{{ .Values.image.tag }}`，包含 readiness/liveness probe，資源限制，非 root 安全上下文，HPA 以條件守護，以及獨立的 values-staging.yaml 與 values-production.yaml。

### 錯誤用法

僅生成硬編碼 `image: myapp:latest` 的靜態 deployment.yaml，無 values.yaml、無 helpers、無資源限制、無探針。
