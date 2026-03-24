#!/usr/bin/env bash
# post-edit-lint.sh — PostToolUse hook for Edit/Write tools
# Runs the project linter after every file edit (non-blocking feedback).
# Exit code 0 = always pass through; output is shown to Claude as context.
#
# Deploy: copy to .claude/hooks/post-edit-lint.sh in target project
# Register: add to .claude/settings.json (see hooks/settings.json)

set -euo pipefail

INPUT=$(cat)
FILE=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('file_path', d.get('filePath','')))" 2>/dev/null || echo "")

if [ -z "$FILE" ]; then
  exit 0
fi

EXT="${FILE##*.}"

case "$EXT" in
  ts|tsx|js|jsx|mjs|cjs)
    if [ -f "package.json" ] && command -v npx &>/dev/null; then
      # Run ESLint on just the changed file (fast)
      RESULT=$(npx eslint --no-eslintrc -c .eslintrc* "$FILE" 2>&1 | head -20 || true)
      if [ -n "$RESULT" ]; then
        echo "LINT (post-edit): $FILE"
        echo "$RESULT"
      fi
    fi
    ;;
  py)
    if command -v ruff &>/dev/null; then
      RESULT=$(ruff check "$FILE" 2>&1 | head -20 || true)
      if [ -n "$RESULT" ]; then
        echo "LINT (post-edit): $FILE"
        echo "$RESULT"
      fi
    elif command -v flake8 &>/dev/null; then
      RESULT=$(flake8 "$FILE" 2>&1 | head -20 || true)
      if [ -n "$RESULT" ]; then
        echo "LINT (post-edit): $FILE"
        echo "$RESULT"
      fi
    fi
    ;;
  go)
    if command -v golangci-lint &>/dev/null; then
      RESULT=$(golangci-lint run "$FILE" 2>&1 | head -20 || true)
      if [ -n "$RESULT" ]; then
        echo "LINT (post-edit): $FILE"
        echo "$RESULT"
      fi
    fi
    ;;
esac

exit 0
