---
name: freeze
description: "Edit lock that restricts all Edit and Write operations to a single specified directory for the session. Prevents accidental changes outside the target scope during debugging, refactoring, or scoped work. Note: Bash commands (sed, awk, etc.) can still modify files outside the boundary — this is an intent guardrail, not a security boundary. Trigger when: freeze, lock edits, restrict to directory, scope edits, 鎖定編輯範圍, 只能改這個目錄. Pair with careful for maximum protection (use guard)."
metadata:
  category: meta
  version: "1.0"
---

# Freeze

Restricts all Edit and Write tool calls to a single directory for the current session, preventing accidental changes outside the intended scope.

## Purpose

Activate a directory lock that blocks any Edit or Write operation targeting files outside the specified path — useful when debugging, doing a scoped refactor, or working in one module and wanting to avoid accidentally touching unrelated code.

## Trigger

Apply when user requests:
- "freeze", "freeze edits", "lock edits to this directory", "restrict to directory"
- "scope edits", "only edit this folder", "鎖定編輯範圍", "只能改這個目錄"
- Automatically activates as part of `guard` (which combines `careful` + `freeze`)

Do NOT trigger for:
- Read operations — freeze never restricts reads, only writes
- Cases where work genuinely spans multiple directories — ask the user to confirm before freezing

## Prerequisites

- User must specify the target directory path to lock to

## Steps

1. **Confirm the target path** — ask the user: "Which directory should edits be locked to?" if not already specified; resolve the path to an absolute location

2. **Activate freeze** — confirm: "🔒 Freeze is ON. Edit and Write are restricted to `<absolute-path>/`. Operations outside this boundary will be blocked."

3. **Before every Edit or Write** — check whether the target file path starts with the frozen directory:
   - **Inside boundary** → proceed normally
   - **Outside boundary** → block the operation and explain: "🔒 Freeze blocked: `<file>` is outside `<frozen-dir>/`. Disable freeze first or specify a different boundary."

4. **Exceptions** — the following are always allowed regardless of freeze:
   - Read operations (never restricted)
   - Bash commands (freeze does not intercept shell; warn user of this limitation)
   - Writing to `/tmp` or system temp paths if explicitly confirmed by user

5. **Persist** — freeze remains active until user runs `unfreeze` or ends the session; remind the user if they attempt a blocked edit

## Output Format

```
🔒 Freeze activated

Boundary: /home/user/project/src/auth/
Status: Edit and Write are restricted to this directory

Any operation outside this path will be blocked.
Note: Bash commands (sed, awk, etc.) can still modify files outside — freeze is an intent guardrail, not a security boundary.
```

When a blocked operation is attempted:
```
🔒 Freeze blocked

Attempted: Edit /home/user/project/src/utils/helpers.ts
Reason: File is outside frozen boundary /home/user/project/src/auth/
Options: (1) Disable freeze with unfreeze  (2) Expand boundary to /home/user/project/src/
```

## Rules

### Must
- Always show the absolute resolved path when confirming freeze activation
- Block Edit and Write outside the boundary without exception
- Always warn the user that Bash commands bypass the freeze boundary
- Persist for the full session until explicit `unfreeze`

### Never
- Restrict Read operations — freeze is write-only
- Silently expand the boundary without asking the user
- Apply freeze to paths not yet confirmed by the user

## Examples

### Good Example

User: "I'm debugging the auth module, freeze edits to `src/auth/`"

```
🔒 Freeze activated

Boundary: /home/user/project/src/auth/
Edit and Write restricted to this directory.
Reminder: Bash commands (sed, mv, cp) can still modify files outside this boundary.
```

Later: Claude attempts to edit `src/utils/logger.ts`
```
🔒 Freeze blocked: src/utils/logger.ts is outside src/auth/
Run unfreeze to remove the boundary.
```

### Bad Example

User sets freeze to `src/auth/`. Claude encounters a bug fix that touches `src/utils/`, silently edits it anyway because "it's clearly related."

> Why this is bad: The entire point of freeze is to prevent scope creep during focused work. Silently bypassing the boundary defeats the guardrail. If the fix genuinely requires touching another directory, Claude must surface this to the user and ask to expand or remove the boundary.
