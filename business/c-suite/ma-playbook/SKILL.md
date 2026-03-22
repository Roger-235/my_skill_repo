---
name: ma-playbook
description: "M&A strategy for acquiring companies or being acquired. Due diligence, valuation, integration, and deal structure. Use when evaluating acquisitions, preparing for acquisition, M&A due diligence, integration planning, or deal negotiation."
metadata:
  category: business
  version: "1.0"
  format: github-imported
---

# M&A Playbook

Frameworks for both sides of M&A: acquiring companies and being acquired.

## Keywords
M&A, mergers and acquisitions, due diligence, acquisition, acqui-hire, integration, deal structure, valuation, LOI, term sheet, earnout

## Quick Start

**Acquiring:** Start with strategic rationale → target screening → due diligence → valuation → negotiation → integration.

**Being Acquired:** Start with readiness assessment → data room prep → advisor selection → negotiation → transition.

## When You're Acquiring

### Strategic Rationale (answer before anything else)
- **Buy vs Build:** Can you build this faster/cheaper? If yes, don't acquire.
- **Acqui-hire vs Product vs Market:** What are you really buying? Talent? Technology? Customers?
- **Integration complexity:** How hard is it to merge this into your company?

### Due Diligence Checklist
| Domain | Key Questions | Red Flags |
|--------|--------------|-----------|
| Financial | Revenue quality, customer concentration, burn rate | >30% revenue from 1 customer |
| Technical | Code quality, tech debt, architecture fit | Monolith with no tests |
| Legal | IP ownership, pending litigation, contracts | Key IP owned by individuals |
| People | Key person risk, culture fit, retention risk | Founders have no lockup/earnout |
| Market | Market position, competitive threats | Declining market share |
| Customers | Churn rate, NPS, contract terms | High churn, short contracts |

### Valuation Approaches
- **Revenue multiple:** Industry-dependent (2-15x ARR for SaaS)
- **Comparable transactions:** What similar companies sold for
- **DCF:** For profitable companies only (most startups: use multiples)
- **Acqui-hire:** $1-3M per engineer in hot markets

### Integration Frameworks
See `references/integration-playbook.md` for the 100-day integration plan.

## When You're Being Acquired

### Readiness Signals
- Inbound interest from strategic buyers
- Market consolidation happening around you
- Fundraising becomes harder than operating
- Founder ready for a transition

### Preparation (6-12 months before)
1. Clean up financials (audited if possible)
2. Document all IP and contracts
3. Reduce customer concentration
4. Lock up key employees
5. Build the data room
6. Engage an M&A advisor

### Negotiation Points
| Term | What to Watch | Your Leverage |
|------|--------------|---------------|
| Valuation | Earnout traps (unreachable targets) | Multiple competing offers |
| Earnout | Milestone definitions, measurement period | Cash-heavy vs earnout-heavy split |
| Lockup | Duration, conditions | Your replaceability |
| Rep & warranties | Scope of liability | Escrow vs indemnification cap |
| Employee retention | Who gets offers, at what terms | Key person dependencies |

## Red Flags (Both Sides)

- No clear strategic rationale beyond "it's a good deal"
- Culture clash visible during due diligence and ignored
- Key people not locked in before close
- Integration plan doesn't exist or is "we'll figure it out"
- Valuation based on projections, not actuals

## Integration with C-Suite Roles

| Role | Contribution to M&A |
|------|-------------------|
| CEO | Strategic rationale, negotiation lead |
| CFO | Valuation, deal structure, financing |
| CTO | Technical due diligence, integration architecture |
| CHRO | People due diligence, retention planning |
| COO | Integration execution, process merge |
| CPO | Product roadmap impact, customer overlap |

## Resources
- `references/integration-playbook.md` — 100-day post-acquisition integration plan
- `references/due-diligence-checklist.md` — comprehensive DD checklist by domain

## Multi-Agent Analysis

當需要**快速完成盡職調查**時，三個維度同時進行，將 DD 時間壓縮 60%。

**Step 1 — 收集 context：**
目標公司名稱、業務類別、已知 ARR/員工數、你是買方還是賣方、交易規模估計

**Step 2 — 同時派出：**

```javascript
Task({ subagent_type: "Explore", description: "Financial & commercial DD",
  prompt: "Conduct financial due diligence research on {target_company}: (1) Public financial signals — revenue estimates (SimilarWeb, LinkedIn headcount trend), funding history and investors, burn rate signals from job postings, (2) Customer base quality — G2/Capterra review volume and trend (proxy for growth), customer concentration signals, NPS/CSAT public data, (3) Commercial model — pricing page, contract terms if public, partner ecosystem. Return: financial health assessment, key questions for data room, and red flags." })

Task({ subagent_type: "Explore", description: "Technical & people DD",
  prompt: "Conduct technical and people due diligence on {target_company}: (1) Tech stack — job postings reveal stack (what languages/infra they use), GitHub activity if public (commit frequency, contributors), tech debt signals (SRE/reliability job postings), (2) Team — LinkedIn headcount by department, engineering/product ratio, key person dependencies (founders, CTO tenure), recent executive departures, (3) Culture signals — Glassdoor rating and themes, employee reviews, Blind activity. Return: technical risk assessment, key person dependency map, culture red flags." })

Task({ subagent_type: "Plan", description: "Valuation & integration strategy",
  prompt: "Design acquisition framework for {target_company} in {category} as {buyer_type} buyer. Estimate valuation range using: comparable transactions in {category} (typical ARR multiples: SaaS Series A 5-10x ARR), strategic vs financial buyer premium (15-30%). Design: integration approach (acqui-hire / product / market consolidation), 100-day integration milestones, key employee retention strategy, customer communication plan, and deal structure recommendation (cash vs stock vs earnout). Return: valuation range, deal structure options, and integration roadmap." })
```

**Step 3 — Synthesize：** DD 風險評分（財務/技術/人員）+ 估值範圍與理由 + 交易結構建議 + 100 天整合計畫骨架 + 必須釐清的前 5 個資料室問題。
