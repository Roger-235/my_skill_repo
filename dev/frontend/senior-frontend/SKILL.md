---
name: senior-frontend
description: "Frontend development skill for React, Next.js, TypeScript, and Tailwind CSS applications. Use when building React components, optimizing Next.js performance, analyzing bundle sizes, scaffolding frontend projects, implementing accessibility, or reviewing frontend code quality."
metadata:
  category: dev
  version: "1.0"
---

# Senior Frontend

Frontend development patterns, performance optimization, and automation tools for React/Next.js applications.

## Purpose

Provide senior-level frontend development patterns, tooling, and automation for React and Next.js applications covering scaffolding, component generation, bundle analysis, and accessibility.

## Trigger

Apply when the user requests:
- "build React component", "scaffold Next.js project", "set up frontend", "create component"
- "analyze bundle size", "optimize frontend", "React patterns", "Next.js performance"
- "implement accessibility", "review frontend code", "frontend best practices"
- "TypeScript React", "Tailwind CSS", "generate component with tests"

Do NOT trigger for:
- Backend API development — use appropriate backend skill
- Pure CSS/design tasks — use `ui-ux-pro-max` or `epic-design`
- Cinematic animations and 2.5D effects — use `epic-design`

## Prerequisites

- Node.js 18+ installed: run `node --version` to verify
- Python 3.x installed (for automation scripts): run `python3 --version` to verify
- For Next.js projects: run `npx create-next-app --version` to verify npm access

## Steps

1. **Identify the request type** — determine if user needs: project scaffolding, component generation, bundle analysis, React patterns, Next.js optimization, or accessibility guidance
2. **Run the appropriate script** — use `scripts/frontend_scaffolder.py`, `scripts/component_generator.py`, or `scripts/bundle_analyzer.py` based on the request
3. **Apply relevant patterns** — reference `references/react_patterns.md`, `references/nextjs_optimization_guide.md`, or `references/frontend_best_practices.md` for implementation details
4. **Verify the output** — confirm generated files compile, tests pass, and accessibility requirements are met
5. **Report results** — summarize what was created or optimized with any actionable recommendations

## Output Format

Output depends on the operation performed:

```
### Frontend Operation: <type>

**Result**: DONE / FAILED
**Files created/modified**: <list>

**Summary**: <what was done>

**Next steps** (if any):
- <action>
```

## Rules

### Must
- Use Server Components by default in Next.js — only add `'use client'` when event handlers, state, or browser APIs are required
- Include TypeScript interfaces for all component props
- Apply accessibility requirements: semantic HTML, ARIA labels, keyboard navigation, focus indicators
- Use `cn()` utility for conditional Tailwind class composition

### Never
- Never hardcode API URLs — use environment variables or config constants
- Never use `any` type in TypeScript without a documented justification
- Never import full lodash or moment — use tree-shakeable alternatives (lodash-es, date-fns, dayjs)
- Never create Client Components when a Server Component would work

## Examples

### Good Example

```bash
python scripts/component_generator.py UserProfile --with-test --with-story
# Generates: UserProfile.tsx (typed props, accessible), UserProfile.test.tsx, UserProfile.stories.tsx
```

### Bad Example

```tsx
// Bad: full lodash import, any type, hardcoded URL
import _ from 'lodash';
const data: any = await fetch('http://localhost:3000/api/users');
```

> Why this is bad: Full lodash import bloats the bundle. `any` defeats TypeScript safety. Hardcoded URL breaks in other environments.

---

## Project Scaffolding

Next.js/React project generation with TypeScript, Tailwind CSS, and optional features (auth, forms, testing).

Full guide with options and generated structure: [ref/scaffolding.md](ref/scaffolding.md)

---

## Component Generation

Generate typed React components, server components, hooks, and Storybook stories.

Full guide with options and examples: [ref/component-generation.md](ref/component-generation.md)

---

## Bundle Analysis

Analyze and optimize bundle size — identify heavy dependencies, get alternatives, score health.

Full guide with workflow and dependency reference table: [ref/bundle-analysis.md](ref/bundle-analysis.md)

---

## React Patterns

Compound Components, Custom Hooks, and Render Props patterns with complete code examples.

Full patterns: [ref/react-patterns.md](ref/react-patterns.md)

---

## Next.js Optimization

Server vs Client Components decision guide, Image optimization, and data fetching patterns.

Full guide with code examples: [ref/nextjs-optimization.md](ref/nextjs-optimization.md)

---

## Accessibility and Testing

Accessibility checklist (ARIA, keyboard nav, contrast) and testing patterns with RTL/Playwright.

Full guide with code examples: [ref/accessibility-testing.md](ref/accessibility-testing.md)

---

## Quick Reference

```js
// next.config.js
const nextConfig = {
  images: {
    remotePatterns: [{ hostname: 'cdn.example.com' }],
    formats: ['image/avif', 'image/webp'],
  },
  experimental: {
    optimizePackageImports: ['lucide-react', '@heroicons/react'],
  },
};
```

```tsx
// Conditional classes with cn()
import { cn } from '@/lib/utils';
<button className={cn(
  'px-4 py-2 rounded',
  variant === 'primary' && 'bg-blue-500 text-white',
  disabled && 'opacity-50 cursor-not-allowed'
)} />
```

---

## Resources

- React Patterns: `references/react_patterns.md`
- Next.js Optimization: `references/nextjs_optimization_guide.md`
- Best Practices: `references/frontend_best_practices.md`
