# 語言預設規範

當專案未提供自定義規範時，使用以下各語言的預設值。

---

## TypeScript

### 命名規範
| 項目 | 格式 | 範例 |
|------|------|------|
| 變數、函式、方法 | camelCase | `getUserById`, `isActive` |
| 類別、介面、型別、列舉 | PascalCase | `UserService`, `ApiResponse` |
| 常數（模組層級不可變） | SCREAMING_SNAKE_CASE | `MAX_RETRY_COUNT` |
| 檔案（元件） | PascalCase.tsx | `UserCard.tsx` |
| 檔案（非元件） | kebab-case.ts | `auth-utils.ts` |
| 私有成員 | camelCase（不加底線） | `this.userId`（非 `this._userId`）|

### 型別規範
| 規則 | 說明 |
|------|------|
| 禁用 `any` | 改用 `unknown` + type guard 或具體型別 |
| 函式必須有回傳型別標注 | `function foo(): string` |
| 優先用 `interface` 描述物件形狀 | 用 `type` 處理聯合型別 |
| 禁用 `as unknown as T` 雙重斷言 | 需找根本原因 |

### 匯入順序
```typescript
// 1. Node 內建模組
import fs from 'fs';
// 2. 第三方套件
import express from 'express';
// 3. 本地模組（絕對路徑）
import { UserService } from '@/services/user';
// 4. 本地模組（相對路徑）
import { validate } from './utils';
```

### 格式
| 項目 | 值 |
|------|-----|
| 縮排 | 2 空格 |
| 行寬上限 | 100 字元 |
| 分號 | 必須加 |
| 引號 | 單引號（`'`） |

---

## Python

### 命名規範
| 項目 | 格式 | 範例 |
|------|------|------|
| 變數、函式、方法、模組 | snake_case | `get_user_by_id`, `is_active` |
| 類別 | PascalCase | `UserService`, `ApiResponse` |
| 常數（模組層級） | UPPER_CASE | `MAX_RETRY_COUNT` |
| 私有成員 | `_single_underscore` | `self._user_id` |
| 「不對外」的名稱 | `__double_underscore` | `__internal_cache` |

### 型別規範
| 規則 | 說明 |
|------|------|
| 所有函式參數與回傳值必須有 type hint | `def get_user(user_id: int) -> User:` |
| 使用 `|` 或 `Optional` 標注可為 None 的值 | `name: str \| None` |
| 禁用裸露的 `except:` | 至少寫 `except Exception as e:` |
| 避免 `type: ignore` 除非有說明注解 | `# type: ignore[attr-defined]` |

### 匯入順序（isort 標準）
```python
# 1. 標準庫
import os
import sys
# 2. 第三方套件
import fastapi
import pydantic
# 3. 本地模組
from app.services import user_service
from .utils import validate
```

### 格式
| 項目 | 值 |
|------|-----|
| 縮排 | 4 空格 |
| 行寬上限 | 88 字元（black 預設）|
| 字串引號 | 雙引號（black 預設）|
| 空行 | 頂層函式/類別間 2 行；方法間 1 行 |

---

## Go

### 命名規範
| 項目 | 格式 | 範例 |
|------|------|------|
| 對外（exported）識別符 | PascalCase | `UserService`, `GetByID` |
| 對內（unexported）識別符 | camelCase | `userService`, `getByID` |
| 縮寫詞全大寫 | `ID`, `URL`, `HTTP` | `userID`（非 `userId`）|
| 短作用域變數 | 單字母或極短 | `i`, `v`, `err`, `ctx` |
| 常數 | PascalCase（對外）/ camelCase（對內）| `MaxRetry`, `defaultTimeout` |

### 錯誤處理
| 規則 | 說明 |
|------|------|
| 不可丟棄回傳的 error | 禁止 `result, _ := foo()` |
| 用 `fmt.Errorf("context: %w", err)` 包裝錯誤 | 保留原始錯誤鏈 |
| 用 `errors.Is` / `errors.As` 檢查錯誤類型 | 不直接比較 `err.Error()` 字串 |

### 並發
| 規則 | 說明 |
|------|------|
| 每個 goroutine 必須有明確退出條件 | context 取消、channel 關閉或 WaitGroup |
| channel 只由生產者端關閉 | 消費者不關閉 channel |
| 共享狀態必須有同步保護 | `sync.Mutex`、channel 或 `sync/atomic` |

### 匯入順序（goimports 標準）
```go
import (
    // 1. 標準庫
    "context"
    "fmt"

    // 2. 第三方套件
    "github.com/gin-gonic/gin"

    // 3. 本地模組
    "myproject/internal/user"
)
```

### 格式
| 項目 | 值 |
|------|-----|
| 縮排 | tab（gofmt 強制）|
| 行寬 | 無強制限制，慣例 ≤ 120 字元 |
| `gofmt` | 所有代碼必須通過 `gofmt` 格式化 |
