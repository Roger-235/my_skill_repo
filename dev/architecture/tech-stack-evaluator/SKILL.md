---
name: tech-stack-evaluator
description: "Technology stack evaluation and comparison with TCO analysis, security assessment, and ecosystem health scoring. Use when comparing frameworks, evaluating technology stacks, calculating total cost of ownership, assessing migration paths, or analyzing ecosystem viability."
metadata:
  category: dev
  version: "1.0"
---

# Technology Stack Evaluator

Evaluate and compare technologies, frameworks, and cloud providers with data-driven analysis and actionable recommendations.

## Purpose

Evaluate and compare technology stacks, frameworks, and cloud providers using data-driven weighted scoring, TCO analysis, ecosystem health metrics, security assessment, and migration effort estimation.

## Trigger

Apply when the user requests:
- "compare frameworks", "evaluate technology stack", "React vs Vue", "PostgreSQL vs MongoDB"
- "calculate total cost of ownership", "TCO analysis", "tech decision"
- "assess migration path", "migrate from Angular to React", "migration effort"
- "ecosystem health", "security assessment framework", "cloud comparison"

Do NOT trigger for:
- Emergency production incidents — use monitoring tools
- Mandated technology choices where the decision is already made
- Trivial decisions between similar tools (use team preference)

## Prerequisites

- Python 3.x installed: run `python3 --version` to verify
- Scripts available: `scripts/stack_comparator.py`, `scripts/tco_calculator.py`, `scripts/ecosystem_analyzer.py`, `scripts/security_assessor.py`, `scripts/migration_analyzer.py`
- Technologies to compare must be named; use case and priority weights optional but recommended

## Steps

1. **Clarify the comparison** — identify the two or more technologies, the use case, and priority weights (e.g., developer productivity 40%, ecosystem 30%, performance 30%)
2. **Run stack comparison** — execute `python scripts/stack_comparator.py --help` then run with the selected technologies and weights
3. **Calculate TCO if needed** — run `python scripts/tco_calculator.py --input assets/sample_input_tco.json` for multi-year cost projections
4. **Assess migration complexity if needed** — run `python scripts/migration_analyzer.py --from <old> --to <new>` for migration effort estimates
5. **Present the analysis** — output the structured comparison in the Output Format below with a clear recommendation and confidence level

## Output Format

```
### Technology Comparison: <Tech A> vs <Tech B>

**Use Case**: <description>
**Priority Weights**: <weights>

| Criterion | <Tech A> | <Tech B> | Weight |
|-----------|----------|----------|--------|
| <criterion> | <score> | <score> | <weight>% |

**Recommendation**: <Tech> — <one sentence rationale>
**Confidence**: High / Medium / Low (<score>%)

**TCO (5-year)** (if requested):
- <Tech A>: $<amount>
- <Tech B>: $<amount>

**Migration effort** (if applicable): <complexity> — <timeline estimate>
```

## Rules

### Must
- State confidence level with every recommendation (High / Medium / Low)
- Present trade-offs explicitly — no technology is universally superior
- Use weighted criteria rather than gut feel when priorities are provided
- Include migration effort estimate when the user is switching from an existing stack

### Never
- Never recommend a technology for an emergency production incident — use monitoring tools instead
- Never give a recommendation without stating the top 3 decision factors that drove it
- Never assess ecosystem health without checking GitHub activity, download trends, and community support

## Examples

### Good Example

```
Compare React vs Vue for a SaaS dashboard.
Priorities: developer productivity (40%), ecosystem (30%), performance (30%).

→ React: 87/100 | Vue: 79/100
→ Recommendation: React — larger ecosystem, stronger TypeScript support, higher talent availability
→ Confidence: High (85%) — clear winner on ecosystem and hiring
→ Trade-off: Vue has gentler learning curve for smaller teams
```

### Bad Example

```
"Use React, it's more popular."
```

