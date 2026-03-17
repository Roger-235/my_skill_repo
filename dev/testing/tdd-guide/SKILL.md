---
name: tdd-guide
description: "Test-driven development (TDD) workflow guide. Enforces red-green-refactor cycle and test-first mindset. Trigger when: TDD, test-driven development, write tests first, red-green-refactor, failing test first, test before implementation, 測試驅動開發, 先寫測試, 紅綠重構."
metadata:
  category: dev
  version: "1.0"
---

# TDD Guide

Enforces the red-green-refactor cycle so that every piece of functionality is driven by a failing test before implementation begins.

## Purpose

Enforce the red-green-refactor cycle so that every piece of functionality is driven by a failing test before implementation begins.

## Trigger

Apply when the user requests:
- "TDD", "test-driven", "write tests first", "red-green-refactor", "failing test first"
- "test before implementation", "test-driven development"
- "測試驅動開發", "先寫測試", "紅綠重構"

Do NOT trigger for:
- Adding tests to existing untested code — use code-quality instead
- Fixing a runtime bug — use debug instead

## Prerequisites

- A test framework must be set up (Jest, pytest, go test, RSpec, etc.)
- The feature requirement must be clearly stated before beginning

## Steps

1. **Write a failing test** — define exactly one behavior the code should have; run it to confirm it fails for the expected reason (not a setup error)
2. **Write minimal implementation** — write only enough code to make that one test pass; do not add extra logic or anticipate future requirements
3. **Run the full test suite** — confirm the new test passes and all existing tests still pass
4. **Refactor** — improve structure, naming, and clarity while keeping all tests green; do not add new behavior during this step
5. **Repeat** — return to Step 1 for the next requirement

## Output Format

```
## TDD Cycle: <feature name>

### Red — Failing Test
<test code>
Test result: FAIL — <expected failure reason>

### Green — Minimal Implementation
<implementation code>
Test result: PASS (X tests)

### Refactor
<improved code if changes were made, or "No structural changes needed">
Test result: PASS (X tests)
```

## Rules

### Must
- Write the test BEFORE writing any implementation code
- Each test must cover exactly one behavior
- The failing test must fail for the right reason — not a syntax or import error
- Run the full suite after every change (Red, Green, and Refactor steps)
- State the expected failure reason explicitly before showing the implementation

### Never
- Never write implementation before a failing test exists
- Never skip the refactor step — green tests do not mean clean code
- Never write tests that trivially always pass (e.g., `assert True`, `expect(1).toBe(1)`)
- Never test implementation details — test behavior from the caller's perspective
- Never add multiple behaviors to a single implementation step

## Examples

### Good Example

```
## TDD Cycle: email validation

### Red — Failing Test
\`\`\`python
def test_valid_email_returns_true():
    assert validate_email("user@example.com") is True
\`\`\`
Test result: FAIL — NameError: name 'validate_email' is not defined

### Green — Minimal Implementation
\`\`\`python
import re

def validate_email(email: str) -> bool:
    return bool(re.match(r"[^@]+@[^@]+\.[^@]+", email))
\`\`\`
Test result: PASS (1 test)

### Refactor
No structural changes needed.
Test result: PASS (1 test)
```

User then says "also reject emails without a TLD" → assistant returns to Step 1, writes a failing test for that specific case, then extends the implementation minimally.

### Bad Example

```
Here is the email validation function:

\`\`\`python
def validate_email(email):
    import re
    return bool(re.match(r"[^@]+@[^@]+\.[^@]+", email))
\`\`\`

And here are the tests to verify it works:

\`\`\`python
def test_validate_email():
    assert validate_email("user@example.com") is True
    assert validate_email("bad") is False
\`\`\`
```

> Why this is bad: Implementation was written before any test existed. The tests were written after the fact to confirm already-working code, which is not TDD — it is testing after the fact. There is no Red step, so there is no proof the test actually catches a failure.
