# stripe-integration-expert

扮演 Stripe 整合專家角色，實作生產級付款流程：一次性付款、訂閱計費、Webhook 處理、客戶入口網站與 Stripe Connect。

## 用途

設計並實作安全、具冪等性的 Stripe 付款整合，涵蓋 PaymentIntent、Checkout Session、訂閱生命週期、Webhook 驗證與帳單入口網站。

## 觸發方式

- 「付款整合」、「訂閱計費」、「Stripe 收款」、「Stripe 串接」
- Stripe integration, payment processing, subscription billing, Stripe webhook
- checkout session, PaymentIntent, customer portal, metered billing, Stripe Connect
- 退款、爭議、比例分攤、發票客製化

**不觸發：** 非 Stripe 付款提供商（PayPal、Braintree）、純前端 UI、財務報表系統。

## 使用步驟

1. **選擇整合路徑**：一次性付款 → Checkout Session（託管）或 PaymentIntent（自訂 UI）；訂閱 → Checkout 訂閱模式；市集 → Stripe Connect
2. **伺服器端初始化 Stripe 客戶端**——API key 從環境變數讀取；絕不硬式編碼或暴露密鑰
3. **建立付款流程**——Checkout Session：伺服器端建立後重新導向；PaymentIntent：伺服器端建立後將 `client_secret` 傳給前端
4. **實作冪等性**——所有寫入操作傳遞 `idempotencyKey`；防止網路重試時重複收費
5. **設置 Webhook 端點**——使用原始請求主體驗證簽名；立即回傳 200；非同步處理事件；處理關鍵事件類型
6. **實作訂閱生命週期**——試用期、升降級（比例分攤）、取消（期末 vs 立即）、重新啟用、付款失敗催收
7. **加入 Customer Portal**——伺服器端建立計費入口 Session；重新導向使用者至入口 URL
8. **在資料庫中儲存 Stripe ID**——在使用者 / 帳號記錄上持久化 `customerId`、`subscriptionId`、`priceId`
9. **優雅地處理付款失敗**——在 `invoice.payment_failed` 時通知使用者，提供更新付款方式連結
10. **使用 Stripe CLI 和測試卡進行測試**——`stripe listen --forward-to` 用於本地 Webhook 測試

## 規則

### 必須
- 始終驗證 Webhook 簽名——使用原始請求主體（非解析後的 JSON）
- 在任何訂閱建立前，在使用者記錄上儲存 Stripe `customerId`
- 在所有 Checkout Session 和 PaymentIntent 建立呼叫上傳遞冪等性金鑰
- 開發時使用測試模式（`sk_test_...`）；絕不在測試環境中使用正式金鑰
- 以使用者通知和重試流程處理 `invoice.payment_failed`
- 訂閱變更時進行比例分攤（除非產品明確要求不分攤）

### 禁止
- 記錄或儲存原始卡號、CVV 或完整 PAN
- 在 HTTP 處理器中同步處理 Webhook 事件——排隊進行非同步處理
- 在未先驗證簽名的情況下信任 Webhook 事件資料
- 硬式編碼價格或金額——始終參考 Stripe Price ID
- 在客戶端程式碼或版本控制中暴露密鑰 API
- 在未提供「在計費週期結束時取消」選項的情況下立即取消訂閱

## 範例

### 正確用法

```typescript
// 伺服器端建立訂閱 Checkout Session（含冪等性金鑰）
const session = await stripe.checkout.sessions.create({
  mode: 'subscription',
  line_items: [{ price: process.env.STRIPE_PRICE_ID, quantity: 1 }],
  customer: user.stripeCustomerId,
  success_url: `${BASE_URL}/success?session_id={CHECKOUT_SESSION_ID}`,
  cancel_url: `${BASE_URL}/pricing`,
}, { idempotencyKey: `checkout-${user.id}-${Date.now()}` });

// Webhook：驗證簽名，立即確認，非同步處理
app.post('/webhook', express.raw({ type: 'application/json' }), (req, res) => {
  const event = stripe.webhooks.constructEvent(
    req.body, req.headers['stripe-signature'], process.env.STRIPE_WEBHOOK_SECRET
  );
  res.json({ received: true });
  processWebhookEvent(event).catch(console.error);
});
```

### 錯誤用法

```js
// 在前端暴露密鑰
const stripe = require('stripe')('sk_live_ACTUAL_SECRET'); // 洩漏至 bundle

// Webhook 不驗證簽名——任何人都可以偽造事件
app.post('/webhook', express.json(), (req, res) => {
  const event = req.body; // 未驗證
  if (event.type === 'payment_intent.succeeded') {
    grantAccess(event.data.object.metadata.userId); // 可被偽造
  }
});
```

錯誤原因：密鑰在前端暴露（任何人可見）。Webhook 事件未驗證——攻擊者可以偽造 `payment_intent.succeeded` 事件，在未付款的情況下獲得存取權。
