# Freeze — 編輯範圍鎖定

## 說明

將 Edit 和 Write 工具操作限制在指定目錄內，防止 Debug 或聚焦重構時意外修改到範圍外的程式碼。

## 觸發方式

```
freeze
freeze edits to src/auth/
鎖定編輯範圍
只能改這個目錄
```

## 如何運作

1. 使用者指定目標目錄（路徑會被解析為絕對路徑）
2. 之後所有 Edit / Write 操作都會先確認目標檔案是否在邊界內
3. 邊界外的操作一律攔截並說明原因
4. 使用者輸入 `unfreeze` 或 Session 結束後自動解除

## 使用情境

- Debug 某個模組時防止 scope creep
- 聚焦重構某個目錄時保護其他程式碼
- 搭配 `careful` 使用可獲得最大保護（或直接用 `guard`）

## 重要限制

Freeze **只攔截 Edit/Write 工具**，不攔截 Bash 指令。
`sed`、`awk`、`mv`、`cp` 等 shell 指令仍可修改邊界外的檔案。
這是**意圖護欄**，不是安全邊界。

## 解除方式

```
unfreeze
```
