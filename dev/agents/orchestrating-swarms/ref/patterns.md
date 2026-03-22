# Orchestration Patterns

## Pattern 1: Parallel Specialists

Multiple specialists review code simultaneously.

```javascript
Teammate({ operation: "spawnTeam", team_name: "code-review" })

Task({ team_name: "code-review", name: "security", subagent_type: "general-purpose",
  prompt: "Review the PR for security vulnerabilities (SQL injection, XSS, auth bypass). Send findings to team-lead.", run_in_background: true })

Task({ team_name: "code-review", name: "performance", subagent_type: "general-purpose",
  prompt: "Review for performance issues (N+1 queries, memory leaks). Send findings to team-lead.", run_in_background: true })

Task({ team_name: "code-review", name: "simplicity", subagent_type: "general-purpose",
  prompt: "Review for unnecessary complexity (over-engineering, YAGNI violations). Send findings to team-lead.", run_in_background: true })

// Check inbox: cat ~/.claude/teams/code-review/inboxes/team-lead.json
// Shutdown all, then:
Teammate({ operation: "cleanup" })
```

## Pattern 2: Pipeline (Sequential Dependencies)

```javascript
Teammate({ operation: "spawnTeam", team_name: "feature-pipeline" })

TaskCreate({ subject: "Research", description: "Research best practices" })    // #1
TaskCreate({ subject: "Plan", description: "Create implementation plan" })     // #2
TaskCreate({ subject: "Implement", description: "Implement the feature" })     // #3
TaskCreate({ subject: "Test", description: "Write and run tests" })            // #4

TaskUpdate({ taskId: "2", addBlockedBy: ["1"] })
TaskUpdate({ taskId: "3", addBlockedBy: ["2"] })
TaskUpdate({ taskId: "4", addBlockedBy: ["3"] })

Task({ team_name: "feature-pipeline", name: "researcher", subagent_type: "Explore",
  prompt: "Claim task #1, research best practices, complete it, send findings to team-lead.", run_in_background: true })

Task({ team_name: "feature-pipeline", name: "implementer", subagent_type: "general-purpose",
  prompt: "Poll TaskList. When task #3 unblocks, claim it and implement. Complete and notify team-lead.", run_in_background: true })
```

## Pattern 3: Swarm (Self-Organizing)

Workers grab available tasks from a pool — natural load balancing.

```javascript
Teammate({ operation: "spawnTeam", team_name: "review-swarm" })

// Create pool of independent tasks
const files = ["auth.rb", "user.rb", "api_controller.rb", "payment.rb"]
files.forEach(f => TaskCreate({ subject: `Review ${f}`, description: `Review ${f} for security and quality` }))

const swarmPrompt = `
You are a swarm worker. Loop:
1. TaskList() → find pending task with no owner
2. TaskUpdate({ taskId, owner: "$CLAUDE_CODE_AGENT_NAME" }) → claim
3. TaskUpdate({ taskId, status: "in_progress" })
4. Do the work
5. TaskUpdate({ taskId, status: "completed" })
6. Teammate write findings to team-lead
7. Repeat until no tasks remain → send idle notification
`

Task({ team_name: "review-swarm", name: "worker-1", subagent_type: "general-purpose", prompt: swarmPrompt, run_in_background: true })
Task({ team_name: "review-swarm", name: "worker-2", subagent_type: "general-purpose", prompt: swarmPrompt, run_in_background: true })
Task({ team_name: "review-swarm", name: "worker-3", subagent_type: "general-purpose", prompt: swarmPrompt, run_in_background: true })
```

## Pattern 4: Research + Implementation

```javascript
// Synchronous research — returns result
const research = await Task({
  subagent_type: "Explore",
  description: "Research caching patterns",
  prompt: "Research best practices for caching in Rails APIs. Include: cache invalidation, Redis vs Memcached, cache key design."
})

// Feed research into implementation
Task({
  subagent_type: "general-purpose",
  description: "Implement caching",
  prompt: `Implement API caching based on this research:\n${research.content}\nFocus on user_controller.rb endpoints.`
})
```

## Pattern 5: Plan Approval Workflow

```javascript
Teammate({ operation: "spawnTeam", team_name: "careful-work" })

Task({ team_name: "careful-work", name: "architect", subagent_type: "Plan",
  prompt: "Design implementation plan for OAuth2 authentication", mode: "plan", run_in_background: true })

// Receive: {"type": "plan_approval_request", "from": "architect", "requestId": "plan-xxx", ...}

Teammate({ operation: "approvePlan", target_agent_id: "architect", request_id: "plan-xxx" })
// OR
Teammate({ operation: "rejectPlan", target_agent_id: "architect", request_id: "plan-xxx",
  feedback: "Add rate limiting considerations" })
```

## Pattern 6: Coordinated Multi-File Refactoring

```javascript
Teammate({ operation: "spawnTeam", team_name: "refactor-auth" })

TaskCreate({ subject: "Refactor User model", description: "Extract auth methods to concern" })      // #1
TaskCreate({ subject: "Refactor Session controller", description: "Update to use concern" })        // #2
TaskCreate({ subject: "Update specs", description: "Update all auth specs" })                       // #3

// Specs depend on BOTH refactors
TaskUpdate({ taskId: "3", addBlockedBy: ["1", "2"] })

Task({ team_name: "refactor-auth", name: "model-worker", subagent_type: "general-purpose",
  prompt: "Claim task #1, refactor User model, complete when done", run_in_background: true })

Task({ team_name: "refactor-auth", name: "controller-worker", subagent_type: "general-purpose",
  prompt: "Claim task #2, refactor Session controller, complete when done", run_in_background: true })

Task({ team_name: "refactor-auth", name: "spec-worker", subagent_type: "general-purpose",
  prompt: "Wait for task #3 to unblock (needs #1 and #2 complete), then update specs", run_in_background: true })
```
