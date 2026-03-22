# Skill Maker — Annotated Examples

## Good Example

```markdown
---
name: commit-writer
description: "Generate git commit messages. Trigger when: write commit, generate commit message, create commit, format commit. Do not trigger for push, merge, or branch operations."
---

# Commit Writer

Generates a formatted git commit message from staged changes.

## Purpose

Generate a conventional git commit message based on the current staged diff.

## Trigger

Apply this skill when the user requests:
- "write a commit", "generate commit message", "create commit message"
- Any request to format or create a git commit

Do NOT trigger for:
- git push, merge, rebase, or branch operations
- Explaining what a commit is

## Prerequisites

- Git must be installed: run `git --version` to verify
- There must be staged changes: run `git diff --staged` to verify

## Steps

1. **Run `git diff --staged`** — captures the list of staged changes
2. **Identify the change type** — determine if it is feat, fix, chore, docs, refactor, or style
3. **Write the subject line** — format: `<type>(<scope>): <short description>` under 72 characters
4. **Write the body** — list what changed and why, one bullet per file changed
5. **Output the full commit message** — subject line + blank line + body

## Output Format

File path: none (output is printed to the user)

\`\`\`
<type>(<scope>): <short description>

- <file>: <what changed and why>
- <file>: <what changed and why>
\`\`\`

## Rules

### Must
- Subject line must follow conventional commit format
- Subject line must be under 72 characters
- Body must explain why, not just what

### Never
- Never omit the blank line between subject and body
- Never use past tense in the subject line ("added" → "add")

## Examples

### Good Example
\`\`\`
feat(auth): add JWT refresh token support

- src/auth/token.ts: add refreshToken() to handle expiry silently
- src/middleware/auth.ts: check refresh token before returning 401
\`\`\`

### Bad Example
\`\`\`
updated some files
\`\`\`

> Why this is bad: No type, no scope, no description of what changed or why. Cannot be searched or understood without reading the diff.
```

---

## Bad Example

```markdown
---
name: commit-writer
---

# Commit Writer

Helps with commits.

## Purpose

Handle git commits for the user.

## Trigger

Use when doing git stuff.

## Prerequisites

- Know how to use git

## Steps

1. Look at the changes
2. Write something good
3. Make sure it follows the rules

## Output Format

Write the commit message.

## Rules

- Be clear
- Don't be vague

## Examples

Good: `feat: add login`
Bad: `stuff`
```

> Why this is bad: Purpose uses a vague verb ("handle") and doesn't describe WHAT. Trigger has no keywords and no negative triggers. Prerequisite "know how to use git" is not verifiable. Steps don't start with imperative verbs, aren't atomic, and state no expected results. Output Format has no code block and no file path. Rules are untestable ("be clear"). Examples are fragments, not complete scenarios.
