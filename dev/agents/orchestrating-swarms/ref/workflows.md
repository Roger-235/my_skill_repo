# Complete Workflow Examples

## Workflow 1: Parallel Code Review

```javascript
// Setup
Teammate({ operation: "spawnTeam", team_name: "pr-review-123" })

// Spawn specialists in parallel (send all in one message)
Task({ team_name: "pr-review-123", name: "security", subagent_type: "general-purpose",
  prompt: `Review PR for security (SQL injection, XSS, auth bypass).
  Send findings: Teammate({ operation: "write", target_agent_id: "team-lead", value: "..." })`,
  run_in_background: true })

Task({ team_name: "pr-review-123", name: "perf", subagent_type: "general-purpose",
  prompt: "Review for performance (N+1, memory leaks). Send findings to team-lead.",
  run_in_background: true })

Task({ team_name: "pr-review-123", name: "arch", subagent_type: "general-purpose",
  prompt: "Review for architecture (SOLID, separation of concerns, testability). Send findings to team-lead.",
  run_in_background: true })

// Monitor: cat ~/.claude/teams/pr-review-123/inboxes/team-lead.json
// Synthesize findings, then:
Teammate({ operation: "requestShutdown", target_agent_id: "security" })
Teammate({ operation: "requestShutdown", target_agent_id: "perf" })
Teammate({ operation: "requestShutdown", target_agent_id: "arch" })
// Wait for approvals...
Teammate({ operation: "cleanup" })
```

## Workflow 2: Research → Plan → Implement → Test Pipeline

```javascript
Teammate({ operation: "spawnTeam", team_name: "feature-oauth" })

TaskCreate({ subject: "Research OAuth providers" })   // #1
TaskCreate({ subject: "Create implementation plan" }) // #2
TaskCreate({ subject: "Implement OAuth" })            // #3
TaskCreate({ subject: "Write tests" })                // #4
TaskCreate({ subject: "Final security review" })      // #5

TaskUpdate({ taskId: "2", addBlockedBy: ["1"] })
TaskUpdate({ taskId: "3", addBlockedBy: ["2"] })
TaskUpdate({ taskId: "4", addBlockedBy: ["3"] })
TaskUpdate({ taskId: "5", addBlockedBy: ["4"] })

Task({ team_name: "feature-oauth", name: "researcher", subagent_type: "Explore",
  prompt: "Claim task #1. Research OAuth2 best practices, compare providers. Mark complete, send summary to team-lead.",
  run_in_background: true })

Task({ team_name: "feature-oauth", name: "planner", subagent_type: "Plan",
  prompt: "Wait for task #2 to unblock. Read task #1 findings. Create implementation plan. Mark complete.",
  run_in_background: true })

Task({ team_name: "feature-oauth", name: "implementer", subagent_type: "general-purpose",
  prompt: "Wait for task #3 to unblock. Read plan from task #2. Implement OAuth2. Mark complete.",
  run_in_background: true })

Task({ team_name: "feature-oauth", name: "tester", subagent_type: "general-purpose",
  prompt: "Wait for task #4 to unblock. Write and run comprehensive tests. Mark complete with results.",
  run_in_background: true })
```

## Workflow 3: Self-Organizing Review Swarm

```javascript
Teammate({ operation: "spawnTeam", team_name: "codebase-review" })

// Create independent task pool
const files = [
  "app/models/user.rb", "app/models/payment.rb",
  "app/controllers/api/v1/users_controller.rb",
  "app/services/payment_processor.rb",
  "lib/encryption_helper.rb"
]
files.forEach(f => TaskCreate({ subject: `Review ${f}`, description: `Review ${f} for security, quality, and performance` }))

const swarmPrompt = `
You are a swarm worker. Loop until no tasks remain:
1. TaskList() — find pending task with no owner
2. If found:
   - TaskUpdate({ taskId: "X", owner: "$CLAUDE_CODE_AGENT_NAME" })
   - TaskUpdate({ taskId: "X", status: "in_progress" })
   - Do the review
   - TaskUpdate({ taskId: "X", status: "completed" })
   - Teammate({ operation: "write", target_agent_id: "team-lead", value: "Findings for X: ..." })
3. If no tasks: send idle notification to team-lead, wait 30s, retry 3x, then exit
`

Task({ team_name: "codebase-review", name: "worker-1", subagent_type: "general-purpose", prompt: swarmPrompt, run_in_background: true })
Task({ team_name: "codebase-review", name: "worker-2", subagent_type: "general-purpose", prompt: swarmPrompt, run_in_background: true })
Task({ team_name: "codebase-review", name: "worker-3", subagent_type: "general-purpose", prompt: swarmPrompt, run_in_background: true })

// Workers race to claim tasks — natural load balancing
// Monitor: TaskList() or check inbox
```
