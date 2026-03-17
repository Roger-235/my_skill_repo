---
name: git-workflow
description: "Git branching strategy, commit message conventions (Conventional Commits), and PR workflow guide. Trigger when: git workflow, branching strategy, commit conventions, conventional commits, PR template, git best practices, 分支策略, commit 規範, PR 格式, git 流程."
metadata:
  category: dev
  version: "1.0"
---

# Git Workflow

Defines and enforces a consistent Git workflow including branch naming, commit message format, atomic commits, PR structure, and merge strategy.

## Purpose

Define and enforce a consistent Git workflow including branch naming, commit message format (Conventional Commits), atomic commits, PR structure, and merge strategy so that project history is readable, reviewable, and bisectable.

## Trigger

Apply when the user requests:
- "git workflow", "branching strategy", "commit conventions", "conventional commits"
- "PR template", "git best practices", "how to write commit messages"
- "分支策略", "commit 規範", "PR 格式", "git 流程"

Do NOT trigger for:
- Resolving merge conflicts — use debug instead
- Reviewing code in a PR — use code-review instead

## Prerequisites

- A Git repository must exist (`git init` or cloned)
- The primary branch name must be known (main or master)

## Steps

1. **Define branch naming convention** — format: `<type>/<issue-number>-<short-description>` (e.g., `feat/123-add-login`, `fix/456-null-pointer`); types: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`; use lowercase and hyphens only
2. **Write commit messages in Conventional Commits format** — `<type>(<scope>): <description>` where description is imperative mood (e.g., `feat(auth): add JWT refresh token`); add a body to explain WHY when the reason is not obvious from the title
3. **Keep commits atomic** — one logical change per commit; separate formatting/whitespace changes from logic changes; do not bundle unrelated fixes into one commit
4. **Structure the PR** — title matches the main commit message format; body includes: what changed, why it was changed, how to test, and screenshots for any UI change
5. **Choose merge strategy** — squash merge for feature branches (produces a clean, linear history); merge commit for release branches (preserves the full context of the release)
6. **Protect the main branch** — require at least one PR review, require all CI checks to pass, and disable direct pushes to main/master

## Output Format

```
## Git Workflow: <project name>

### Branch Naming
Pattern: <type>/<issue>-<short-description>
Types: feat | fix | chore | docs | refactor | test
Example: feat/42-user-authentication

### Commit Format
<type>(<scope>): <short description>

[optional body: explain WHY this change was made]

[optional footer: Closes #42]

### PR Template
**Title:** <conventional commit format>
**Description:** <what changed and why>
**Test plan:** <how to verify the change>
**Screenshots:** <if UI change>

### Merge Strategy
Feature branches → Squash merge (clean linear history)
Release branches → Merge commit (preserve release context)
```

## Rules

### Must
- Every commit message must describe WHY, not just WHAT, when the reason is not obvious from the title alone
- Branch names must include the issue number when one exists in the tracker
- All PRs must include a test plan describing how the reviewer can verify correctness
- Commit type must accurately reflect the nature of the change (`fix` for bug fixes, `feat` for new behavior, `chore` for maintenance)

### Never
- Never commit directly to main/master — all changes must go through a PR
- Never use `git push --force` on shared branches; use `--force-with-lease` only if absolutely necessary and with team awareness
- Never mix formatting changes with logic changes in the same commit — they make diffs unreadable and bisect unreliable
- Never use vague commit messages such as "fix stuff", "update", "WIP", or "changes"

## Examples

### Good Example

```
## Git Workflow: api-service

### Branch
feat/89-password-reset

### Commits
feat(auth): add password reset email flow

Users can now request a password reset via /auth/reset. A signed
token valid for 1 hour is emailed to the registered address.
Token expiry is intentionally short to limit the phishing window.

Closes #89

### PR
**Title:** feat(auth): add password reset email flow
**Description:** Adds the /auth/reset endpoint and email dispatch.
  Token expiry set to 1 hour — see commit body for rationale.
**Test plan:**
  - Run `pytest tests/test_auth.py::test_password_reset`
  - Manually request reset for a test account and confirm email arrives
  - Confirm expired token returns 401
**Screenshots:** N/A (no UI change)
```

### Bad Example

```
Branch: patch-1
Commit: fix stuff
PR title: update
PR description: (empty)
```

> Why this is bad: The branch name gives no context about what is being changed or which issue it addresses. The commit message "fix stuff" is meaningless in git log — a future developer (or the author in six months) cannot understand what was fixed or why. The empty PR description makes the change impossible to review without reading every line of diff. There is no test plan, so the reviewer cannot verify correctness.
