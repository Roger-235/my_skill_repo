---
name: accessibility-audit
description: "WCAG 2.2 Level AA accessibility audit for web applications. Checks perceivable (alt text, color contrast, captions), operable (keyboard navigation, focus management, WCAG 2.2 new criteria), understandable (labels, error messages), and robust (ARIA, screen reader compatibility). Produces violation table with WCAG criterion IDs and remediation. Triggers: accessibility audit, WCAG, a11y, screen reader, keyboard navigation, color contrast, ARIA audit, 無障礙, 可及性."
metadata:
  category: dev
---

## Purpose

Verify that a web application meets WCAG 2.2 Level AA — the standard required by ADA, EN 301 549, and most accessibility laws globally. Produces a prioritized violation report with WCAG criterion IDs, severity, and concrete fixes.

## Trigger

Apply when:
- "accessibility audit", "WCAG compliance", "a11y audit", "無障礙檢查"
- "screen reader compatibility", "keyboard navigation audit", "color contrast check"
- Pre-launch accessibility gate, legal compliance review, user complaint about inaccessibility

Do NOT trigger for:
- General UI/UX review — use `senior-frontend` instead
- Performance audits — use `performance-profiler` instead

## Prerequisites

- Access to the component or page source (HTML/JSX/TSX)
- Or: a running URL that can be fetched
- Color values available (hex/rgb) for contrast checks

## Steps

### Step 1 — Automated Scan (if URL available)

```bash
# Run axe-core via CLI
npx axe-core-cli <url> --include main --reporter json 2>/dev/null

# Or Lighthouse accessibility audit
npx lighthouse <url> --only-categories=accessibility --output json 2>/dev/null | \
  jq '.categories.accessibility.score, .audits | to_entries[] | select(.value.score < 1)'
```

If neither is available, proceed with manual analysis of provided source code.

### Step 2 — Perceivable (WCAG Principle 1)

Check each criterion. Full pattern table: [ref/wcag-checklist.md](ref/wcag-checklist.md)

| Criterion | Check | Common Failure |
|-----------|-------|----------------|
| 1.1.1 Non-text Content | Every `<img>` has meaningful `alt`; decorative images use `alt=""` | `<img src="logo.png">` with no alt |
| 1.3.1 Info & Relationships | Structure conveyed via semantic HTML, not visual styling only | `<div class="heading">` instead of `<h2>` |
| 1.3.5 Identify Input Purpose | `autocomplete` attributes on personal data fields | Missing `autocomplete="email"` |
| 1.4.1 Use of Color | Color is not the only means of conveying information | Red-only error indicators |
| 1.4.3 Contrast (Min) | Text contrast ≥ 4.5:1 (3:1 for large text ≥18pt/14pt bold) | Light gray on white |
| 1.4.4 Resize Text | Content usable at 200% zoom without scrolling horizontally | Fixed-width containers |
| 1.4.10 Reflow | Content reflows at 320px width without 2D scrolling | Tables/cards breaking layout |
| 1.4.11 Non-text Contrast | UI components (focus rings, form borders) ≥ 3:1 contrast | Faint input borders |

### Step 3 — Operable (WCAG Principle 2)

| Criterion | Check | Common Failure |
|-----------|-------|----------------|
| 2.1.1 Keyboard | All functionality available via keyboard | Click-only dropdowns |
| 2.1.2 No Keyboard Trap | Focus can always be moved away with keyboard | Modal dialogs trapping focus |
| 2.4.3 Focus Order | Tab order is logical and matches visual layout | DOM order mismatches visual |
| 2.4.4 Link Purpose | Link text is meaningful in isolation | "Click here", "Read more" |
| 2.4.7 Focus Visible | Keyboard focus indicator is always visible | CSS `outline: none` globally |
| 2.4.11 Focus Not Obscured *(new 2.2)* | Sticky headers/footers don't fully cover focused element | Sticky nav covering inputs |
| 2.4.12 Focus Not Obscured (Enhanced) *(new 2.2)* | Focused element is fully visible | — |
| 2.5.3 Label in Name | Visible label text included in accessible name | Icon buttons without text |
| 2.5.7 Dragging Movements *(new 2.2)* | All drag operations have single-pointer alternative | Drag-only sorting |
| 2.5.8 Target Size *(new 2.2)* | Interactive targets ≥ 24×24 CSS pixels | Small icon buttons |

