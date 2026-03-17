# Visual Effects Reference

## Glassmorphism

```css
.glass {
  background: rgba(255, 255, 255, 0.08);
  backdrop-filter: blur(20px) saturate(180%);
  -webkit-backdrop-filter: blur(20px) saturate(180%);
  border: 1px solid rgba(255, 255, 255, 0.15);
  border-radius: 16px;
  box-shadow:
    0 8px 32px rgba(0, 0, 0, 0.25),
    inset 0 1px 0 rgba(255, 255, 255, 0.2);
}

/* Dark glass variant */
.glass-dark {
  background: rgba(0, 0, 0, 0.35);
  backdrop-filter: blur(24px);
  -webkit-backdrop-filter: blur(24px);
  border: 1px solid rgba(255, 255, 255, 0.08);
}
```

**Performance note:** Limit to 2–3 simultaneously visible glass elements. Each `backdrop-filter` creates a new GPU compositing layer.

## Neumorphism (Soft UI)

```css
/* Light neumorphism */
.neumorphic {
  background: #e0e5ec;
  border-radius: 16px;
  box-shadow:
     8px  8px 16px  rgba(163, 177, 198, 0.6),
    -8px -8px 16px  rgba(255, 255, 255, 0.9);
}

/* Pressed / inset state */
.neumorphic:active {
  box-shadow:
    inset  4px  4px 8px  rgba(163, 177, 198, 0.6),
    inset -4px -4px 8px  rgba(255, 255, 255, 0.9);
}
```

**Accessibility warning:** Neumorphic contrast is inherently low. Always add a text label or icon with sufficient contrast independent of the shadow effect.

## Aurora / Mesh Gradients

```css
.aurora-bg {
  background:
    radial-gradient(ellipse 80% 60% at 20% 40%, rgba(120, 40, 200, 0.4) 0%, transparent 60%),
    radial-gradient(ellipse 60% 80% at 80% 20%, rgba(0, 180, 255, 0.3) 0%, transparent 60%),
    radial-gradient(ellipse 100% 50% at 50% 90%, rgba(0, 255, 150, 0.2) 0%, transparent 60%),
    #0a0a1a;
  background-size: 100% 100%;
}

/* Animated aurora */
.aurora-animated {
  background: var(--aurora-base);
  animation: auroraShift 12s ease-in-out infinite alternate;
}

@keyframes auroraShift {
  0%   { filter: hue-rotate(0deg) brightness(1); }
  50%  { filter: hue-rotate(30deg) brightness(1.1); }
  100% { filter: hue-rotate(-20deg) brightness(0.95); }
}
```

## Noise Texture Overlay

```css
/* SVG-based noise — no external image needed */
.noise-overlay::after {
  content: '';
  position: absolute;
  inset: 0;
  opacity: 0.04;
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E");
  pointer-events: none;
}
```

## Gradient Text

```css
.gradient-text {
  background: linear-gradient(135deg, #a78bfa 0%, #60a5fa 50%, #34d399 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}
```

## Glow Effects

```css
/* Box glow */
.glow-purple {
  box-shadow:
    0 0 20px rgba(167, 139, 250, 0.4),
    0 0 60px rgba(167, 139, 250, 0.2),
    0 0 100px rgba(167, 139, 250, 0.1);
}

/* Text glow */
.text-glow {
  text-shadow:
    0 0 10px rgba(167, 139, 250, 0.8),
    0 0 30px rgba(167, 139, 250, 0.5);
}

/* Animated pulse glow */
.glow-pulse {
  animation: glowPulse 2s ease-in-out infinite;
}

@keyframes glowPulse {
  0%, 100% { box-shadow: 0 0 20px rgba(167, 139, 250, 0.3); }
  50%       { box-shadow: 0 0 40px rgba(167, 139, 250, 0.7); }
}
```

## Border Gradient Animation

```css
/* Animated gradient border using @property */
@property --border-angle {
  syntax: '<angle>';
  inherits: false;
  initial-value: 0deg;
}

.gradient-border {
  border: 2px solid transparent;
  background:
    linear-gradient(#0a0a1a, #0a0a1a) padding-box,
    conic-gradient(from var(--border-angle), #a78bfa, #60a5fa, #34d399, #a78bfa) border-box;
  animation: rotateBorder 4s linear infinite;
}

@keyframes rotateBorder {
  to { --border-angle: 360deg; }
}
```