> Why this is bad: No weighted criteria. No use-case fit assessment. No trade-offs. No confidence level. Popularity alone is not a sufficient basis for a technical decision.

## Table of Contents

- [Capabilities](#capabilities)
- [Quick Start](#quick-start)
- [Input Formats](#input-formats)
- [Analysis Types](#analysis-types)
- [Scripts](#scripts)
- [References](#references)

---

## Capabilities

| Capability | Description |
|------------|-------------|
| Technology Comparison | Compare frameworks and libraries with weighted scoring |
| TCO Analysis | Calculate 5-year total cost including hidden costs |
| Ecosystem Health | Assess GitHub metrics, npm adoption, community strength |
| Security Assessment | Evaluate vulnerabilities and compliance readiness |
| Migration Analysis | Estimate effort, risks, and timeline for migrations |
| Cloud Comparison | Compare AWS, Azure, GCP for specific workloads |

---

## Quick Start

### Compare Two Technologies

```
Compare React vs Vue for a SaaS dashboard.
Priorities: developer productivity (40%), ecosystem (30%), performance (30%).
```

### Calculate TCO

```
Calculate 5-year TCO for Next.js on Vercel.
Team: 8 developers. Hosting: $2500/month. Growth: 40%/year.
```

### Assess Migration

```
Evaluate migrating from Angular.js to React.
Codebase: 50,000 lines, 200 components. Team: 6 developers.
```

---

## Input Formats

The evaluator accepts three input formats:

**Text** - Natural language queries
```
Compare PostgreSQL vs MongoDB for our e-commerce platform.
```

**YAML** - Structured input for automation
```yaml
comparison:
  technologies: ["React", "Vue"]
  use_case: "SaaS dashboard"
  weights:
    ecosystem: 30
    performance: 25
    developer_experience: 45
```

**JSON** - Programmatic integration
```json
{
  "technologies": ["React", "Vue"],
  "use_case": "SaaS dashboard"
}
```

---

## Analysis Types

### Quick Comparison (200-300 tokens)
- Weighted scores and recommendation
- Top 3 decision factors
- Confidence level

### Standard Analysis (500-800 tokens)
- Comparison matrix
- TCO overview
- Security summary

### Full Report (1200-1500 tokens)
- All metrics and calculations
- Migration analysis
- Detailed recommendations

---

## Scripts

### stack_comparator.py

Compare technologies with customizable weighted criteria.

```bash
python scripts/stack_comparator.py --help
```

### tco_calculator.py

Calculate total cost of ownership over multi-year projections.

```bash
python scripts/tco_calculator.py --input assets/sample_input_tco.json
```

### ecosystem_analyzer.py

Analyze ecosystem health from GitHub, npm, and community metrics.

```bash
python scripts/ecosystem_analyzer.py --technology react
```

### security_assessor.py

Evaluate security posture and compliance readiness.

```bash
python scripts/security_assessor.py --technology express --compliance soc2,gdpr
```

### migration_analyzer.py

Estimate migration complexity, effort, and risks.

```bash
python scripts/migration_analyzer.py --from angular-1.x --to react
```

---

## References

| Document | Content |
|----------|---------|
| `references/metrics.md` | Detailed scoring algorithms and calculation formulas |
| `references/examples.md` | Input/output examples for all analysis types |
| `references/workflows.md` | Step-by-step evaluation workflows |

---

## Confidence Levels

| Level | Score | Interpretation |
|-------|-------|----------------|
| High | 80-100% | Clear winner, strong data |
| Medium | 50-79% | Trade-offs present, moderate uncertainty |
| Low | < 50% | Close call, limited data |

---

## When to Use

- Comparing frontend/backend frameworks for new projects
- Evaluating cloud providers for specific workloads
- Planning technology migrations with risk assessment
- Calculating build vs. buy decisions with TCO
- Assessing open-source library viability

## When NOT to Use

- Trivial decisions between similar tools (use team preference)
- Mandated technology choices (decision already made)
- Emergency production issues (use monitoring tools)