### Step 4 — Understandable (WCAG Principle 3)

| Criterion | Check | Common Failure |
|-----------|-------|----------------|
| 3.1.1 Language of Page | `<html lang="en">` set | Missing or wrong lang attribute |
| 3.2.2 On Input | No automatic context change on focus | Auto-submit on radio select |
| 3.3.1 Error Identification | Form errors identified in text, not color only | Red border without message |
| 3.3.2 Labels or Instructions | All form fields have visible labels | Placeholder-only inputs |
| 3.3.7 Redundant Entry *(new 2.2)* | Users not asked to re-enter info already provided | Shipping = billing re-entry |
| 3.3.8 Accessible Authentication *(new 2.2)* | No cognitive function test required for auth | CAPTCHA without alternative |

### Step 5 — Robust (WCAG Principle 4) — ARIA & Screen Readers

Common ARIA misuse patterns:
```html
<!-- Bad: interactive element without role -->
<div onclick="submit()">Submit</div>

<!-- Bad: aria-label conflicts with visible text -->
<button aria-label="Close dialog">X Cancel</button>

<!-- Bad: aria-hidden on focusable element -->
<button aria-hidden="true" tabindex="0">Click me</button>

<!-- Bad: missing aria-live for dynamic content -->
<div id="status"><!-- Updated via JS without aria-live --></div>

<!-- Bad: form field not linked to label -->
<label>Email</label><input type="email" />  <!-- no htmlFor/id link -->
```

Test with screen readers: NVDA + Firefox (Windows), VoiceOver + Safari (macOS/iOS).

### Step 6 — Color Contrast Calculator

For each text/background color pair found:

```
Contrast ratio = (L1 + 0.05) / (L2 + 0.05)
where L = relative luminance

Required:
- Normal text (<18pt, <14pt bold): ≥ 4.5:1
- Large text (≥18pt, ≥14pt bold): ≥ 3:1
- UI components & focus indicators: ≥ 3:1
```

Flag any pair below threshold. Suggest accessible alternatives using HSL lightness adjustment.

## Output Format

```
╔══════════════════════════════════════════════════╗
║  ACCESSIBILITY AUDIT — WCAG 2.2 Level AA        ║
║  Score: [n]/100   Violations: [n]               ║
╚══════════════════════════════════════════════════╝

CRITICAL (must fix before launch)
  [1.4.3] src/components/Button.tsx
  Contrast ratio: 2.8:1 (required: 4.5:1)
  Colors: #767676 on #FFFFFF
  Fix: Change text color to #595959 or darker

  [2.4.7] src/styles/global.css:14
  Pattern: outline: none on :focus
  Fix: Remove or replace with visible focus style

HIGH (required for AA compliance)
  [1.1.1] src/components/Avatar.tsx:8
  <img src={user.photo}> — missing alt attribute
  Fix: alt={`${user.name} profile photo`}

  [2.5.8 NEW] src/components/IconButton.tsx
  Target size: 16×16px (required: 24×24px)
  Fix: Add min-width/min-height: 24px or padding

MEDIUM (best practice)
  [3.3.2] src/components/LoginForm.tsx:22
  Email input uses placeholder only, no <label>
  Fix: Add <label htmlFor="email">Email address</label>
```

## Rules

### Must
- Always report WCAG criterion ID (e.g., `1.4.3`) with every finding
- Test WCAG 2.2 new criteria (2.4.11, 2.5.7, 2.5.8, 3.3.7, 3.3.8) explicitly
- Provide exact color contrast ratios and required thresholds, not just "too low"
- Include concrete fix for every violation — never just describe the problem

### Never
- Never use `aria-label` to hide or contradict visible text
- Never mark a component accessible based on visual appearance alone
- Never suggest `role="presentation"` on interactive elements as a fix
- Never pass `outline: none` — always provide a replacement focus style

## Examples

### Good Example

```
[1.4.3] LoginPage — "Sign in" button
Contrast: 3.1:1 (#888 on #FFF) — required 4.5:1
Fix: Change button text to #595959 (#595959 on #FFF = 5.9:1 ✓)
```

### Bad Example

```
The button colors look fine to me. The contrast might be a little low
but it's probably okay for most users.
```

> Why this is bad: "Probably okay" is not WCAG compliance. No criterion ID, no ratio, no fix. Inaccessible UI exposes the project to legal liability and excludes users with visual impairments.
