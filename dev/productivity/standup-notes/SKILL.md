---
name: standup-notes
description: "Generates a concise daily standup report from git history and current branch state. Reads git log (last 24h), open PRs, and in-progress work to produce Yesterday / Today / Blockers in Slack-ready markdown. Triggers: standup, daily standup, scrum notes, generate standup, what did I do yesterday, 站會, 每日報告."
metadata:
  category: dev
disable-model-invocation: true
---

## Purpose

Produce a structured daily standup report in under 30 seconds by mining git history, current branch state, and open issues. Eliminates context-switching and memory recall every morning.

## Trigger

Apply when:
- "standup", "generate standup", "daily standup notes", "what did I do yesterday"
- "scrum notes", "站會", "每日報告", "寫站會"
- User needs a summary of recent work before a standup meeting

Do NOT trigger for:
- Weekly/sprint retrospectives — use `retro` instead
- Full changelog generation — use `changelog-generator` instead

## Prerequisites

- Git repository with recent commits
- Run from inside the project directory
- GitHub CLI (`gh`) optional but used for PR status

## Steps

### Step 1 — Collect Yesterday's Activity

```bash
# Commits by current author in last 24 hours
git log --since="24 hours ago" --author="$(git config user.name)" \
  --format="%h %s" --no-merges

# Also check last working day (Friday → covers weekend gap)
git log --since="3 days ago" --author="$(git config user.name)" \
  --format="%h %s" --no-merges | head -20
```

Group commits by Jira/Linear ticket prefix (e.g., `PROJ-123`) or by scope prefix (e.g., `feat(auth):`).

### Step 2 — Assess Today's Plan

```bash
# Current branch name (implies active work)
git branch --show-current

# Uncommitted work in progress
git status --short

# Stashed work
git stash list
```

Infer today's tasks from: active branch name, uncommitted changes, and any `TODO` / `FIXME` added in the last diff.

### Step 3 — Surface Blockers

Scan for blockers using:
```bash
# TODOs or FIXMEs added in recent commits (not yet resolved)
git diff HEAD~5..HEAD | grep -E "^\+.*(TODO|FIXME|BLOCKED|HACK)" | head -10
```

If GitHub CLI is available:
```bash
# PRs awaiting review by others
gh pr list --author @me --state open --json title,reviewDecision,url
```

Flag any PR with `reviewDecision: REVIEW_REQUIRED` open > 1 day as a potential blocker.

### Step 4 — Format and Output

Assemble the three sections. Keep each bullet ≤ 1 line. Reference ticket IDs where present. Output as Slack-ready markdown.

## Output Format

```
*Standup — [date] — [author]*

*Yesterday*
• [TICKET-123] Implemented OAuth token refresh — merged to main
• [TICKET-124] Fixed N+1 query in /api/orders — PR open for review

*Today*
• [TICKET-125] Start payment webhook handler
• Review + merge open PRs (2 waiting)

*Blockers*
• PR #142 waiting on review from @alice since 2 days
• None ✅
```

Slack-formatted version (use `>` blockquote if pasting into Slack directly):
```
> *Standup — 2026-03-23*
> *Yesterday:* TICKET-123 OAuth refresh merged; TICKET-124 N+1 fix in review
> *Today:* TICKET-125 webhook handler; clear review queue
> *Blockers:* PR #142 stalled 2d
```

## Rules

### Must
- Include ticket/issue IDs in every bullet where available — "fixed bug" is never acceptable
- Cover the last working day, not just calendar 24h (handle weekend gaps)
- Keep total output under 10 lines — this is a standup, not a report
- Flag PRs open > 1 business day awaiting external review as blockers

### Never
- Never fabricate commits — only report what `git log` actually shows
- Never include commits by other authors — this standup is for the current user only (`git config user.name`)
- Never list WIP stashes as "Yesterday" — they go in Today or Blockers

## Examples

### Good Example

```
*Standup — 2026-03-23 — Alice Chen*

*Yesterday*
• [AUTH-89] Completed JWT refresh token rotation — merged
• [AUTH-90] Added integration tests for refresh edge cases — PR #156 open

*Today*
• [AUTH-91] Implement token revocation endpoint
• Address review feedback on PR #156

*Blockers*
• PR #156 needs review from @bob (open 1d)
```

### Bad Example

```
Yesterday: worked on auth stuff
Today: more auth
Blockers: none
```

> Why this is bad: No ticket IDs, no specifics, no PR references. Teammates cannot assess impact or offer help with blockers.
