---
name: task-planner
description: "Breaks complex tasks into tracked, prioritized subtasks with TodoWrite integration. Trigger when: plan this task, break down task, create a plan, task decomposition, how should I approach this, 分解任務, 制定計畫, 任務規劃, 幫我規劃."
metadata:
  category: meta
  version: "1.0"
---

# Task Planner

Decomposes a complex goal into a dependency-ordered, prioritized list of atomic subtasks, then tracks progress with TodoWrite.

## Purpose

Break a complex goal into independent, atomic subtasks with clear done-conditions, identify dependencies and execution order, write all subtasks to TodoWrite, and begin execution in the correct sequence.

## Trigger

Apply when:
- User says "plan this task", "break down task", "create a plan", "task decomposition", "how should I approach this"
- "分解任務", "制定計畫", "任務規劃", "幫我規劃"
- Any task with more than 3 distinct steps that have not yet been decomposed
- Before beginning work on a complex multi-file or multi-system change

Do NOT trigger for:
- Simple single-step tasks completable in one response
- Tasks already fully decomposed with an existing todo list

## Prerequisites

- A clear goal statement from the user; if the goal is ambiguous, ask one focused clarifying question before planning
- TodoWrite tool available for creating and tracking subtasks

## Steps

1. **Clarify the goal** — if the goal is ambiguous or the done-condition is unclear, ask exactly one focused question to resolve the most critical ambiguity; confirm scope and the verifiable completion criterion before proceeding

2. **Decompose into subtasks** — break the goal into independent, atomic steps where each subtask:
   - Can be completed in one focused session (not "implement auth" but "implement JWT token generation")
   - Has a clear, verifiable done-condition (not "work on X" but "X passes all tests and is merged")
   - Does not bundle multiple distinct concerns into one step

3. **Identify dependencies** — for each subtask, identify which prior subtasks must be complete before it can start; draw the dependency chain explicitly

4. **Prioritize** — order by dependency first; among tasks with no dependencies, prioritize:
   - High-uncertainty or high-risk tasks first (validate assumptions early)
   - Foundation tasks before dependent tasks
   - Reversible tasks before irreversible ones

5. **Create todos** — write every subtask to TodoWrite with:
   - A clear, action-oriented title
   - The verifiable done-condition in the description
   - Priority level (high / medium / low)

6. **Begin execution** — start the first unblocked task immediately; update todo status to in-progress when starting and done when the done-condition is verified; re-plan explicitly if scope changes during execution

## Output Format

File path: none (output printed to user, todos written to TodoWrite)

```
## Task Plan: <goal>

**Goal:** <one-line restatement of the goal>
**Done when:** <verifiable completion criterion for the entire goal>

### Subtask List
| # | Subtask | Depends on | Priority | Done when |
|---|---------|-----------|----------|-----------|
| 1 | <subtask> | — | High | <verifiable condition> |
| 2 | <subtask> | 1 | Medium | <verifiable condition> |
| 3 | <subtask> | 1, 2 | Medium | <verifiable condition> |

### Execution Order
1. [Unblocked] <first task>
2. [Unblocked] <second independent task>
3. [After 1] <task dependent on 1>
4. [After 1, 2] <task dependent on both>

### Starting now: <first unblocked task>
```

## Rules

### Must
- Every subtask must have a verifiable done-condition — vague tasks like "work on X" are not acceptable
- Write all subtasks to TodoWrite before beginning execution so progress is always visible
- Re-plan explicitly and notify the user when scope changes — never silently add or remove tasks
- Ask exactly one clarifying question if the goal is ambiguous — do not ask multiple questions

### Never
- Never begin execution before the complete plan for the entire goal is written
- Never create subtasks so large they bundle multiple distinct concerns
- Never mix planning and execution in the same step — plan completely first, then execute
- Never mark a task done unless its stated done-condition has been verified

## Examples

### Good Example

User asks: "Build a user authentication system."

Planner identifies 6 subtasks: (1) Design database schema for users table, (2) Implement password hashing utility, (3) Implement JWT token generation and validation, (4) Build POST /register endpoint, (5) Build POST /login endpoint, (6) Write integration tests for all auth endpoints. Marks tests as depending on subtasks 4 and 5. Prioritizes schema first as the foundation. Creates 6 todos with clear done-conditions (e.g., "tests pass with >90% coverage"). Begins with subtask 1 immediately.

### Bad Example

```
Let me start building the auth system.
First I'll set up the database, then do the JWT stuff,
then build some endpoints and add tests.
```

> Why this is bad: No structured plan written before execution, no subtasks in TodoWrite, no done-conditions defined, dependencies are implicit not explicit, and work starts without user confirmation of scope. If the task is interrupted, there is no recoverable state.
