---
name: pr-description-writer
description: "Generates a comprehensive pull request description from git diff and commit history. Reads git log and diff to produce Summary, Changes, Testing instructions, Breaking Changes, and Screenshots placeholder. Different from pr-review-expert (which reviews existing PRs). Triggers: write PR description, generate PR body, PR description, open PR, pull request description, 寫 PR 描述, PR 說明."
metadata:
  category: dev
---

## Purpose

Eliminate the "WIP" or blank PR description habit. Produce a structured, informative PR body from `git diff` that gives reviewers everything they need without chasing the author for context.

## Trigger

Apply when:
- "write PR description", "generate PR body", "open PR", "寫 PR 描述"
- User is about to open a pull request and has no description written
- "what should I put in my PR"

Do NOT trigger for:
- Reviewing an existing PR — use `pr-review-expert` instead
- Generating release notes — use `changelog-generator` instead

## Prerequisites

- Branch has commits that diverge from the base branch (default: `main` or `master`)
- Git repository with accessible diff

## Steps

### Step 1 — Gather Diff and Commits

```bash
# All commits not yet in main
git log main..HEAD --oneline --no-merges

# What files changed and how much
git diff main..HEAD --stat

# Full diff (for semantic analysis)
git diff main..HEAD
```

If base branch is not `main`, infer from: `git symbolic-ref refs/remotes/origin/HEAD` or ask user.

### Step 2 — Classify the Change Type

Determine the primary change type from commit prefixes or diff content:

| Type | Indicators |
|------|-----------|
| `feat` | New functions, new files, new routes, new UI components |
| `fix` | Bug patches, condition changes, error handling added |
| `refactor` | Code moved/renamed, no behavior change |
| `perf` | Complexity reduced, caching added, query optimized |
| `test` | Only test files changed |
| `docs` | Only documentation/comments changed |
| `chore` | Config, deps, CI, tooling changes |
| `breaking` | Interface removed/renamed, signature changed, migration required |

A PR can have multiple types — list primary first.

### Step 3 — Write the PR Description

Produce the description using this structure:

```markdown
## Summary
[1–3 sentence explanation of WHY this change exists, not what files changed]

## Changes
- [file or component]: [what changed and why]
- ...

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Refactor (no behavior change)
- [ ] Performance improvement
- [ ] Breaking change
- [ ] Documentation

## Testing
<!-- How to verify this works -->
- [ ] Existing tests pass: `[test command]`
- [ ] New tests added: [describe what they cover]
- [ ] Manual test: [specific steps to verify]

## Breaking Changes
<!-- Delete if none -->
[What breaks, what callers must update, migration path]

## Screenshots / Demo
<!-- Delete if not applicable -->
[Before / After screenshots or GIF]

## Related Issues
Closes #[issue number]
```

### Step 4 — Add Checklist Items Based on Diff Content

Auto-add specific checklist items based on what the diff contains:

- Auth/permissions changed → add `- [ ] Security review completed`
- Database migration in diff → add `- [ ] Migration tested on staging`
- Environment variables added → add `- [ ] .env.example updated`
- Public API changed → add `- [ ] API docs updated`
- Dependencies added/upgraded → add `- [ ] Dependency audit run`

## Output Format

```markdown
## Summary
[WHY paragraph]

## Changes
- `src/services/auth.js`: Added refresh token rotation; tokens now expire in 15min
- `tests/auth.test.js`: 4 new tests covering expiry and reuse scenarios

## Type of Change
- [x] New feature
- [x] Bug fix

## Testing
- [x] Existing tests pass: `npm test`
- [x] New tests added: refresh token expiry + replay attack prevention
- [ ] Manual test: Log in → wait 15min → verify auto-refresh works

## Breaking Changes
`POST /auth/login` response now includes `refreshToken` field (non-breaking addition).

## Related Issues
Closes #142
```

## Rules

### Must
- Summary must explain WHY, not WHAT — the diff already shows what changed
- Every PR description must have at least one Testing instruction
- Flag breaking changes explicitly even if the change seems minor
- Run `git diff main..HEAD --stat` first — never write a description without reading the diff

### Never
- Never write "WIP", "TODO", or blank descriptions
- Never list file names as the entire summary — "Changed auth.js" adds zero value
- Never omit Breaking Changes section for API, DB schema, or env var changes
- Never fabricate test commands — use actual commands from `package.json` or Makefile

## Examples

### Good Example

```markdown
## Summary
Fixes a race condition in the payment webhook handler where concurrent Stripe
retries could create duplicate orders. Adds idempotency key check before order
creation.

## Changes
- `src/webhooks/stripe.js`: Check idempotency key in Redis before processing
- `src/models/order.js`: Add unique constraint on stripe_payment_intent_id
- `migrations/20260323_add_payment_intent_unique.sql`: DB constraint migration

## Testing
- [x] Tests pass: `npm test`
- [x] New test: duplicate webhook delivery does not create second order
- [ ] Manual: use Stripe CLI to replay a payment event twice

Closes #198
```

### Bad Example

```markdown
fixes stuff

closes #198
```

> Why this is bad: Reviewer has no idea what was changed, why, or how to test it. Forces them to read the entire diff before they can even decide if this is safe to merge.
