# Agents

Subagent definitions for deployment to `.claude/agents/` in target projects.

Subagents run in **isolated context windows** with their own tool sets. They explore, analyze, or audit without polluting the main conversation context. Use them for any task that reads many files.

## Available Agents

| Agent | Model | Tools | Use for |
|-------|-------|-------|---------|
| `security-reviewer` | opus | Read, Grep, Glob | OWASP security audit, secret scanning, vulnerability review |
| `code-auditor` | sonnet | Read, Grep, Glob, Bash | Architecture review, dead code, complexity hotspots, test gaps |
| `researcher` | sonnet | Read, Grep, Glob, Bash | Investigate how features work, trace call paths, pre-implementation research |

## Usage

Invoke explicitly in conversation:
```
"Use the security-reviewer agent to audit src/api/"
"Use the researcher agent to investigate how auth token refresh works"
"Use the code-auditor agent to find complexity hotspots in the payments module"
```

## Deployment

Copy this `agents/` folder to `.claude/agents/` in the target project:
```bash
cp -r skill/agents/ .claude/agents/
```

## Deployment Template

See [deployment-template.md](deployment-template.md) for the full `.claude/` structure.
