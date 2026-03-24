---
name: spec-writer
description: "Spec-first methodology: converts a user request or feature idea into a structured specification document before any code is written. Clarifies scope, surfaces ambiguities, defines interface contracts, and produces a spec.md that gates implementation. Triggers: write a spec, spec first, define requirements, before coding, 寫規格, 先寫 spec, feature spec, technical spec."
metadata:
  category: dev
disable-model-invocation: true
---

## Purpose

Stop the habit of writing code before thinking. Transform vague requests into a precise, agreed-upon specification that answers scope, interface, risks, and success criteria — before a single line of implementation is produced.

## Trigger

Apply when:
- "write a spec", "spec first", "define requirements before coding", "先寫 spec"
- "technical spec", "feature spec", "design doc", "requirements document"
- User describes a feature and is about to start implementing immediately

Do NOT trigger for:
- Already-scoped tasks with clear implementation path — go straight to coding
- Retrospective documentation of finished work — use `document-release` instead
- Architecture design for large systems — use `senior-architect` instead

## Prerequisites

- User has described a feature, problem, or change to make
- No existing spec file for this feature (check for `spec.md` or `SPEC.md` in project root)

## Steps

### Step 1 — Extract and Clarify (max 5 questions)

Read the user's request. Identify the largest ambiguities — not exhaustive edge cases. Ask at most **5 targeted questions**:

1. Who is the user / what is the trigger?
2. What is the expected output / success state?
3. What is explicitly **out of scope**?
4. Are there performance, security, or compatibility constraints?
5. What does failure look like?

If the request is clear enough to answer all 5 already, skip directly to Step 2.

### Step 2 — Write the Spec Document

Produce a `spec.md` with these sections in order:

```
# [Feature Name] Spec

## Problem Statement
One paragraph: what problem does this solve and for whom?

## Goals
- [ ] Goal 1 (measurable)
- [ ] Goal 2

## Non-Goals
- Explicitly NOT doing X
- Explicitly NOT doing Y

## User Stories
As a [role], I want [action] so that [outcome].
(3–5 stories max)

## Interface Contract
### Input
### Output
### Errors / Edge Cases

## Technical Approach
High-level approach only (no implementation code). Include:
- Key components touched
- Data flow
- Dependencies introduced or removed

## Risks & Mitigations
| Risk | Likelihood | Impact | Mitigation |

## Success Criteria
How will we know this is done and correct?
- Automated: [specific tests / metrics]
- Manual: [specific user action to verify]

## Open Questions
Items still unresolved — must be answered before implementation starts.
```

### Step 3 — Self-Critique

Before presenting the spec, answer these adversarial questions internally:

- Does the Interface Contract fully define what callers need to know?
- Is every Goal measurable / verifiable?
- Are Non-Goals explicit enough to prevent scope creep?
- Is there at least one Success Criterion that is automated?

Revise any section that fails these checks.

### Step 4 — Save and Gate

Write the spec to `spec.md` in the project root (or `docs/specs/<feature-name>.md` if a `docs/` directory exists). End with:

> **Gate:** Implementation should not begin until Open Questions are resolved and the spec is acknowledged.

## Output Format

```markdown
# [Feature Name] Spec
_Status: DRAFT | APPROVED_
_Author: [git config user.name]_
_Date: [today]_

## Problem Statement
...

## Goals
...
[full spec body]

## Open Questions
- [ ] Q1
- [ ] Q2
```

## Rules

### Must
- Ask clarifying questions before writing if any of the 5 dimensions are unclear
- Every Goal must be measurable — reject "improve performance" without a metric
- Non-Goals section is mandatory — at minimum one explicit exclusion
- Every spec must have at least one automated Success Criterion
- Write spec to a file — do not only output to chat

### Never
- Never write implementation code in the spec — approach description only
- Never skip Non-Goals — their absence is the leading cause of scope creep
- Never mark a spec APPROVED — that is the user's decision, not Claude's
- Never produce a spec longer than 200 lines — if it exceeds this, split into sub-specs

## Examples

### Good Example

```markdown
# Payment Webhook Handler Spec
_Status: DRAFT_

## Problem Statement
Stripe sends webhook events (payment.succeeded, payment.failed) to our endpoint,
but we currently have no handler — payments succeed in Stripe but our DB never
updates. This causes orders to stay in PENDING state indefinitely.

## Goals
- [ ] Handle payment.succeeded: mark order PAID within 500ms of webhook receipt
- [ ] Handle payment.failed: mark order FAILED, trigger retry email
- [ ] Idempotent: duplicate webhook delivery must not double-update

## Non-Goals
- Refunds (covered by TICKET-200)
- Webhook signature rotation (handled by ops)

## Interface Contract
### Input: POST /api/webhooks/stripe
  Headers: Stripe-Signature (required)
  Body: Stripe event object (JSON)
### Output: HTTP 200 {} on success; HTTP 400 on invalid signature
### Errors: HTTP 500 logged + retried by Stripe (up to 3x)
```

### Bad Example

```
Let me just start coding the webhook handler. I'll figure out edge cases as I go.
```

> Why this is bad: No defined scope — refunds, retries, idempotency, and error handling are all undefined. Without a spec, each ambiguity discovered during coding causes rework and scope expansion.
