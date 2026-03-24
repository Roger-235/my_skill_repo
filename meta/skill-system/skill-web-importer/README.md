# skill-web-importer

從網路匯入 Skill 的強制安全閘道。每次 Claude 從網路（GitHub、ClawHub、任何平台）找到 Skill 並準備建立本地版本時，必須先通過此閘道。

## 為什麼需要這個 Skill

2026 年 2 月 Snyk 的 ToxicSkills 研究掃描了 3,984 個公開 AI Agent Skill：

- **36%** 含有 Prompt Injection 攻擊
- **13.4%（534 個）** 含有嚴重安全漏洞
- **91%** 的惡意 Skill 同時結合 Prompt Injection 與傳統惡意程式
- 已確認的攻擊手法包括：AWS 憑證竊取、後門安裝、記憶體污染

沒有這個閘道，從網路匯入的 Skill 可能直接將憑證竊取程式安裝進你的 Skill 庫。

## 適用場景

| 情境 | 使用此 Skill |
|------|------------|
| 從 GitHub 找到 Skill 想匯入 | ✅ 必須先執行 |
| 從 ClawHub / skills.sh 下載 | ✅ 必須先執行 |
| 看到別人分享的 SKILL.md 連結 | ✅ 必須先執行 |
| 從零開始自己寫一個新 Skill | ❌ 不需要（用 skill-maker 直接建立） |
| 已安裝的本地 Skill 靜態掃描 | ❌ 改用 skill-security-auditor |

## 與 skill-security-auditor 的差異

| | skill-web-importer | skill-security-auditor |
|--|-------------------|----------------------|
| **時機** | 建立前（從網路取得內容時） | 建立後（本地靜態掃描） |
| **方式** | LLM 分析 + 來源信譽評估 | Python 腳本靜態分析 |
| **需要工具** | 否（純 LLM） | Python 3.x |
| **涵蓋** | 來源信譽、8 類威脅、結構紅旗 | 程式碼模式、檔案系統、相依性 |

## 判決機制

```
✅ PASS  — 0 CRITICAL, 0 HIGH → 直接進入 skill-maker
⚠️ WARN  — ≥1 HIGH, 0 CRITICAL → 顯示報告，等待使用者輸入「approve import」
❌ FAIL  — ≥1 CRITICAL 或來源評分 FAIL → 停止，不進入 skill-maker
```

## 8 類威脅分類（ToxicSkills 2026）

1. **Prompt Injection**（CRITICAL）— 覆寫系統提示、角色劫持、隱藏 Unicode
2. **惡意程式碼**（CRITICAL）— eval/exec、base64 混淆 curl、自我修改
3. **可疑下載**（CRITICAL）— 非官方來源的二進位、密碼壓縮包
4. **憑證處理**（HIGH）— 讀取 `~/.aws`、`~/.ssh`、`$API_KEY` 再外傳
5. **硬編碼密鑰**（HIGH）— SKILL.md 內嵌入 API Key、Token、私鑰
6. **第三方內容暴露**（MEDIUM）— 執行時抓取外部 URL，形成間接注入面
7. **不可驗證相依性**（MEDIUM）— `pip install` 在步驟中、未固定版本、仿冒套件
8. **直接金融操作**（MEDIUM）— 付款 API、加密貨幣錢包操作，缺少確認步驟

## 結構紅旗（Rule of Two）

若 Skill 同時滿足以下三個條件，自動判為 FAIL：
1. 讀取不可信的外部內容
2. 存取敏感檔案（`.env`、`~/.aws`、`~/.ssh`）
3. 發出對外網路請求

單一任何條件不會直接 FAIL，但三者同時出現代表攻擊者可完整控制「輸入 → 讀取 → 外傳」鏈路。

## 已知惡意帳號（ToxicSkills 2026）

任何來自以下帳號的 Skill 自動判為 **FAIL**，無論內容為何：
- `zaycv`、`Aslaep123`、`pepe276`、`moonshine-100rze`

## 管線位置

```
[WebFetch 網路研究]
        ↓
skill-web-importer  ← 你在這裡（PASS 才能繼續）
        ↓
  skill-maker
        ↓
  skill-audit
        ↓
skill-readme-sync
        ↓
skill-index-sync
```

## 參考資料

- 威脅模式詳細表：[ref/web-threat-patterns.md](ref/web-threat-patterns.md)
- Snyk ToxicSkills Study: https://snyk.io/blog/toxicskills-malicious-ai-agent-skills-clawhub/
- Arxiv 2601.17548: Prompt Injection Attacks on Agentic Coding Assistants
