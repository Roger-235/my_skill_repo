# epic-design

扮演頂尖 UI/UX 設計師兼動態工程師角色，打造視覺震撼的介面：電影級動畫、微互動、玻璃擬態、神經擬態、3D 變換與進階 CSS/Canvas 特效。

## 用途

將普通網頁變成令人難忘的視覺體驗——從色彩語言、動態編排到粒子系統，完整實作得獎級 UI。

## 觸發方式

- 「炫酷設計」、「動畫效果」、「視覺衝擊」、「沉浸式體驗」、「高端 UI」
- epic design, stunning UI, cinematic animation, glassmorphism, neumorphism
- 3D effect, particle system, scroll animation, parallax, motion design, award-winning UI

**不觸發：** 簡單 CRUD 頁面、無障礙優先場景（重動畫可能傷害使用者）、低端裝置效能受限環境。

## 使用步驟

1. 定義視覺語言（色板、字型、美學風格：黑色奢華 / 霓虹賽博龐克 / 有機柔性 UI）
2. 設計動態編排（入場順序、緩動曲線、時間表）；詳見 [motion-principles.md](./motion-principles.md)
3. 建立語意 HTML 結構基底（漸進增強，無動畫時亦可正常運作）
4. 實作基礎視覺特效（漸層、陰影、`backdrop-filter`）；詳見 [visual-effects-reference.md](./visual-effects-reference.md)
5. 加入入場動畫（CSS `@keyframes` + Intersection Observer）
6. 加入捲動驅動互動（Scroll-driven Animations API）
7. 實作微互動（按鈕漣漪、磁性 hover、游標追蹤、3D 卡片傾斜）；詳見 [micro-interactions.md](./micro-interactions.md)
8. 加入粒子 / Canvas 層（如需要）；詳見 [canvas-particles.md](./canvas-particles.md)
9. 套用 3D CSS 變換（`perspective`、`rotateX/Y/Z`、`translateZ`、`preserve-3d`）
10. 效能審查（在目標裝置上驗證 60fps）
11. 無障礙防護（`prefers-reduced-motion` 包裝所有非必要動畫）
12. 最終潤色（骨架載入、頁面轉場、自訂游標）

## 規則

### 必須
- 所有非必要動畫必須有 `prefers-reduced-motion` 靜態退路
- 僅在熱路徑中動畫 `transform` 和 `opacity`，絕不動畫 `width`/`height`/`margin`/`color`
- 用 `requestAnimationFrame` 驅動所有 JS 動畫，不用 `setInterval`
- 交付前用 DevTools Performance 面板驗證目標裝置 60fps
- 進場動畫的延遲增量 ≤ 80ms，保持流暢感
- 所有文字在動態背景上仍須保持 ≥ 4.5:1 對比度

### 禁止
- 同時可見超過 2–3 個 `backdrop-filter` 元素（GPU 成本極高）
- 直接動畫 `box-shadow`（改用偽元素 opacity 控制）
- 未取得明確同意就引入 Three.js 或 GSAP（bundle 超過 600KB）
- 為保留視覺美感而移除焦點指示器（應改用符合設計的焦點樣式）
- 產生可能引發光敏性癲癇的閃爍效果（> 3 次/秒）
- 使用自動播放視頻或循環 GIF 作為背景而不提供暫停控制

## 範例

### 正確用法

```css
/* 玻璃擬態卡片，僅動畫 transform + opacity（GPU 安全） */
.glass-card {
  background: rgba(255, 255, 255, 0.08);
  backdrop-filter: blur(20px) saturate(180%);
  opacity: 0;
  transform: translateY(24px);
  animation: cardEntrance 0.6s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
}

@media (prefers-reduced-motion: reduce) {
  .glass-card { animation: none; opacity: 1; transform: none; }
}
```

```js
// 3D 卡片傾斜——僅使用 GPU transform
card.addEventListener('mousemove', (e) => {
  const { left, top, width, height } = card.getBoundingClientRect();
  const x = (e.clientX - left) / width - 0.5;
  const y = (e.clientY - top) / height - 0.5;
  card.style.transform = `perspective(600px) rotateY(${x * 12}deg) rotateX(${-y * 12}deg)`;
});
```

### 錯誤用法

```js
// 在迴圈中動畫 width 和 marginTop，使用 setTimeout
function animate() {
  el.style.width = (parseFloat(el.style.width) + 1) + 'px';
  el.style.marginTop = (parseFloat(el.style.marginTop) - 0.5) + 'px';
  setTimeout(animate, 16); // 每幀觸發 layout reflow
}
```

此做法每幀都觸發 layout reflow，使用 `setTimeout` 而非 `requestAnimationFrame`，沒有 reduced-motion 檢查，任何裝置都會掉幀。

---

參考文件：
- [motion-principles.md](./motion-principles.md) — 緩動曲線、時間比例、交錯模式、捲動驅動動畫
- [visual-effects-reference.md](./visual-effects-reference.md) — 玻璃擬態、神經擬態、極光漸層、雜訊紋理
- [micro-interactions.md](./micro-interactions.md) — 按鈕漣漪、磁性 hover、游標追蹤、骨架載入器
- [canvas-particles.md](./canvas-particles.md) — 輕量粒子系統、連線效果、滑鼠排斥、效能指引
