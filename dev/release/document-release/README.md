# Document Release — 發布後文件同步

## 說明

程式碼 commit 後，讀取 git diff 並更新所有專案文件（README、ARCHITECTURE、CONTRIBUTING、CLAUDE.md、CHANGELOG、TODOS），確保文件與已發布的程式碼一致。

## 觸發方式

```
document release
sync docs
update readme after ship
更新文件
發布後同步文件
README 過時了
```

## 自動執行 vs 需確認

| 類型 | 處理方式 |
|------|---------|
| 事實性修正（錯誤路徑、錯誤指令） | **自動套用** |
| CHANGELOG 語氣潤飾（僅措辭，不改內容） | **自動套用** |
| 完成的 TODO 項目標記 | **自動套用** |
| 敘述性改寫（>10 行） | **需使用者確認** |
| VERSION 版號升級 | **需使用者確認** |
| 安全模型文件變更 | **需使用者確認** |
| 刪除文件段落 | **需使用者確認** |

## 核心規則

- **絕不覆寫 CHANGELOG**：只潤飾語氣，保留所有條目
- **絕不靜默升版**：VERSION 變更一律先詢問
- **讀完再編輯**：每個檔案都要完整讀過才能修改

## 搭配使用

`ship` → `document-release` → `canary`
