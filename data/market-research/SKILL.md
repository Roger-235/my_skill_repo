---
name: market-research
description: "Structured market research framework: competitor analysis, SWOT, and TAM/SAM/SOM calculation. Trigger when: market research, competitive analysis, market analysis, SWOT analysis, TAM SAM SOM, competitor research, 市場調查, 競品分析, 市場分析, 商業分析."
metadata:
  category: data
  version: "1.0"
---

# Market Research

Produces a structured market research report covering competitive landscape, SWOT analysis, and addressable market sizing.

## Purpose

Produce a structured market research report covering competitive landscape, SWOT analysis, and addressable market sizing to inform a specific business decision.

## Trigger

Apply when the user asks for:
- "market research", "competitive analysis", "SWOT analysis", "TAM/SAM/SOM"
- "market analysis", "competitor research", "analyze the market"
- "市場調查", "競品分析", "市場分析", "商業分析"

Do NOT trigger for:
- Financial modeling or projections — use `financial-modeling`
- User research or UX work — use `ui-ux-pro-max`

## Prerequisites

- A product or business domain to research
- Access to public market data (web search, industry reports, or user-provided data)
- The decision this research is meant to inform (if unclear, ask before proceeding)

## Steps

1. **Define scope** — state the market, geography, time horizon (e.g. "SaaS project management tools, North America, 2024–2026"), and the key decision this research informs; if scope is ambiguous, ask one clarifying question before proceeding

2. **Identify competitors** — categorize into:
   - Direct competitors: same product, same target audience
   - Indirect competitors: different product solving the same job-to-be-done
   - Substitutes: alternative approaches (e.g. "hire an agency" vs. "buy software")

3. **Competitive analysis** — for each major competitor (top 3–6): product strengths, weaknesses, pricing model, target segment, and notable recent moves (funding, launches, pivots)

4. **SWOT analysis** — analyze the target entity's Strengths, Weaknesses, Opportunities, and Threats in relation to the competitive landscape discovered in Step 3

5. **Market sizing** — calculate three tiers and cite sources for each:
   - TAM (Total Addressable Market): theoretical maximum if 100% market penetration achieved
   - SAM (Serviceable Addressable Market): portion reachable given geographic, segment, or channel constraints
   - SOM (Serviceable Obtainable Market): realistically capturable share in 3–5 years given current resources

6. **Customer segments** — identify 2–4 primary customer personas; for each include: company/user profile, pain points, buying triggers, and willingness to pay signals

7. **Compile findings** — produce the structured report defined in Output Format; explicitly flag assumptions and data gaps rather than filling them with guesses

## Output Format

File path: none (output printed to user)

```
## Market Research: <market/product>

### Scope
Market: <definition>  |  Geography: <region>  |  Horizon: <timeframe>
Decision: <what this research informs>

### Competitive Landscape
| Competitor | Type | Key Strengths | Key Weaknesses | Pricing |
|-----------|------|---------------|----------------|---------|
| <name> | Direct | <strengths> | <weaknesses> | <pricing> |

### SWOT Analysis
| Strengths | Weaknesses |
|-----------|------------|
| <list> | <list> |

| Opportunities | Threats |
|---------------|---------|
| <list> | <list> |

### Market Size
- TAM: $X B — Source: <citation> | Assumption: <key assumption>
- SAM: $X B — Source: <citation> | Assumption: <key assumption>
- SOM: $X M (3-year target) — Basis: <reasoning>

### Customer Segments
**Segment 1: <name>**
Profile: <company size, role, industry>
Pain points: <top 2–3 pain points>
Buying trigger: <what causes them to seek a solution>

### Key Findings
1. <most important insight>
2. <second insight>
3. <third insight>

### Data Gaps
- <item where data was unavailable or estimated>
```

## Rules

### Must
- Cite a data source for every market size figure (TAM/SAM/SOM); if no source is available, label the figure as an estimate and state the method used
- Distinguish between direct, indirect, and substitute competitors — they have different strategic implications
- State all assumptions in TAM/SAM/SOM calculations explicitly
- Flag data gaps in the dedicated section rather than silently filling them with guesses
- Ask for the decision context before beginning if the user has not provided one

### Never
- Never present unverified market size figures without a "~estimate" label and stated methodology
- Never conflate TAM with SAM — TAM is the theoretical maximum, SAM is the realistically serviceable portion
- Never omit the decision context — research without a stated decision to inform has no actionable value
- Never treat competitor claims (e.g. their own marketing) as objective fact without noting the source bias

## Examples

### Good Example

User asks: "Do market research on AI code review tools for enterprise."

Assistant defines scope: "AI-assisted code review SaaS, targeting enterprise engineering teams (1 000+ developers), global market, 2024–2027. Decision: whether to build vs. buy." Lists 5 competitors (GitHub Copilot, CodeClimate, SonarQube, Snyk, Codacy) with type, strengths, weaknesses, and pricing. Calculates TAM from "~27 M professional developers × $200/yr tool spend = $5.4 B" with source and assumptions. Segments into startup, mid-market, and regulated enterprise buyers. Flags data gap: "SonarQube enterprise pricing not publicly listed — estimated from user reports."

### Bad Example

```
Here are some competitors: GitHub, GitLab, Bitbucket.
The market is large — maybe $10 billion.
SWOT: good product, some competition.
```

> Why this is bad: No competitive analysis (only names listed), market size has no source or methodology, SWOT is vague, no TAM/SAM/SOM breakdown, no customer segments, no decision context, and data gaps are not flagged.
