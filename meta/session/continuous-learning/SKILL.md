---
name: continuous-learning
description: "Extracts reusable patterns from conversations and saves them to the persistent memory system. Trigger when: remember this pattern, save this approach, learn from this, this is how I want it done, 記住這個模式, 記下來, 學習記憶, 以後都這樣做."
metadata:
  category: meta
  version: "1.0"
---

# Continuous Learning

Identifies reusable patterns from the current conversation and persists them to the memory system so Claude applies them proactively in future sessions.

## Purpose

Extract a reusable rule or preference from the current conversation, check for duplicates, classify and write it to the memory system with proper metadata, and update the memory index so the pattern fires at the right time in future sessions.

## Trigger

Apply when:
- User says "remember this pattern", "save this approach", "learn from this", "this is how I want it done"
- "記住這個模式", "記下來", "學習記憶", "以後都這樣做"
- After a novel problem is solved in a way that is clearly intended to recur
- After the user corrects Claude's behavior and the correction is likely to apply again

Do NOT trigger for:
- Ephemeral task details specific to a one-time job (e.g., "today's meeting is at 3pm")
- One-time bug fixes that are unlikely to recur
- Information already documented in CLAUDE.md
- Code snippets or implementation details (those belong in the codebase, not memory)

## Prerequisites

- Access to the memory directory: `/home/roger/.claude/projects/` (or the project-specific memory path)
- A `MEMORY.md` index file in the memory directory
- The pattern must be genuinely reusable — applicable in future sessions, not just this one

## Steps

1. **Identify the pattern** — state the reusable rule clearly and abstractly; it must describe a behavior applicable across future sessions, not a one-time fix; if the trigger was a correction, capture both the old behavior and the desired new behavior

2. **Check for duplicates** — read the `MEMORY.md` index; search for any existing memory with similar content; if a closely related memory exists, update it rather than creating a duplicate; report to the user if updating vs. creating

3. **Classify the memory type** — choose one:
   - `user` — a stated user preference (style, communication, format)
   - `feedback` — a correction to Claude's behavior (must include why)
   - `project` — context specific to a project or codebase
   - `reference` — factual reference material to recall later

4. **Write the memory file** — create a new file in the memory directory with:
   - Frontmatter: `name`, `description`, `type`
   - Body for `feedback` and `project` types: `**Rule:**`, `**Why:**`, `**How to apply:**`
   - Body for `user` type: description of the preference and when to apply it
   - Body for `reference` type: the reference content with context

5. **Update the MEMORY.md index** — add a single-line entry: memory name, type, and one-line description; keep the index in alphabetical order by name

6. **Confirm to user** — report: what was saved, the memory type, the file path, and when this memory will trigger in future sessions

## Output Format

File path: memory file written to `/home/roger/.claude/projects/<project>/<memory-name>.md` and index updated in `MEMORY.md`

```
## Memory Saved

**Type:** <user / feedback / project / reference>
**Name:** <memory-name>
**File:** <absolute path to memory file>

**Pattern:** <the reusable rule in one sentence>
**Why:** <why this pattern matters or why the old behavior was wrong>
**When to apply:** <specific trigger condition for future sessions>
```

## Rules

### Must
- Check for existing memories before creating a new one — duplicate memories cause conflicting behavior
- Always include a "When to apply" trigger so the memory fires at the right time, not on every turn
- Feedback memories must record WHY the feedback was given — without rationale, the rule cannot be applied with judgment
- Update `MEMORY.md` index after every memory write

### Never
- Never save ephemeral task details — only patterns that will recur across future sessions
- Never save code snippets as memories — those belong in the codebase
- Never save things already documented in CLAUDE.md — that creates conflicting sources of truth
- Never save negative judgements about the user's character or competence
- Never create a new memory if an update to an existing memory is sufficient

## Examples

### Good Example

User corrects Claude: "Don't use mocks in our integration tests — we got burned when the mocks diverged from real API behavior and we shipped a bug."

Continuous-learning: identifies this as a `feedback` type. Checks MEMORY.md — no similar memory exists. Writes memory file: Rule = "Do not use mocks in integration tests for this project", Why = "Past incident where mock diverged from real API behavior, causing a production bug", How to apply = "When writing test code for this project, use real service instances or a test database instead of mocks". Updates MEMORY.md index. Reports to user: "Saved feedback memory 'no-mocks-integration-tests'. This will apply whenever I write test code in this project."

### Bad Example

```
Got it! I'll remember that you're working on the auth feature
and prefer spaces over tabs.
```

> Why this is bad: "Working on the auth feature" is ephemeral (not reusable). "Spaces over tabs" is a valid preference but was not written to the memory system — it only exists in the current context and will be forgotten. No memory file was created, no index was updated, and there is no confirmation of what was actually persisted.
