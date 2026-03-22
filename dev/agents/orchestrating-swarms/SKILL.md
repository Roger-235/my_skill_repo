---
name: orchestrating-swarms
description: "Master multi-agent orchestration using Claude Code's TeammateTool and Task system. Trigger when: coordinating multiple agents, parallel code reviews, pipeline workflows with dependencies, self-organizing task queues, divide-and-conquer patterns, swarm agents, spawn subagent, multi-agent team, TeammateTool, run agents in parallel. Do NOT trigger for single-agent tasks or simple sequential work that doesn't need coordination."
metadata:
  category: dev
  version: "1.0"
  format: github-imported
---

# Claude Code Swarm Orchestration

Master multi-agent orchestration using Claude Code's TeammateTool and Task system.

---

## Primitives

| Primitive | What It Is | Location |
|-----------|-----------|----------|
| **Agent** | A Claude instance that can use tools | N/A (process) |
| **Team** | Named group of agents. One leader, multiple teammates | `~/.claude/teams/{name}/config.json` |
| **Teammate** | Agent that joined a team. Has name, color, inbox | Listed in team config |
| **Leader** | Agent that created the team. Receives messages, approves plans | First member in config |
| **Task** | Work item with subject, status, owner, dependencies | `~/.claude/tasks/{team}/N.json` |
| **Inbox** | JSON file where agent receives messages | `~/.claude/teams/{name}/inboxes/{agent}.json` |

## Two Ways to Spawn Agents

### Method 1: Task Tool (Subagents — short-lived)

```javascript
Task({
  subagent_type: "Explore",      // Explore | Plan | general-purpose | Bash | claude-code-guide
  description: "Find auth files",
  prompt: "Find all authentication-related files in this codebase",
  model: "haiku"                 // optional: haiku | sonnet | opus
})
```

Runs synchronously (or async with `run_in_background: true`). Returns result directly. No team needed.

### Method 2: Task + team_name + name (Teammates — persistent)

```javascript
Teammate({ operation: "spawnTeam", team_name: "my-project" })

Task({
  team_name: "my-project",
  name: "security-reviewer",
  subagent_type: "general-purpose",
  prompt: "Review all authentication code for vulnerabilities. Send findings to team-lead via Teammate write.",
  run_in_background: true
})
```

Joins team, communicates via inbox, can claim tasks from shared list, persists until shutdown.

### Key Difference

| Aspect | Subagent | Teammate |
|--------|----------|---------|
| Lifespan | Until task complete | Until shutdown |
| Communication | Return value | Inbox messages |
| Task access | None | Shared task list |
| Best for | One-off work | Parallel / pipeline |

## Built-in Agent Types

| Type | Tools | Best For |
|------|-------|---------|
| `Bash` | Bash only | Git ops, system tasks |
| `Explore` | Read-only | Codebase search, analysis |
| `Plan` | Read-only | Architecture planning |
| `general-purpose` | All tools | Multi-step, research + action |
| `claude-code-guide` | Read + WebFetch | Claude Code questions |

## Task System

```javascript
TaskCreate({ subject: "Review auth module", description: "...", activeForm: "Reviewing..." })
TaskList()                                        // see all tasks
TaskUpdate({ taskId: "2", owner: "worker-1" })    // claim
TaskUpdate({ taskId: "2", status: "in_progress" })
TaskUpdate({ taskId: "2", status: "completed" })
TaskUpdate({ taskId: "3", addBlockedBy: ["2"] })  // dependency
```

When a blocking task completes → blocked tasks auto-unblock.

## Orchestration Patterns (Quick Reference)

| Pattern | When to Use |
|---------|------------|
| **Parallel Specialists** | Multiple reviewers on same code simultaneously |
| **Pipeline** | Sequential stages with dependencies (research → plan → implement → test) |
| **Swarm** | Pool of independent tasks, workers race to claim |
| **Research + Implement** | Sync research → feed results to implementation agent |
| **Plan Approval** | Require leader sign-off before agent proceeds |
| **Multi-File Refactor** | Parallel file edits with merge dependency |

Full pattern code: `${CLAUDE_SKILL_DIR}/ref/patterns.md`

## Shutdown Sequence (Always Follow)

```javascript
Teammate({ operation: "requestShutdown", target_agent_id: "worker-1" })
// Wait for {"type": "shutdown_approved"} in inbox
Teammate({ operation: "cleanup" })  // ONLY after all approvals
```

## Spawn Backends

Auto-detected based on environment:

| Backend | When | Visibility |
|---------|------|-----------|
| `in-process` | Not in tmux (default) | Hidden |
| `tmux` | Inside tmux session | Visible panes |
| `iterm2` | In iTerm2 + it2 installed | Visible split panes |

Force: `export CLAUDE_CODE_SPAWN_BACKEND=tmux`

## Best Practices

- **Use meaningful names:** `security-reviewer` not `worker-1`
- **Prefer `write` over `broadcast`:** broadcast sends N messages for N teammates
- **Set task dependencies:** let the system unblock automatically
- **Always cleanup:** call `Teammate cleanup` when done
- **Match agent type to task:** `Explore` for search, `Plan` for design, `general-purpose` for implementation

## Reference Files

Full operation specs, code examples, and complete workflow templates:

- `${CLAUDE_SKILL_DIR}/ref/operations.md` — All 13 TeammateTool operations with parameters
- `${CLAUDE_SKILL_DIR}/ref/patterns.md` — 6 orchestration patterns with full code
- `${CLAUDE_SKILL_DIR}/ref/workflows.md` — 3 complete end-to-end workflow examples
- `${CLAUDE_SKILL_DIR}/ref/backends.md` — Spawn backend setup, detection logic, troubleshooting

---

*Source: [kieranklaassen/claude-code-swarm-orchestration](https://gist.github.com/kieranklaassen/4f2aba89594a4aea4ad64d753984b2ea) — Tested on Claude Code v2.1.19*
