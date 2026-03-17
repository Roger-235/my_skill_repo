---
name: financial-modeling
description: "Financial modeling framework: revenue/cost model, P&L projection, cash flow statement, DCF valuation, and scenario analysis. Trigger when: financial model, DCF, revenue projection, financial forecast, P&L, cash flow model, unit economics, 財務建模, 收入預測, 現金流分析, 財務預測."
metadata:
  category: data
  version: "1.0"
---

# Financial Modeling

Builds structured financial models covering revenue/cost assumptions, P&L projections, cash flow analysis, and optional DCF valuation with scenario analysis.

## Purpose

Build a structured financial model covering revenue and cost assumptions, P&L projections, cash flow statements, unit economics, and scenario analysis; optionally include DCF valuation.

## Trigger

Apply when the user asks for:
- "financial model", "DCF valuation", "revenue projection", "financial forecast"
- "P&L", "cash flow model", "unit economics", "burn rate"
- "財務建模", "收入預測", "現金流分析", "財務預測"

Do NOT trigger for:
- Market sizing without financial projections — use `market-research`
- Accounting, bookkeeping, or tax filing tasks

## Prerequisites

- A description of the business model (how the company makes money)
- Known or estimated revenue drivers: pricing, volume, growth rate
- Known or estimated cost structure: COGS, operating expenses, CapEx
- Time horizon for the model (default: 3 years)

## Steps

1. **Define assumptions** — document all revenue drivers (pricing, volume, growth rate), cost structure (COGS, OpEx, CapEx), and the basis for each figure: historical data, industry benchmark, or stated estimate; every assumption must have a documented source or rationale

2. **Build revenue model** — choose the appropriate approach:
   - Bottom-up: unit price × volume × conversion rate (preferred for early-stage)
   - Top-down: market size × assumed market share (use only when bottom-up is impractical)
   - Model at monthly granularity for Year 1, quarterly for Year 2–3

3. **Build cost model** — separate into:
   - COGS (Cost of Goods Sold): direct costs that scale with revenue
   - OpEx: G&A, Sales & Marketing, R&D — identify fixed vs. variable components
   - CapEx: one-time or periodic capital investments

4. **Construct P&L** — build the income statement:
   - Revenue − COGS = Gross Profit (and Gross Margin %)
   - Gross Profit − OpEx = EBITDA
   - EBITDA − D&A = EBIT
   - EBIT − Tax = Net Income

5. **Build cash flow statement** — three sections:
   - Operating: Net Income + D&A − working capital changes
   - Investing: CapEx and asset purchases
   - Financing: debt drawdowns, repayments, equity raises
   - Ending cash = beginning cash + net cash change

6. **DCF valuation** (if requested) — project free cash flows for 5 years, select a discount rate (WACC or required return rate with stated basis), calculate terminal value using Gordon Growth Model, compute NPV

7. **Scenario analysis** — run at minimum three cases and show the output side-by-side:
   - Base case: stated assumptions as-is
   - Upside: +20% revenue, costs unchanged
   - Downside: −30% revenue, +15% costs

## Output Format

File path: none (output printed to user)

```
## Financial Model: <company/project>

### Key Assumptions
| Driver | Value | Basis |
|--------|-------|-------|
| Monthly new customers | 500 | Sales capacity estimate |
| Monthly price (per seat) | $49 | Competitive benchmark |
| Monthly churn | 5% | SaaS industry average |
| COGS (% of revenue) | 20% | Hosting + support cost estimate |

### P&L Summary ($000s)
|  | Y1 | Y2 | Y3 |
|--|----|----|-----|
| Revenue | | | |
| Gross Profit | | | |
| Gross Margin % | | | |
| EBITDA | | | |
| Net Income | | | |

### Unit Economics
- CAC: $X   |   LTV: $X   |   LTV/CAC: Xx   |   Payback: X months

### Cash Runway
- Current monthly burn: $X
- Cash on hand: $X
- Runway: X months

### DCF Valuation (if applicable)
- Discount rate (WACC): X%
- Terminal growth rate: X%
- NPV: $X M

### Scenarios
| Case | Y3 Revenue | Y3 EBITDA | Y3 Net Income |
|------|-----------|----------|---------------|
| Base | | | |
| Upside (+20% rev) | | | |
| Downside (−30% rev, +15% cost) | | | |

### Assumptions & Risks
- <key assumption 1 and sensitivity>
- <data gap or uncertainty>
```

## Rules

### Must
- Document every assumption with its basis — state whether it comes from historical data, an industry benchmark, or is a pure estimate
- Always include a scenario analysis with at least a base case and a downside case
- Show unit economics (CAC, LTV, LTV/CAC, payback period) for any subscription or transaction-based business
- Label all figures as estimates when based on assumptions rather than actuals

### Never
- Never present revenue projections without showing the underlying assumptions that drive them
- Never show only the upside case — a model without a downside scenario is not a model, it is wishful thinking
- Never build circular references in formulas without explicitly documenting them and explaining why they are necessary
- Never present a DCF without stating the discount rate and its basis

## Examples

### Good Example

SaaS startup asks for a 3-year financial model. Assistant defines: $49/seat/month price (competitive benchmark), 500 new seats/month (based on 3-person sales team capacity), 5% monthly churn (SaaS benchmark), 20% COGS. Builds monthly P&L for 12 months showing break-even at month 8. Shows LTV/CAC = 4.2×. Runs base/upside/downside scenarios — downside shows cash exhaustion at month 14, flags need for Series A before month 12.

### Bad Example

```
Year 1 revenue: $2M
Year 2 revenue: $5M
Year 3 revenue: $12M
This looks good — the business should be profitable by Year 2.
```

> Why this is bad: No assumptions stated, no cost model, no P&L breakdown, no unit economics, no scenario analysis, no basis for the revenue figures, and no downside case. The numbers cannot be validated or acted upon.
