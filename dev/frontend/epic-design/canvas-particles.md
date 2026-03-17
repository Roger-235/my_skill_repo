# Canvas Particle Systems

## Lightweight Particle System (no dependencies)

```js
class ParticleSystem {
  constructor(canvas, options = {}) {
    this.canvas = canvas;
    this.ctx = canvas.getContext('2d');
    this.particles = [];
    this.options = {
      count: options.count ?? 80,
      color: options.color ?? '167, 139, 250',
      maxRadius: options.maxRadius ?? 3,
      speed: options.speed ?? 0.5,
      connectDistance: options.connectDistance ?? 120,
      connectLines: options.connectLines ?? true,
      mouseRepulse: options.mouseRepulse ?? true,
      repulseRadius: options.repulseRadius ?? 100,
    };
    this.mouse = { x: -9999, y: -9999 };
    this.raf = null;
    this.init();
  }

  init() {
    this.resize();
    window.addEventListener('resize', () => this.resize());
    if (this.options.mouseRepulse) {
      this.canvas.addEventListener('mousemove', e => {
        const r = this.canvas.getBoundingClientRect();
        this.mouse.x = e.clientX - r.left;
        this.mouse.y = e.clientY - r.top;
      });
      this.canvas.addEventListener('mouseleave', () => {
        this.mouse = { x: -9999, y: -9999 };
      });
    }
    for (let i = 0; i < this.options.count; i++) {
      this.particles.push(this.createParticle());
    }
    this.raf = requestAnimationFrame(() => this.loop());
  }

  resize() {
    this.canvas.width  = this.canvas.offsetWidth;
    this.canvas.height = this.canvas.offsetHeight;
  }

  createParticle() {
    const angle = Math.random() * Math.PI * 2;
    const speed = (Math.random() * 0.5 + 0.1) * this.options.speed;
    return {
      x: Math.random() * this.canvas.width,
      y: Math.random() * this.canvas.height,
      vx: Math.cos(angle) * speed,
      vy: Math.sin(angle) * speed,
      radius: Math.random() * this.options.maxRadius + 0.5,
      opacity: Math.random() * 0.5 + 0.3,
    };
  }

  loop() {
    const { ctx, canvas, particles, options, mouse } = this;
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    particles.forEach((p, i) => {
      // Mouse repulsion
      if (options.mouseRepulse) {
        const dx = p.x - mouse.x;
        const dy = p.y - mouse.y;
        const dist = Math.sqrt(dx * dx + dy * dy);
        if (dist < options.repulseRadius) {
          const force = (options.repulseRadius - dist) / options.repulseRadius;
          p.vx += (dx / dist) * force * 0.8;
          p.vy += (dy / dist) * force * 0.8;
        }
      }

      // Speed cap
      const speed = Math.sqrt(p.vx * p.vx + p.vy * p.vy);
      if (speed > 3) { p.vx *= 0.95; p.vy *= 0.95; }

      // Move
      p.x += p.vx;
      p.y += p.vy;

      // Wrap edges
      if (p.x < 0) p.x = canvas.width;
      if (p.x > canvas.width) p.x = 0;
      if (p.y < 0) p.y = canvas.height;
      if (p.y > canvas.height) p.y = 0;

      // Draw particle
      ctx.beginPath();
      ctx.arc(p.x, p.y, p.radius, 0, Math.PI * 2);
      ctx.fillStyle = `rgba(${options.color}, ${p.opacity})`;
      ctx.fill();

      // Draw connection lines
      if (options.connectLines) {
        for (let j = i + 1; j < particles.length; j++) {
          const q = particles[j];
          const dx = p.x - q.x;
          const dy = p.y - q.y;
          const dist = Math.sqrt(dx * dx + dy * dy);
          if (dist < options.connectDistance) {
            const alpha = (1 - dist / options.connectDistance) * 0.4;
            ctx.beginPath();
            ctx.moveTo(p.x, p.y);
            ctx.lineTo(q.x, q.y);
            ctx.strokeStyle = `rgba(${options.color}, ${alpha})`;
            ctx.lineWidth = 0.8;
            ctx.stroke();
          }
        }
      }
    });

    this.raf = requestAnimationFrame(() => this.loop());
  }

  destroy() {
    cancelAnimationFrame(this.raf);
    window.removeEventListener('resize', this.resize);
  }
}

// Usage
const canvas = document.getElementById('particles');
const ps = new ParticleSystem(canvas, {
  count: 80,
  color: '167, 139, 250',
  connectLines: true,
  mouseRepulse: true,
});
```

```html
<div style="position: relative;">
  <canvas id="particles" style="position: absolute; inset: 0; width: 100%; height: 100%;"></canvas>
  <div style="position: relative; z-index: 1;">Your content here</div>
</div>
```

## Reduced Motion Guard

```js
const motionOk = !window.matchMedia('(prefers-reduced-motion: reduce)').matches;
if (motionOk) {
  const ps = new ParticleSystem(canvas);
} else {
  // Show static gradient background instead
  canvas.style.display = 'none';
}
```

## Performance Guidelines

| Particle count | Target device | Expected GPU load |
|---------------|---------------|-------------------|
| ≤ 60 | Mobile / low-end | Low |
| 60–120 | Mid-range | Moderate |
| 120–200 | Desktop only | High — profile first |
| > 200 | Avoid | Very high — use WebGL instead |

- Always call `ps.destroy()` when the component unmounts (SPA navigation)
- Use `offscreenCanvas` for WebWorker rendering on high particle counts
- Avoid `ctx.shadowBlur` in the particle loop — it is very expensive per-frame
