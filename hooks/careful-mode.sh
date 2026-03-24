#!/usr/bin/env bash
# careful-mode.sh — PreToolUse hook for Bash tool
# Blocks destructive commands and requires confirmation before proceeding.
# Exit code 2 = block the tool call and return the message to Claude.
#
# Deploy: copy to .claude/hooks/careful-mode.sh in target project
# Register: add to .claude/settings.json (see hooks/settings.json)

set -euo pipefail

# Read the tool input JSON from stdin
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('command',''))" 2>/dev/null || echo "")

# ── Safe exceptions (never block these) ──────────────────────────────────────
SAFE_PATTERNS=(
  "node_modules"
  ".next"
  "dist"
  "__pycache__"
  "coverage"
  ".cache"
  "tmp/"
  "/tmp/"
)

is_safe_exception() {
  local cmd="$1"
  for pattern in "${SAFE_PATTERNS[@]}"; do
    # Use -w (whole-word) and -F (fixed-string) to prevent substring bypass
    # e.g. "node_modules_backup" must NOT match the "node_modules" pattern
    if echo "$cmd" | grep -qwF "$pattern"; then
      return 0
    fi
  done
  return 1
}

# ── Destructive patterns ──────────────────────────────────────────────────────
DESTRUCTIVE_PATTERNS=(
  "rm -rf"
  "rm -fr"
  "DROP TABLE"
  "DROP DATABASE"
  "TRUNCATE"
  "git push --force"
  "git push -f"
  "git reset --hard"
  "git clean -fd"
  "git clean -fxd"
  "kubectl delete"
  "kubectl apply.*--force"
  "docker system prune"
  "docker volume prune"
  "docker network prune"
  "kill -9"
  "pkill -9"
  "chmod -R 777"
  "chmod 777"
  "dd if="
  "mkfs\."
  "format [A-Z]:"
  "> /dev/"
  "shred"
  "wipe"
)

# Check each destructive pattern
for pattern in "${DESTRUCTIVE_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qiE "$pattern"; then
    # Allow safe exceptions
    if is_safe_exception "$COMMAND"; then
      exit 0
    fi

    # Block and return explanation
    cat << EOF
CAREFUL MODE BLOCKED

Command: $COMMAND
Matched pattern: $pattern

This command is potentially destructive and has been blocked by careful-mode.
To proceed, the user must explicitly confirm this action.

Action required: Tell the user what you are about to run and ask for explicit confirmation before attempting again.
EOF
    exit 2
  fi
done

# Secret detection — block commands that read credential files
SECRET_PATTERNS=(
  "~/.ssh/id_"
  "~/.aws/credentials"
  "~/.npmrc"
  "\.env\b"
  "cat.*password"
  "cat.*secret"
  "cat.*token"
  "printenv.*KEY"
  "printenv.*SECRET"
  "printenv.*TOKEN"
  "env | grep.*KEY"
  "env | grep.*SECRET"
)

for pattern in "${SECRET_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qiE "$pattern"; then
    cat << EOF
CAREFUL MODE BLOCKED — CREDENTIAL ACCESS

Command: $COMMAND
Matched: credential/secret file access pattern

This command may expose sensitive credentials. Blocked by careful-mode.
If this is intentional, ask the user for explicit confirmation.
EOF
    exit 2
  fi
done

exit 0
