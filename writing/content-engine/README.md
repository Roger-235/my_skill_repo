# Content Engine — 批量內容生產引擎

從一個核心主題衍生多種平台格式的內容，確保所有格式的事實與核心訊息一致。

## 功能

- 將主題濃縮為一句核心訊息
- 生成多種格式：部落格文章、LinkedIn 貼文、推文串、TL;DR、電子報、FAQ
- 依平台調整語氣與長度（LinkedIn 正式、Twitter/X 輕鬆）
- 跨格式一致性檢查，確保事實不相矛盾

## 觸發時機

- 「內容規劃」、「批量生產內容」、「多格式內容」
- "content plan", "repurpose content", "content strategy"

**不觸發**：撰寫單篇長文時，使用 `article-writing`。

## 使用方法

提供核心主題或來源素材，skill 會先確認核心訊息，再為每種格式定義受眾，分別生成內容後進行一致性檢查。

**輸出格式：**
```
## Content Batch: <主題>

**Core message:** <一句話>

### Blog Post (~800 words)
### LinkedIn Post (~300 words)
### Tweet Thread (5–7 tweets)
### TL;DR (2–3 sentences)
### Email Newsletter (~400 words)
### FAQ (5 questions)
```

## 前置需求

- 一個核心主題或來源素材（草稿、產品公告、研究成果等）
- （選填）目標格式清單與各平台受眾說明
