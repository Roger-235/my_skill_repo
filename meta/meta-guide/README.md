# Meta Guide — Meta Skill 導覽

說明 meta skill 系統如何運作，以及各 skill 的觸發時機與職責。

## 使用時機

詢問「有哪些 meta skill」、「skill 系統怎麼運作」、「meta skill 導覽」時觸發。

## Skill 一覽

| Skill | 職責 | 觸發方式 |
|-------|------|---------|
| `skill-maker` | 生成新 skill（SKILL.md + README） | 明確：「make a skill for X」 |
| `skill-audit` | 稽核新 skill（結構 + 衝突 + 重複 + 資安） | **自動**：skill-maker 完成後 |
| `skill-readme-sync` | 確認 README 與 SKILL.md 同步 | **自動**：每次 SKILL.md 被編輯後 |
| `pre-output-review` | 任何實質輸出前的品質把關 | **自動**：每次輸出前 |

## 完整 Pipeline

```
skill-maker → skill-audit → security-audit（by skill-audit）
                                   ↓
                         每次 SKILL.md 被編輯
                                   ↓
                        skill-readme-sync 自動執行
```

```
每次輸出前 → pre-output-review 自動執行
```
