#!/usr/bin/env bash
# protect-critical-files.sh — PreToolUse hook for Edit and Write tools
# Blocks direct edits to critical config files without explicit user confirmation.
# Exit code 2 = block the tool call.
#
# Deploy: copy to .claude/hooks/protect-critical-files.sh in target project
# Register: add to .claude/settings.json (see hooks/settings.json)

set -euo pipefail

INPUT=$(cat)
FILE=$(echo "$INPUT" | python3 -c "
import sys, json
d = json.load(sys.stdin)
print(d.get('file_path', d.get('filePath', d.get('path', ''))))
" 2>/dev/null || echo "")

if [ -z "$FILE" ]; then
  exit 0
fi

# Normalize path
BASENAME=$(basename "$FILE")
RELPATH=$(echo "$FILE" | sed 's|.*/\.claude/||')

# Critical files that should never be auto-edited
CRITICAL_FILES=(
  "settings.json"
  "settings.local.json"
  ".env"
  ".env.local"
  ".env.production"
)

for critical in "${CRITICAL_FILES[@]}"; do
  if [ "$BASENAME" = "$critical" ] && [ -f "$FILE" ]; then
    cat << EOF
PROTECTED FILE — EDIT BLOCKED

File: $FILE
This is a critical configuration file ($critical).

Direct edits to $critical are blocked to prevent accidental misconfiguration.

To proceed, the user must explicitly confirm:
  "Yes, please edit $BASENAME"

Do not retry without explicit user confirmation.
EOF
    exit 2
  fi
done

# Also block writes to .claude/settings.json regardless of depth (only if file exists)
if echo "$FILE" | grep -q "\.claude/settings" && [ -f "$FILE" ]; then
  cat << EOF
PROTECTED FILE — EDIT BLOCKED

File: $FILE
Modifications to Claude settings files are blocked.

To proceed, the user must explicitly confirm this change.
EOF
  exit 2
fi

exit 0
