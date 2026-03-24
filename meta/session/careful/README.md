# Careful — 破壞性指令安全護欄

## 說明

啟動 Session 級別的安全護欄，在執行任何破壞性或難以還原的 Bash 指令前暫停並要求使用者明確確認。

## 觸發方式

```
careful
careful mode
開啟安全警告
小心模式
guard mode
```

## 攔截的指令類型

| 類型 | 範例 |
|------|------|
| 遞迴刪除 | `rm -rf`、`rm -r` |
| 資料庫摧毀 | `DROP TABLE`、`TRUNCATE`、`DROP DATABASE` |
| Git 歷史覆寫 | `git push --force`、`git reset --hard`、`git rebase -i` |
| Kubernetes 刪除 | `kubectl delete`、`kubectl drain` |
| Docker 清除 | `docker system prune`、`docker rm -f` |
| 強制終止程序 | `kill -9`、`pkill -f` |

**安全例外**：build artifact 目錄（`node_modules`、`.next`、`dist`、`__pycache__`、`coverage` 等）不觸發警告。

## 使用情境

- 操作生產環境前開啟
- Debug 過程中防止誤刪檔案
- 搭配 `freeze` 使用可獲得最大保護（或直接用 `guard`）

## 注意事項

- 護欄僅攔截 Edit/Write/Bash 工具呼叫，不能阻止使用者自行在終端機執行指令
- Session 結束後自動停用
- 使用者輸入 "disable careful" 可手動關閉
