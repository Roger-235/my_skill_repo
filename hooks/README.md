# Hooks

PreToolUse / PostToolUse hook scripts for deployment to `.claude/hooks/` in target projects.

Hooks enforce rules at **100%** — unlike CLAUDE.md instructions (~70%). Use hooks for anything critical.

## Available Hooks

| Hook | Trigger | Type | Purpose |
|------|---------|------|---------|
| `careful-mode.sh` | Bash (PreToolUse) | Blocking (exit 2) | Block destructive commands: `rm -rf`, `DROP TABLE`, `git push --force`, `kubectl delete`, credential file reads |
| `protect-critical-files.sh` | Edit/Write (PreToolUse) | Blocking (exit 2) | Block direct edits to `settings.json`, `.env*` without explicit user confirmation |
| `post-edit-lint.sh` | Edit/Write (PostToolUse) | Non-blocking (exit 0) | Auto-lint after every file edit (ESLint / ruff / golangci-lint) |

## Deployment

```bash
# 1. Copy hooks to target project
mkdir -p .claude/hooks
cp skill/hooks/careful-mode.sh .claude/hooks/
cp skill/hooks/protect-critical-files.sh .claude/hooks/
cp skill/hooks/post-edit-lint.sh .claude/hooks/
chmod +x .claude/hooks/*.sh

# 2. Merge hook config into .claude/settings.json
# (copy the "hooks" block from hooks/settings.json into your settings.json)
```

## careful-mode.sh — Blocked Patterns

**Destructive (always blocked unless safe exception):**
- `rm -rf`, `rm -fr`
- `DROP TABLE`, `DROP DATABASE`, `TRUNCATE`
- `git push --force`, `git push -f`, `git reset --hard`
- `git clean -fd`, `git clean -fxd`
- `kubectl delete`, `kubectl apply --force`
- `docker system prune`, `docker volume prune`
- `kill -9`, `pkill -9`
- `chmod 777`, `chmod -R 777`
- `dd if=`, `mkfs.*`, `shred`, `wipe`

**Credential access (always blocked):**
- `~/.ssh/id_*`, `~/.aws/credentials`, `~/.npmrc`, `.env`
- `printenv | grep KEY/SECRET/TOKEN`
- `env | grep KEY/SECRET`

**Safe exceptions (never blocked even if matching above):**
`node_modules`, `.next`, `dist`, `__pycache__`, `coverage`, `.cache`, `tmp/`

## vs. `careful` skill

The `careful` skill (meta/session/careful) is an **intent guardrail** — it adds a confirmation step to Claude's reasoning. It works via CLAUDE.md instructions (~70% adherence).

This hook is **deterministic enforcement** — the shell script intercepts the Bash tool call before execution (100% adherence, cannot be bypassed by Claude).

Use both for defense in depth.
