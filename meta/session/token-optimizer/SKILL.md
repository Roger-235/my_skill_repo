---
name: token-optimizer
description: "Analyzes context window usage and recommends token optimization strategies. Trigger when: token usage, optimize context, running out of context, context window full, token count, how much context left, Token 用量, 節省 token, 壓縮 context, context 快滿了."
metadata:
  category: meta
  version: "1.0"
---

# Token Optimizer

Estimates current context window usage, identifies the largest consumers, and recommends or applies optimization strategies before the context limit is reached.

## Purpose

Analyze the composition of the current conversation context, estimate token usage as a percentage of the model's context window, identify the top sources of token bloat, and recommend specific actions to reduce usage — getting user approval before discarding any content.

## Trigger

Apply when:
- User says "token usage", "optimize context", "running out of context", "context window full", "how much context left"
- "Token 用量", "節省 token", "壓縮 context", "context 快滿了"
- Proactively when estimated context usage exceeds 70%
- Before starting a large operation that will add significant tokens (e.g., reading many large files)

Do NOT trigger for:
- Normal conversations with low estimated context usage (below 50%)
- Contexts where no optimization is possible or needed

## Prerequisites

- Current conversation context accessible for analysis
- User available to approve specific optimization actions before they are executed

## Steps

1. **Estimate context usage** — calculate approximate token count for the current conversation:
   - English text: ~1 token per 4 characters
   - Chinese/CJK text: ~1 token per 1.5–2 characters
   - Code: ~1 token per 3–4 characters
   - Express total as both a raw estimate and a percentage of the model's context window (Claude claude-sonnet-4-6: ~200 000 tokens)

2. **Identify the largest consumers** — categorize and estimate each source:
   - Large file reads (file path and approximate token count)
   - Repeated content (same file read multiple times, repeated error logs)
   - Verbose tool outputs (long JSON responses, full stack traces)
   - Accumulated conversation history with low information density
   - Large code blocks already incorporated into files

3. **Assess urgency** — classify the current state:
   - Green (<50%): healthy, no action needed
   - Yellow (50–75%): monitor, consider preemptive optimization before adding more content
   - Red (>75%): act now before hitting the limit mid-task

4. **Recommend optimization strategy** — for each top consumer, recommend the appropriate action:
   - Already-used file reads: summarize to key sections or remove if no longer needed
   - Repeated identical content: remove duplicates, keep only the latest
   - Long error logs: trim to the last occurrence plus the first occurrence for comparison
   - Low-density history: use `/compact` to compress the full conversation
   - Large incorporated code: replace full content with a path reference

5. **Apply optimizations (with user approval)** — present the full recommendation list; wait for explicit user approval; execute only approved actions; never discard information without confirmation

6. **Report savings** — after applying optimizations, show estimated tokens before and after, and the percentage reduction achieved

## Output Format

File path: none (output printed to user)

```
## Token Usage Report

**Estimated usage:** ~X,XXX tokens (~Y% of context window)
**Status:** Green / Yellow / Red

### Top Consumers
| Source | Est. Tokens | % of Total | Recommended Action |
|--------|------------|-----------|-------------------|
| File read: src/auth.ts | ~2,400 | 12% | Summarize — already incorporated |
| Repeated error log | ~800 | 4% | Trim to last occurrence |
| Tool output: npm install | ~600 | 3% | Remove — task complete |

### Recommendation
<specific, prioritized list of actions>

**Projected savings:** ~X,XXX tokens (~Y% reduction)
**Projected usage after:** ~X,XXX tokens (~Z% of context window)

### Approval needed
Please confirm before I proceed:
- [ ] <action 1>
- [ ] <action 2>
```

## Rules

### Must
- Recommend `/compact` before estimated context usage reaches 80%
- Show specific sources of token bloat with individual estimates, not just a total
- Get explicit user approval before discarding or compressing any content
- Err on the side of overestimating token usage — it is safer to act early than to hit the limit during a critical operation

### Never
- Never discard any content from context without explicit user confirmation
- Never run `/compact` or any compression during a critical operation (mid-file-write, mid-generation, mid-tool-call)
- Never underestimate context usage to avoid triggering action — conservative estimates protect the user
- Never recommend removing content that may still be needed for the current task

## Examples

### Good Example

At estimated 72% context usage, optimizer identifies: a 3 000-token file read for `auth.ts` that has already been fully incorporated into the codebase (can be summarized), a 1 200-token repeated error log (keep last occurrence only), and a 500-token npm install output (no longer needed). Recommends `/compact` as the primary action. User approves. Context drops from ~72% to ~41%. Optimizer confirms: "Saved approximately 6 200 tokens. Context is now at ~41% — healthy for the remaining work."

### Bad Example

```
You're using a lot of tokens. Let me compact the context.
[runs /compact without asking]
OK, I've compressed the conversation. Some earlier context may be lost.
```

> Why this is bad: Ran `/compact` without showing the user what would be lost, without explicit approval, and without reporting which sources were consuming the most tokens. The user cannot make an informed decision, and potentially critical context may have been silently discarded.
