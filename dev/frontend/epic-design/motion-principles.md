# Motion Principles

## Core Easing Curves

```css
/* Spring — overshoots slightly, feels alive */
--ease-spring:   cubic-bezier(0.34, 1.56, 0.64, 1);

/* Smooth out — decelerates to rest, feels natural */
--ease-out:      cubic-bezier(0.0, 0.0, 0.2, 1);

/* Smooth in-out — symmetric, good for transitions */
--ease-in-out:   cubic-bezier(0.4, 0.0, 0.2, 1);

/* Anticipate — slight wind-up before launch */
--ease-back-in:  cubic-bezier(0.36, 0, 0.66, -0.56);
```

## Duration Scale

| Use case | Duration | Notes |
|----------|----------|-------|
| Micro (feedback) | 100–150ms | Button press, checkbox tick |
| Short (element) | 200–300ms | Tooltip, badge, icon swap |
| Medium (component) | 300–500ms | Modal open, drawer, card expand |
| Long (page) | 500–800ms | Page transition, hero entrance |
| Cinematic | 800ms–2s | Splash screen, loader, feature reveal |

## Stagger Patterns

```js
// Cascade stagger — each child delays by n * offset
children.forEach((el, i) => {
  el.style.animationDelay = `${i * 60}ms`;
});

// Max stagger cap — avoid long wait for large lists
const STAGGER_CAP = 400; // ms
children.forEach((el, i) => {
  el.style.animationDelay = `${Math.min(i * 60, STAGGER_CAP)}ms`;
});
```

## Choreography Patterns

### Hero Section Entrance
1. Background gradient/image fades in (0ms, 600ms)
2. Headline slides up + fades in (200ms, 700ms, ease-spring)
3. Subheadline slides up + fades in (350ms, 600ms, ease-out)
4. CTA button scales up from 0.9 (480ms, 400ms, ease-spring)
5. Decorative elements float in (600ms, 800ms, ease-out)

### Card Grid Reveal (Intersection Observer)
1. Observer fires when card enters viewport
2. Card translates from `translateY(32px)` to `translateY(0)` + opacity 0→1
3. Duration: 500ms ease-out
4. Stagger: 60ms per card, capped at 360ms

### Page Transition (SPA)
1. Outgoing page: opacity 1→0, translateX(0→-20px), 300ms ease-in
2. Incoming page: opacity 0→1, translateX(20px→0), 400ms ease-out
3. Overlap by 100ms for smooth crossfade

## Intersection Observer Template

```js
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('animate-in');
      observer.unobserve(entry.target); // play once
    }
  });
}, { threshold: 0.15, rootMargin: '0px 0px -60px 0px' });

document.querySelectorAll('[data-animate]').forEach(el => observer.observe(el));
```

## Scroll-Driven Animations (CSS)

```css
/* Progress bar that fills as page scrolls */
.scroll-progress {
  transform-origin: left;
  animation: scaleX linear;
  animation-timeline: scroll(root);
}

@keyframes scaleX {
  from { transform: scaleX(0); }
  to   { transform: scaleX(1); }
}

/* Parallax layer — moves at 0.4x scroll speed */
.parallax-slow {
  animation: parallaxMove linear;
  animation-timeline: scroll(root);
}

@keyframes parallaxMove {
  from { transform: translateY(0); }
  to   { transform: translateY(-40%); }
}
```
