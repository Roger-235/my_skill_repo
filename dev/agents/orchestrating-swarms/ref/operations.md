# TeammateTool Operations Reference

## spawnTeam
```javascript
Teammate({ operation: "spawnTeam", team_name: "feature-auth", description: "Implementing OAuth2" })
```
Creates team config + tasks directory. You become leader.

## discoverTeams / requestJoin / approveJoin / rejectJoin
```javascript
Teammate({ operation: "discoverTeams" })
Teammate({ operation: "requestJoin", team_name: "feature-auth", proposed_name: "helper", capabilities: "code review" })
Teammate({ operation: "approveJoin", target_agent_id: "helper", request_id: "join-123" })
Teammate({ operation: "rejectJoin", target_agent_id: "helper", request_id: "join-123", reason: "At capacity" })
```

## write — Message One Teammate
```javascript
Teammate({ operation: "write", target_agent_id: "security-reviewer", value: "Prioritize auth module." })
```
**Important:** Your text output is NOT visible to teammates. You MUST use `write` to communicate.

## broadcast — Message ALL Teammates
```javascript
Teammate({ operation: "broadcast", name: "team-lead", value: "Status check: report progress" })
```
⚠️ Expensive — sends N messages for N teammates. Prefer `write`. Use only for critical team-wide announcements.

## requestShutdown / approveShutdown / rejectShutdown
```javascript
// Leader requests shutdown
Teammate({ operation: "requestShutdown", target_agent_id: "worker-1", reason: "All tasks complete" })

// Teammate approves (sends confirmation + terminates process)
Teammate({ operation: "approveShutdown", request_id: "shutdown-123" })

// Teammate rejects (still working)
Teammate({ operation: "rejectShutdown", request_id: "shutdown-123", reason: "Still on task #3" })
```

## approvePlan / rejectPlan
```javascript
// After receiving {"type": "plan_approval_request", "requestId": "plan-456", ...}
Teammate({ operation: "approvePlan", target_agent_id: "architect", request_id: "plan-456" })
Teammate({ operation: "rejectPlan", target_agent_id: "architect", request_id: "plan-456",
  feedback: "Add error handling for API calls" })
```

## cleanup
```javascript
Teammate({ operation: "cleanup" })
```
Removes team config + tasks directory. **Will fail if teammates still active** — always `requestShutdown` first.

---

## Message Types (received in inbox)

| Type | When | Required Response |
|------|------|-----------------|
| `shutdown_request` | Leader asks you to exit | `approveShutdown` or `rejectShutdown` |
| `plan_approval_request` | Leader reviewing your plan | `approvePlan` or `rejectPlan` |
| `join_request` | Agent wants to join team | `approveJoin` or `rejectJoin` |
| `idle_notification` | Teammate stopped working | No response required |
| `task_completed` | Teammate finished a task | No response required |
| `shutdown_approved` | Teammate confirmed shutdown | Ready to cleanup |

---

## Debugging

```bash
cat ~/.claude/teams/{team}/config.json | jq '.members[] | {name, agentType}'
cat ~/.claude/teams/{team}/inboxes/team-lead.json | jq '.'
cat ~/.claude/tasks/{team}/*.json | jq '{id, subject, status, owner}'
ls ~/.claude/teams/
```
