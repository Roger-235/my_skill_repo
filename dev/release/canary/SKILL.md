---
name: canary
description: "Post-deploy monitoring: captures baseline screenshots and metrics before deploy, then monitors live production for regressions every 60 seconds — alerts on new console errors, >2x load time, broken links, and page failures. Change-detection based (not absolute thresholds) to minimize false positives. Requires Playwright MCP browser. Trigger when: canary, post-deploy monitor, watch production, monitor after deploy, check for regressions, 部署後監控, 上線後巡邏. Do not trigger before deploying — use qa or webapp-testing instead."
metadata:
  category: dev
disable-model-invocation: true
---

# Canary

Post-deploy regression monitor: captures a pre-deploy baseline, then watches live production and alerts only on *changes* from that baseline — not on absolute values.

## Purpose

Detect production regressions introduced by a deployment by continuously comparing the live app against a pre-deploy baseline, firing alerts only when something changes, which minimizes false positives while catching real issues.

## Trigger

Apply when user requests:
- "canary", "post-deploy monitor", "monitor after deploy", "watch production"
- "check for regressions", "canary check", "部署後監控", "上線後巡邏"
- "keep watching the site after I ship"

Do NOT trigger for:
- Pre-deploy testing — use `qa` or `webapp-testing`
- General performance auditing — use `benchmark`
- One-time health check without ongoing monitoring — use `webapp-testing`

## Prerequisites

- Playwright MCP browser available: confirm with `playwright` tool presence
- Target URL accessible (production or staging)
- Optional: pre-deploy baseline already captured with `--baseline` flag

## Steps

1. **Parse arguments** — extract: URL, duration (default 10 min), pages to monitor (default: auto-discover top 5 nav links), mode (`--baseline`, `--quick`, or default monitor)

2. **Baseline mode** (`--baseline`)
   - Navigate to each target page
   - Record: page load time, console error count and messages, HTTP status code, screenshot
   - Save baseline to `.canary/baseline-<timestamp>.json`
   - Output: "Baseline captured for N pages. Run canary again after deploy to detect regressions."

3. **Quick mode** (`--quick`) — single health check pass across all pages; no loop; report immediately

4. **Monitor mode** (default)
   - Load most recent baseline if available; warn if no baseline exists (first run: treat current state as baseline)
   - Start monitoring loop: check each page every 60 seconds for the specified duration
   - On each check, compare against baseline:

   | Signal | Alert threshold | Severity |
   |--------|----------------|---------|
   | New console errors | Any error not in baseline | HIGH |
   | Load time | > 2× baseline load time | HIGH |
   | Page failure | HTTP 4xx/5xx or navigation error | CRITICAL |
   | Broken links | 404 not in baseline | MEDIUM |
   | Visual diff | Screenshot differs significantly | LOW (flag for review) |

   - Fire alert only if the same signal persists across 2+ consecutive checks (reduces flap)
   - Continue monitoring until duration expires or user stops

5. **Report** — after monitoring ends, produce the health report

## Output Format

```
## Canary Report: <URL>

Duration: <actual> / <requested>
Pages monitored: <N>
Checks completed: <N>

### CRITICAL
| Page | Signal | First seen | Details |
|------|--------|------------|---------|
| /dashboard | Page failure | 14:32 | HTTP 503 on checks 3, 4, 5 |

### HIGH
| Page | Signal | Baseline | Current | First seen |
|------|--------|---------|---------|------------|
| / | New console error | 0 errors | TypeError: x is undefined | 14:31 |

### MEDIUM / LOW
(or: ✓ No MEDIUM/LOW signals)

### Per-page summary
| Page | Status | Load time (baseline→now) | Console errors |
|------|--------|--------------------------|---------------|
| / | ⚠️ HIGH | 820ms → 940ms | +1 new error |
| /dashboard | 🔴 CRITICAL | — | — |
| /settings | ✓ OK | 430ms → 420ms | 0 |

### Verdict
🔴 FAIL — 1 CRITICAL, 1 HIGH regression detected
Recommendation: rollback or hotfix before proceeding
```

## Rules

### Must
- Alert on *changes* from baseline, never on absolute values — a page with 3 baseline errors staying at 3 is healthy; a new error is an alert
- Require 2+ consecutive checks before firing a persistent alert (prevents flap alerts from transient blips)
- Capture a new baseline before each deploy for accurate regression detection
- Warn clearly when no baseline exists and the current state is being used as the implicit baseline

### Never
- Alert on errors that were already present in the baseline — only new regressions count
- Continue monitoring after a CRITICAL page failure without surfacing it immediately
- Treat a single failed check as a confirmed regression — require persistence across 2+ checks
- Access authenticated routes without confirming cookie/session setup with the user first

## Examples

### Good Example

User: "I just deployed, run canary on https://myapp.com for 5 minutes"

Canary loads the baseline captured before deploy, monitors every 60 seconds, detects a new `TypeError` on `/dashboard` that persists across 2 checks → fires HIGH alert with exact error message and first-seen timestamp. Reports clean on all other pages.

### Bad Example

User: "I just deployed, run canary on https://myapp.com"

Canary fires alerts for every console warning present in the baseline because it compares against zero instead of the captured baseline.

> Why this is bad: Alerting on pre-existing baseline errors creates noise that trains users to ignore alerts. Change-detection (baseline vs. current) is the core design principle — alerts must represent regressions, not pre-existing state.
