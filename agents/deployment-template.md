# Deployment Template

Copy this structure to deploy the skill library to any project.

## .claude/ Directory Structure

```
.claude/
├── CLAUDE.md              ← project rules (use template below)
├── skill/                 ← copy from skill repo categories
│   ├── dev/
│   ├── meta/
│   ├── security/
│   └── ...
├── agents/                ← copy from skill repo agents/
│   ├── security-reviewer.md
│   ├── code-auditor.md
│   └── researcher.md
├── hooks/                 ← copy from skill repo hooks/
│   ├── careful-mode.sh
│   ├── protect-critical-files.sh
│   └── post-edit-lint.sh
└── settings.json          ← hook registration (merge with existing)
```

## CLAUDE.md Starter Template

```markdown
# [Project Name]

## Stack
[e.g. Next.js 15 / TypeScript / PostgreSQL / Prisma]

## Commands
- Dev:   `npm run dev`
- Test:  `npm test`
- Build: `npm run build`
- Lint:  `npm run lint`

## Conventions
- Conventional Commits (feat/fix/chore/docs/refactor)
- PRs require a description — use `/pr-description-writer`
- Specs before implementation — use `/spec-writer`

## Skills
@.claude/skill/dev/_index.md
@.claude/skill/meta/_index.md

## Agents
Available agents (invoke explicitly):
- security-reviewer: security audit of any scope
- code-auditor: architecture + dead code + complexity review
- researcher: investigate how any part of the codebase works
```

**Pruning rule:** for every line in your CLAUDE.md, ask:
> "Would removing this cause Claude to make a mistake?"
> No → delete it. Yes → keep it.

## Quick Deploy Script

```bash
#!/usr/bin/env bash
# Run from the skill repo root
TARGET=${1:-.}  # default: current directory

mkdir -p "$TARGET/.claude/skill"
mkdir -p "$TARGET/.claude/agents"
mkdir -p "$TARGET/.claude/hooks"

# Copy skills (choose categories you need)
cp -r dev/ meta/ security/ "$TARGET/.claude/skill/"

# Copy agents
cp agents/security-reviewer.md agents/code-auditor.md agents/researcher.md "$TARGET/.claude/agents/"

# Copy hooks
cp hooks/careful-mode.sh hooks/protect-critical-files.sh hooks/post-edit-lint.sh "$TARGET/.claude/hooks/"
chmod +x "$TARGET/.claude/hooks/"*.sh

echo "Deployed to $TARGET/.claude/"
echo "Next: copy CLAUDE.md template from agents/deployment-template.md"
echo "Next: merge hooks/settings.json into $TARGET/.claude/settings.json"
```

## settings.json Hook Registration

Merge this into your existing `.claude/settings.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "bash .claude/hooks/careful-mode.sh"
          }
        ]
      },
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "bash .claude/hooks/protect-critical-files.sh"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "bash .claude/hooks/post-edit-lint.sh"
          }
        ]
      }
    ]
  }
}
```
