# email-template-builder

建立專業的 HTML 和純文字電子郵件範本：響應式佈局、無障礙設計、深色模式支援、變數替換，以及跨客戶端相容性。

## 用途

設計並實作生產就緒的電子郵件範本，使用正確的表格式佈局，在 Gmail、Outlook、Apple Mail 及各主要 ESP 中正確渲染。

## 觸發方式

- 「電子郵件範本」、「HTML 郵件」、「郵件設計」、「交易型郵件」
- email template, HTML email, transactional email, MJML, email builder
- SendGrid template, Mailchimp template, email newsletter, responsive email

**不觸發：** 以程式化方式發送郵件（用 `senior-backend`）、郵件可達性設定（SPF/DKIM/DMARC）。

## 使用步驟

1. 定義範本結構（頁首、內文、CTA、頁尾）
2. 設置外部結構（HTML5 DOCTYPE、meta 標籤、style 區塊）
3. 建立表格佈局（`role="presentation"`，`border=0 cellpadding=0 cellspacing=0`）
4. 實作響應式設計（600px 最大寬度、媒體查詢）
5. 套用深色模式支援（`prefers-color-scheme: dark` 覆蓋）
6. 實作變數替換（ESP 模板語言，含預設值）
7. 設計 CTA 按鈕（TD + A 背景雙重設定，44px 最小觸控面積）
8. 加入預覽文字（隱藏 span，填充至約 100 字元）
9. 生成純文字版本（含完整 URL）
10. 測試渲染（Gmail、Outlook、Apple Mail、深色模式）

## 規則

### 必須
- 所有佈局表格使用 `role="presentation"`
- 為每個 HTML 範本提供純文字版本
- 頁尾包含退訂機制（CAN-SPAM / GDPR 要求）
- 移動端 CTA 最小觸控面積 44×44px

### 禁止
- 在電子郵件佈局中使用 CSS Grid、Flexbox 或 float
- 在 `<td>` 中使用背景圖片而無純色背景色後備
- 在電子郵件範本中使用 JavaScript

## 範例

### 正確用法

```html
<!-- 雙重背景 CTA 按鈕（TD + A，確保 Outlook 相容） -->
<table role="presentation" border="0" cellpadding="0" cellspacing="0"><tr>
  <td bgcolor="#6366f1" style="border-radius:6px;">
    <a href="{{url}}" style="display:inline-block;padding:14px 28px;
       background-color:#6366f1;color:#fff;font-family:Arial,sans-serif;">
      立即查看
    </a>
  </td>
</tr></table>
```

### 錯誤用法

```html
<!-- Flexbox 在 Outlook 中失效 + 無 alt 文字 + 無退訂連結 -->
<div style="display:flex;">
  <img src="logo.png">
  <a href="{{url}}" style="background:#6366f1;">點此</a>
</div>
```
