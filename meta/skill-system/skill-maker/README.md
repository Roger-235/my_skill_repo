# Skill Maker — Skill 生成標準

管理所有 skill 的生成流程，確保每個產出的 skill 文件都符合結構、品質與資安標準。

## 功能

- 引導用戶逐步定義 skill 的 7 個必要區塊
- 自動搜尋同類 skill 作為參考並提案補強內容
- 執行 20 項自我審核，失敗項目自動修正，循環直到全部通過
- 涵蓋資安稽核（prompt injection、credential 洩漏、過度授權、shell injection）

## 觸發時機

- 「建立一個 skill」、「寫一個 skill」、「幫我做一個 skill 文件」
- create a skill、write a skill、make a skill、build a skill

**不觸發**：編輯現有非 skill 的 markdown 文件、撰寫文件或 README、純概念討論。

## 生成流程

1. 詢問用戶 7 個區塊的內容（Purpose、Trigger、Prerequisites、Steps、Output Format、Rules、Examples）
2. 搜尋網路上的同類 skill，提案補強內容，等待用戶逐條確認
3. 確認所有決策後寫入文件
4. 執行 20 項自我審核，修正失敗項目，重複直到全部通過

## 產出位置

`.claude/skill/<skill-name>.md`

## 自我審核涵蓋

- 結構完整性（7 個必要區塊）
- Frontmatter 規範（name、description 格式）
- 步驟格式（動詞開頭、含預期結果）
- 規則可測試性（Must/Never 分類）
- 範例完整性（Good/Bad 對照）
- 資安合規（無 credentials、$ARGUMENTS 驗證、不過度授權、prompt injection 防護）
