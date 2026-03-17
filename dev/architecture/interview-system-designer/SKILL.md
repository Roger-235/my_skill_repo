---
name: interview-system-designer
description: "This skill should be used when the user asks to \"design interview processes\", \"create hiring pipelines\", \"calibrate interview loops\", \"generate interview questions\", \"design competency matrices\", \"analyze interviewer bias\", \"create scoring rubrics\", \"build question banks\", or \"optimize hiring systems\". Use for designing role-specific interview loops, competency assessments, and hiring calibration systems."
metadata:
  category: dev
  version: "1.0"
---

# Interview System Designer

Comprehensive interview loop planning and calibration support for role-based hiring systems.

## Purpose

Design structured interview loops, competency matrices, and calibration systems for role-based hiring with bias-reduction and scoring consistency.

## Trigger

Apply when the user requests:
- "design interview process", "create hiring pipeline", "calibrate interview loop"
- "generate interview questions", "design competency matrix", "create scoring rubric"
- "build question bank", "optimize hiring system", "interview loop planning"
- "analyze interviewer bias", "hiring calibration"

Do NOT trigger for:
- System architecture design — use `senior-architect`
- General HR policy questions outside interview loop design

## Prerequisites

- Python 3.x installed: run `python3 --version` to verify
- Role and level must be specified (e.g., "Senior Software Engineer", "Product Manager — mid-level")
- Script available: `scripts/interview_planner.py`

## Steps

1. **Run the loop planner** — execute `python3 scripts/interview_planner.py --role "<role>" --level <junior|mid|senior>` to generate a baseline interview loop
2. **Align rounds to competencies** — map each interview round to role-specific competencies using `references/competency_matrix_templates.md`
3. **Define scoring rubrics** — ensure each round has a standardized scoring rubric; validate consistency with `references/interview-frameworks.md`
4. **Review for bias controls** — apply `references/bias_mitigation_checklist.md` before finalizing the loop design
5. **Output the loop plan** — present the structured loop in the Output Format below
6. **Schedule recalibration** — recommend a quarterly recalibration cycle using hiring outcome data

## Output Format

```
### Interview Loop: <Role> — <Level>

**Rounds**: <count>

| Round | Focus | Duration | Interviewer |
|-------|-------|----------|-------------|
| 1 | <competency> | <min> | <role> |

**Scoring Rubric**: <link or summary>

**Bias Controls Applied**:
- <control>

**Recalibration Schedule**: Quarterly, based on quality-of-hire data
```

## Rules

### Must
- Require evidence for every score recommendation — no purely subjective ratings
- Use the same baseline rubric across comparable roles
- Apply at least one bias mitigation control from the checklist for every loop design
- Recommend a recalibration schedule with every loop delivered

### Never
- Never design an unstructured interview round without a standardized scoring rubric
- Never overweight a single round at the expense of other competency signals
- Never change the hiring bar without documenting rationale in the loop design

## Examples

### Good Example

```bash
python3 scripts/interview_planner.py --role "Senior Software Engineer" --level senior
# → 5-round loop: resume screen, technical phone, system design, coding, cultural fit
# → Each round has explicit competencies, time allocation, and scoring rubric
# → Bias checklist applied: structured questions, blind resume review noted
```

### Bad Example

```
"Interview them for a few hours and see if you like them."
```

> Why this is bad: No structured rounds, no competency mapping, no scoring rubric, no bias controls. Cannot produce consistent hiring signal across interviewers.

## Overview

Use this skill to create structured interview loops, standardize question quality, and keep hiring signal consistent across interviewers.

Use this skill to create structured interview loops, standardize question quality, and keep hiring signal consistent across interviewers.

## Core Capabilities

- Interview loop planning by role and level
- Round-by-round focus and timing recommendations
- Suggested question sets by round type
- Framework support for scoring and calibration
- Bias-reduction and process consistency guidance

## Quick Start

```bash
# Generate a loop plan for a role and level
python3 scripts/interview_planner.py --role "Senior Software Engineer" --level senior

# JSON output for integration with internal tooling
python3 scripts/interview_planner.py --role "Product Manager" --level mid --json
```

## Recommended Workflow

1. Run `scripts/interview_planner.py` to generate a baseline loop.
2. Align rounds to role-specific competencies.
3. Validate scoring rubric consistency with interview panel leads.
4. Review for bias controls before rollout.
5. Recalibrate quarterly using hiring outcome data.

## References

- `references/interview-frameworks.md`
- `references/bias_mitigation_checklist.md`
- `references/competency_matrix_templates.md`
- `references/debrief_facilitation_guide.md`

## Common Pitfalls

- Overweighting one round while ignoring other competency signals
- Using unstructured interviews without standardized scoring
- Skipping calibration sessions for interviewers
- Changing hiring bar without documenting rationale

## Best Practices

1. Keep round objectives explicit and non-overlapping.
2. Require evidence for each score recommendation.
3. Use the same baseline rubric across comparable roles.
4. Revisit loop design based on quality-of-hire outcomes.
