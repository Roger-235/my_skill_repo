# Micro-Interactions Reference

## Button Ripple Effect

```css
.btn {
  position: relative;
  overflow: hidden;
  cursor: pointer;
}

.ripple {
  position: absolute;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.3);
  transform: scale(0);
  animation: rippleOut 600ms ease-out forwards;
  pointer-events: none;
}

@keyframes rippleOut {
  to { transform: scale(4); opacity: 0; }
}
```

```js
document.querySelectorAll('.btn').forEach(btn => {
  btn.addEventListener('click', (e) => {
    const rect = btn.getBoundingClientRect();
    const size = Math.max(rect.width, rect.height);
    const ripple = document.createElement('span');
    ripple.className = 'ripple';
    ripple.style.cssText = `
      width: ${size}px; height: ${size}px;
      left: ${e.clientX - rect.left - size / 2}px;
      top:  ${e.clientY - rect.top  - size / 2}px;
    `;
    btn.appendChild(ripple);
    ripple.addEventListener('animationend', () => ripple.remove());
  });
});
```

## Magnetic Hover Effect

```js
// Element is slightly attracted to cursor on hover
function initMagnetic(selector, strength = 0.4) {
  document.querySelectorAll(selector).forEach(el => {
    el.addEventListener('mousemove', (e) => {
      const rect = el.getBoundingClientRect();
      const cx = rect.left + rect.width / 2;
      const cy = rect.top + rect.height / 2;
      const dx = (e.clientX - cx) * strength;
      const dy = (e.clientY - cy) * strength;
      el.style.transform = `translate(${dx}px, ${dy}px)`;
    });
    el.addEventListener('mouseleave', () => {
      el.style.transform = 'translate(0, 0)';
      el.style.transition = 'transform 0.5s cubic-bezier(0.34,1.56,0.64,1)';
    });
    el.addEventListener('mouseenter', () => {
      el.style.transition = 'transform 0.1s ease-out';
    });
  });
}
```

## Custom Cursor Follower

```js
const cursor = document.querySelector('.cursor-follower');
let mouseX = 0, mouseY = 0;
let curX = 0, curY = 0;

document.addEventListener('mousemove', (e) => {
  mouseX = e.clientX;
  mouseY = e.clientY;
});

function animateCursor() {
  // Lerp for smooth follow — adjust 0.12 for lag
  curX += (mouseX - curX) * 0.12;
  curY += (mouseY - curY) * 0.12;
  cursor.style.transform = `translate(${curX}px, ${curY}px)`;
  requestAnimationFrame(animateCursor);
}
animateCursor();

// Scale up on hoverable elements
document.querySelectorAll('a, button, [data-cursor-grow]').forEach(el => {
  el.addEventListener('mouseenter', () => cursor.classList.add('grow'));
  el.addEventListener('mouseleave', () => cursor.classList.remove('grow'));
});
```

```css
.cursor-follower {
  position: fixed;
  top: -20px; left: -20px;
  width: 40px; height: 40px;
  border: 2px solid rgba(167, 139, 250, 0.8);
  border-radius: 50%;
  pointer-events: none;
  z-index: 9999;
  transition: width 0.2s, height 0.2s, border-color 0.2s;
}
.cursor-follower.grow {
  width: 60px; height: 60px;
  border-color: rgba(167, 139, 250, 0.4);
  background: rgba(167, 139, 250, 0.08);
}
```

## Skeleton Loader

```css
.skeleton {
  background: linear-gradient(
    90deg,
    rgba(255,255,255,0.05) 25%,
    rgba(255,255,255,0.12) 50%,
    rgba(255,255,255,0.05) 75%
  );
  background-size: 200% 100%;
  animation: shimmer 1.5s infinite;
  border-radius: 6px;
}

@keyframes shimmer {
  0%   { background-position: 200% 0; }
  100% { background-position: -200% 0; }
}

@media (prefers-reduced-motion: reduce) {
  .skeleton { animation: none; opacity: 0.5; }
}
```

## Number Counter Animation

```js
function animateCounter(el, from, to, duration = 1000) {
  const start = performance.now();
  const formatter = new Intl.NumberFormat();

  function tick(now) {
    const elapsed = now - start;
    const progress = Math.min(elapsed / duration, 1);
    // Ease out cubic
    const eased = 1 - Math.pow(1 - progress, 3);
    el.textContent = formatter.format(Math.round(from + (to - from) * eased));
    if (progress < 1) requestAnimationFrame(tick);
  }
  requestAnimationFrame(tick);
}
```

## Text Scramble Effect

```js
class TextScramble {
  constructor(el) {
    this.el = el;
    this.chars = '!<>-_\\/[]{}—=+*^?#';
    this.queue = [];
  }

  setText(newText) {
    const oldText = this.el.innerText;
    const length = Math.max(oldText.length, newText.length);
    return new Promise(resolve => {
      this.queue = Array.from({ length }, (_, i) => ({
        from: oldText[i] || '',
        to: newText[i] || '',
        start: Math.floor(Math.random() * 10),
        end: Math.floor(Math.random() * 10) + 10,
        char: ''
      }));
      cancelAnimationFrame(this.frameReq);
      this.frame = 0;
      this.resolve = resolve;
      this.update();
    });
  }

  update() {
    let output = '', complete = 0;
    this.queue.forEach(item => {
      if (this.frame >= item.end) {
        complete++;
        output += item.to;
      } else if (this.frame >= item.start) {
        item.char = this.chars[Math.floor(Math.random() * this.chars.length)];
        output += `<span class="dud">${item.char}</span>`;
      } else {
        output += item.from;
      }
    });
    this.el.innerHTML = output;
    if (complete === this.queue.length) {
      this.resolve();
    } else {
      this.frameReq = requestAnimationFrame(() => { this.frame++; this.update(); });
    }
  }
}
```
