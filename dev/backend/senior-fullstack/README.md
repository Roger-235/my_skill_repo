# senior-fullstack

扮演資深全端工程師角色，負責從資料庫到 UI 的完整功能交付，確保端對端型別安全與跨層一致性。

## 用途

以資深全端工程師視角擁有整個垂直切片：schema 設計、API 層、客戶端資料層、UI 元件，一次性交付完整且類型安全的功能。

## 觸發方式

- 「全端開發」、「前後端整合」、「端對端功能」、「全端架構」
- fullstack feature, end-to-end implementation, build full feature
- tRPC, Next.js full-stack, SvelteKit, monorepo feature, type-safe API
- Nuxt full-stack, Remix, shared types, OpenAPI codegen

**不觸發：** 純後端（用 `senior-backend`）、純 UI（用 `senior-frontend`）、資料工程。

## 使用步驟

1. 分解功能為資料層、API 層、UI 層三個部分；識別跨層必須一致的共享型別
2. 設計資料模型與遷移腳本；識別 UI 需要哪些資料來驅動其狀態
3. 定義 API 合約與共享型別；優先使用 tRPC 程序或 OpenAPI 規格自動生成客戶端型別
4. 實作服務端（業務邏輯、驗證、錯誤處理，遵循 `senior-backend` 模式）
5. 實作客戶端資料層（API 客戶端、React Query/SWR 快取策略、SSR/SSG 資料擷取）
6. 實作 UI 層（元件、表單、樂觀更新，遵循 `senior-frontend` 模式）
7. 確保端對端型別安全（Zod schema 共享、API 邊界無 `any` 強制轉型）
8. 處理橫切關注點（骨架載入、錯誤邊界、Toast 通知、表單驗證回饋）
9. 跨層撰寫測試（服務邏輯單元測試 + API 整合測試 + UI 元件測試）
10. 審查層間一致性（DB 欄位名稱 → API 欄位名稱 → UI 變數名稱 → 顯示標籤）

## 規則

### 必須
- 共享型別 / schema 必須有單一來源（如 `packages/shared` 或 `lib/types`）
- 伺服器端用相同 schema 進行執行時期驗證與客戶端型別推導
- UI 必須處理所有 API 狀態：loading、error、empty、populated
- 樂觀更新必須在 API 錯誤時復原
- 絕不向客戶端 UI 暴露內部伺服器錯誤（顯示通用的面向使用者訊息）

### 禁止
- 將 API 回應強制轉型為 `any` 或 `unknown` 而不進行執行時期驗證
- 在伺服器和客戶端分別重複定義型別——從單一來源共享
- 在 UI 元件中實作業務邏輯——委派給伺服器動作或 API 呼叫
- 用客戶端導航隱藏未授權頁面（必須在伺服器端強制認證）
- 回傳分頁資料時不附帶下一頁所需的游標 / 偏移量元資料

## 範例

### 正確用法

```typescript
// lib/schemas/user.ts — 伺服器與客戶端共享（單一事實來源）
export const createUserSchema = z.object({
  email: z.string().email(),
  name: z.string().min(2).max(100),
});
export type CreateUserInput = z.infer<typeof createUserSchema>;

// tRPC 路由器：使用共享 schema 進行執行時期驗證
create: protectedProcedure.input(createUserSchema).mutation(
  async ({ input, ctx }) => userService.create(input, ctx.userId)
);

// React 元件：型別從 tRPC 推斷，無需手動定義
const onSubmit = (data: CreateUserInput) => mutate(data);
```

### 錯誤用法

```typescript
// 伺服器不驗證，暴露所有 DB 欄位
app.post('/users', (req, res) => res.json(await db.createUser(req.body)));

// 客戶端強制轉型為 any，失去所有型別安全
const user = (await response.json()) as any;
setUser(user.id); // 可能是 undefined，編譯時無錯誤
```

錯誤原因：無共享 schema，伺服器與客戶端型別可能無聲地偏離。客戶端轉型為 `any` 失去所有型別安全。
