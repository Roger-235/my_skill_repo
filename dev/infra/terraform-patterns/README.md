# terraform-patterns

## 用途

為 AWS、GCP 與 Azure 生成結構完善、可重用的 Terraform 模組與基礎設施即代碼配置，遵循社群最佳實踐。

## 觸發方式

當使用者要求建立 Terraform 配置、以 IaC 佈建雲端基礎設施、撰寫 Terraform 模組，或重構現有 Terraform 程式碼時觸發。

## 使用步驟

1. 確認結構（根模組、可重用模組或環境分離）
2. 撰寫 versions.tf，聲明版本約束
3. 在 variables.tf 中設計帶型別與描述的變數
4. 撰寫 main.tf，使用 locals 保持命名一致
5. 撰寫 outputs.tf，匯出有意義的值
6. 配置遠端 backend
7. 應用安全強化（加密、IAM 最小權限、無公開暴露）

## 規則

### 必須
- 在 versions.tf 中聲明 required_version 與所有 required_providers 的版本約束
- 每個 variable 與 output 區塊加入 description
- 使用 locals 處理重複的命名/標籤模式
- 所有儲存資源預設啟用靜態加密
- 包含 tags/labels 變數以統一資源標記

### 禁止
- 在資源區塊中硬編碼憑證、帳號 ID 或區域名稱
- 使用無約束的 provider 版本要求（`>= 0`）
- 在生產資源上建立 `"Action": "*"` IAM 策略
- 未經明確使用者要求生成 terraform destroy 指令
- 對有唯一性的資源使用 count（應改用 for_each 搭配 map）

## 範例

### 正確用法

使用者：「為 AWS RDS PostgreSQL 撰寫 Terraform。」

生成 versions.tf（`aws ~> 5.0`）、variables.tf（帶型別的 instance class、db name、username 變數，無密碼預設值）、main.tf（`storage_encrypted = true`、`publicly_accessible = false`、`deletion_protection = true`）、outputs.tf（endpoint 與 port）。

### 錯誤用法

生成單一 main.tf，硬編碼 `username = "admin"`、`password = "secret123"`、`publicly_accessible = true`，無加密、無版本約束、無輸出。
