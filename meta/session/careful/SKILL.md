---
name: careful
description: "Session safety guardrail: intercepts destructive bash commands before execution and requires explicit confirmation. Protects against rm -rf, DROP TABLE, git push --force, git reset --hard, kubectl delete, docker system prune. Safe exceptions: build artifact dirs (node_modules, .next, dist, __pycache__, coverage). Trigger when: careful mode, enable safety guardrail, 開啟安全警告, 小心模式, careful, guard mode. Pair with freeze for maximum protection."
metadata:
  category: meta
  version: "1.0"
---

# Careful

Session-scoped safety guardrail: pauses before any destructive command and requires the user to confirm before proceeding.

## Purpose

Activate a protective mode for the current session that intercepts destructive or hard-to-reverse bash operations and surfaces them for explicit confirmation before execution.

## Trigger

Apply when user requests:
- "careful", "careful mode", "enable safety guardrail", "guard mode"
- "warn before destructive commands", "小心模式", "開啟安全警告"
- Automatically pairs with `freeze` when user invokes `guard`

Do NOT trigger for:
- Read-only operations — no confirmation needed
- Cleanup of known build artifact directories — these are safe exceptions
- One-time destructive action the user already explicitly approved

## Prerequisites

- No setup required; activates immediately for the current session

## Steps

1. **Activate guardrail** — confirm to the user: "Careful mode is ON. I will pause and ask before any destructive command."

2. **Before each bash command, check** — scan the command against the protected patterns:

   | Pattern | Examples | Exception |
   |---------|---------|-----------|
   | Recursive delete | `rm -rf`, `rm -r` | Safe if path is in: `node_modules`, `.next`, `dist`, `build`, `__pycache__`, `.cache`, `.turbo`, `coverage`, `tmp` |
   | Database destroy | `DROP TABLE`, `TRUNCATE`, `DROP DATABASE` | None |
   | Git history rewrite | `git push --force`, `git push -f`, `git reset --hard`, `git rebase -i` | None |
   | Kubernetes delete | `kubectl delete`, `kubectl drain` | None |
   | Docker nuke | `docker rm -f`, `docker rmi -f`, `docker system prune`, `docker volume prune` | None |
   | Process kill | `kill -9`, `pkill -f` | None |

3. **If pattern matches** — stop before executing; present the command with a warning and ask: "⚠️ This command is destructive. Proceed? (yes / no / show alternatives)"

4. **If user confirms** — execute the command; log it as user-approved

5. **If user declines** — propose a safer alternative when one exists (e.g. `rm` → move to trash; `DROP TABLE` → `ALTER TABLE ... RENAME TO _backup`)

6. **Remain active** — careful mode persists for the full session; remind the user if they try to disable it mid-session without explicitly typing "disable careful"

## Output Format

```
⚠️ Careful mode intercepted a destructive command

Command: rm -rf ./data/production/
Risk: Permanently deletes ./data/production/ and all contents — not recoverable
Exception check: path is NOT a known build artifact directory

Proceed? (yes / no / show alternatives)
```

## Rules

### Must
- Intercept every command matching the protected patterns without exception
- Always show the full command before asking for confirmation — never summarize it
- Propose a safer alternative whenever one exists
- Persist for the entire session until explicitly disabled by the user

### Never
- Execute a matched destructive command without confirmation, even if the user seems impatient
- Apply the safe-exceptions list to paths that merely contain exception directory names (e.g. `../../node_modules_backup/production` is not exempt)
- Disable careful mode automatically — only the user can turn it off

## Examples

### Good Example

User runs: `rm -rf ./src/`

```
⚠️ Careful mode intercepted a destructive command

Command: rm -rf ./src/
Risk: Permanently deletes ./src/ — source code will be unrecoverable without git
Exception check: ./src/ is NOT a build artifact directory

Proceed? (yes / no / show alternatives)
> show alternatives
Alternative: git stash && git checkout -- ./src/   (restore to last commit instead)
```

### Bad Example

User runs: `rm -rf ./src/`

Claude executes immediately without warning, reasoning that "the user must have intended it."

> Why this is bad: careful mode exists precisely to catch commands where the user may not have fully considered the consequences. Silent execution defeats the entire purpose of the guardrail.
