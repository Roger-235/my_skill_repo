# accessibility-audit

WCAG 2.2 Level AA 無障礙稽核。檢查四大原則（可感知、可操作、可理解、健壯性），產出含 WCAG 條文 ID、嚴重程度和具體修復建議的違規表格。

## 涵蓋標準

**WCAG 2.2 新增條文（重點檢查）：**
| 條文 | 名稱 | 常見問題 |
|------|------|---------|
| 2.4.11 | Focus Not Obscured | 黏性標頭遮蓋聚焦元素 |
| 2.5.7 | Dragging Movements | 拖曳操作沒有單指針替代方案 |
| 2.5.8 | Target Size | 互動目標小於 24×24 CSS 像素 |
| 3.3.7 | Redundant Entry | 要求使用者重新輸入已提供的資訊 |
| 3.3.8 | Accessible Authentication | 登入需要認知功能測試（如 CAPTCHA）而無替代方案 |

## 色彩對比要求

| 文字類型 | 最低對比度 |
|---------|-----------|
| 一般文字（< 18pt / < 14pt bold） | 4.5:1 |
| 大型文字（≥ 18pt / ≥ 14pt bold） | 3:1 |
| UI 元件 + 焦點指示器 | 3:1 |

## 常見 ARIA 錯誤

```html
<!-- 錯誤：互動元素缺少 role -->
<div onclick="submit()">送出</div>

<!-- 錯誤：aria-hidden 加在可聚焦元素 -->
<button aria-hidden="true" tabindex="0">點我</button>

<!-- 錯誤：動態內容更新沒有 aria-live -->
<div id="status"><!-- JS 更新但沒有宣告 --></div>
```

## 工具整合

```bash
# axe-core CLI
npx axe-core-cli <url> --reporter json

# Lighthouse
npx lighthouse <url> --only-categories=accessibility
```

## 觸發方式

- "accessibility audit"、"WCAG"、"a11y"、"無障礙"
- "screen reader"、"keyboard navigation"、"color contrast"、"ARIA"
