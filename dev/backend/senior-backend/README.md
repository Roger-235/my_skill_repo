# senior-backend

扮演資深後端工程師角色，設計並實作生產級後端系統：API 合約、資料層、認證授權與服務可靠性。

## 用途

以資深後端工程師視角處理所有後端任務：REST/GraphQL API 設計、資料庫 schema、Repository/Service 分層架構、JWT/OAuth2 認證、速率限制與錯誤處理。

## 觸發方式

- 「後端開發」、「API 設計」、「資料庫設計」、「認證授權」、「服務層架構」
- build API, design endpoint, backend architecture, database schema
- authentication, authorization, REST API, GraphQL, middleware, repository pattern
- rate limiting, error handling, service layer, 後端開發, API 設計

**不觸發：** 純前端 UI（用 `senior-frontend`）、基礎設施配置（用 `docker-patterns`）、資料工程。

## 使用步驟

1. 釐清領域模型（實體、關係、不變量）；定義 DDD 情境的聚合根
2. 設計 API 合約（方法、路徑、請求/回應格式、狀態碼、錯誤信封）
3. 設計資料層（schema、索引、約束條件、正規化層級）
4. 實作 Repository 層（抽象所有 DB 查詢；控制器中不含原始 SQL）
5. 實作 Service 層（業務邏輯，無狀態；輸入在進入前已驗證）
6. 實作 Controller/Handler 層（薄層：解析 → 呼叫服務 → 序列化）
7. 實作認證（JWT RS256、短效 Access Token 15 分鐘 + 7 天 Refresh Token）
8. 實作授權（RBAC/ABAC 中介軟體，在處理器執行前檢查角色）
9. 加入橫切關注點（請求 ID、結構化日誌、速率限制、全域錯誤處理）
10. 撰寫整合測試（完整 HTTP 週期、認證邊界、驗證錯誤）

## 規則

### 必須
- 在邊界驗證所有輸入，絕不信任服務層內的客戶端資料
- 回傳一致的錯誤信封格式：`{ error: { code, message, details? } }`
- 使用參數化查詢或 ORM，絕不拼接 SQL 字串
- 密碼用 bcrypt（cost ≥ 12）或 Argon2id 雜湊，絕不使用 MD5/SHA1
- 在每行日誌記錄請求 ID 以利追蹤
- 驗證錯誤回傳 422，而非 400

### 禁止
- 回傳 stack trace 或內部錯誤訊息給客戶端
- 以純文字或可逆加密儲存密碼
- 在 Controller 中放置業務邏輯或原始查詢
- 在請求執行緒中執行同步 I/O 或 CPU 密集操作（使用 worker / 佇列）
- 信任客戶端提供的 `userId`（必須從已驗證的 token 取得）
- 在 API 回應中暴露資料庫錯誤碼或資料表名稱

## 範例

### 正確用法

```typescript
// Controller 薄層 → 委派給 Service
async function loginHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const { email, password } = loginSchema.parse(req.body); // Zod 驗證
    const tokens = await authService.login(email, password);
    res.status(200).json(tokens);
  } catch (err) { next(err); } // 集中式錯誤處理器接管
}

// Service：業務邏輯
async function login(email: string, password: string) {
  const user = await userRepo.findByEmail(email);
  if (!user) throw new UnauthorizedError('Invalid credentials');
  const valid = await bcrypt.compare(password, user.passwordHash);
  if (!valid) throw new UnauthorizedError('Invalid credentials');
  return tokenService.issueTokenPair(user.id, user.role);
}
```

### 錯誤用法

```js
// SQL 注入 + 明文密碼比對 + 硬編碼 JWT secret + 洩漏完整使用者物件
app.post('/login', async (req, res) => {
  const user = await db.query(`SELECT * FROM users WHERE email = '${req.body.email}'`);
  if (user && user.password === req.body.password) {
    res.json({ token: jwt.sign({ userId: user.id }, 'secret'), user });
  } else {
    res.status(401).json({ error: err.message }); // 洩漏內部錯誤
  }
});
```

錯誤原因：SQL 注入、明文密碼比對、硬式編碼 JWT 密鑰且無過期時間、洩漏完整使用者記錄（包含密碼雜湊）、洩漏內部錯誤訊息。
