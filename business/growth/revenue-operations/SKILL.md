---
name: revenue-operations
description: "Analyzes sales pipeline health, revenue forecasting accuracy, and go-to-market efficiency metrics for SaaS revenue optimization. Use when analyzing sales pipeline coverage, forecasting revenue, evaluating go-to-market performance, reviewing sales metrics, assessing pipeline analysis, tracking forecast accuracy with MAPE, calculating GTM efficiency, or measuring sales efficiency and unit economics for SaaS teams."
metadata:
  category: business
  version: "1.0"
  format: github-imported
---

# Revenue Operations

Pipeline analysis, forecast accuracy tracking, and GTM efficiency measurement for SaaS revenue teams.

> **Output formats:** All scripts support `--format text` (human-readable) and `--format json` (dashboards/integrations).

---

## Quick Start

```bash
# Analyze pipeline health and coverage
python scripts/pipeline_analyzer.py --input assets/sample_pipeline_data.json --format text

# Track forecast accuracy over multiple periods
python scripts/forecast_accuracy_tracker.py assets/sample_forecast_data.json --format text

# Calculate GTM efficiency metrics
python scripts/gtm_efficiency_calculator.py assets/sample_gtm_data.json --format text
```

---

## Tools Overview

### 1. Pipeline Analyzer

Analyzes sales pipeline health including coverage ratios, stage conversion rates, deal velocity, aging risks, and concentration risks.

**Input:** JSON file with deals, quota, and stage configuration
**Output:** Coverage ratios, conversion rates, velocity metrics, aging flags, risk assessment

**Usage:**

```bash
python scripts/pipeline_analyzer.py --input pipeline.json --format text
```

**Key Metrics Calculated:**
- **Pipeline Coverage Ratio** -- Total pipeline value / quota target (healthy: 3-4x)
- **Stage Conversion Rates** -- Stage-to-stage progression rates
- **Sales Velocity** -- (Opportunities x Avg Deal Size x Win Rate) / Avg Sales Cycle
- **Deal Aging** -- Flags deals exceeding 2x average cycle time per stage
- **Concentration Risk** -- Warns when >40% of pipeline is in a single deal
- **Coverage Gap Analysis** -- Identifies quarters with insufficient pipeline

**Input Schema:**

```json
{
  "quota": 500000,
  "stages": ["Discovery", "Qualification", "Proposal", "Negotiation", "Closed Won"],
  "average_cycle_days": 45,
  "deals": [
    {
      "id": "D001",
      "name": "Acme Corp",
      "stage": "Proposal",
      "value": 85000,
      "age_days": 32,
      "close_date": "2025-03-15",
      "owner": "rep_1"
    }
  ]
}
```

### 2. Forecast Accuracy Tracker

Tracks forecast accuracy over time using MAPE, detects systematic bias, analyzes trends, and provides category-level breakdowns.

**Input:** JSON file with forecast periods and optional category breakdowns
**Output:** MAPE score, bias analysis, trends, category breakdown, accuracy rating

**Usage:**

```bash
python scripts/forecast_accuracy_tracker.py forecast_data.json --format text
```

**Key Metrics Calculated:**
- **MAPE** -- mean(|actual - forecast| / |actual|) x 100
- **Forecast Bias** -- Over-forecasting (positive) vs under-forecasting (negative) tendency
- **Weighted Accuracy** -- MAPE weighted by deal value for materiality
- **Period Trends** -- Improving, stable, or declining accuracy over time
- **Category Breakdown** -- Accuracy by rep, product, segment, or any custom dimension

**Accuracy Ratings:**
| Rating | MAPE Range | Interpretation |
|--------|-----------|----------------|
| Excellent | <10% | Highly predictable, data-driven process |
| Good | 10-15% | Reliable forecasting with minor variance |
| Fair | 15-25% | Needs process improvement |
| Poor | >25% | Significant forecasting methodology gaps |

**Input Schema:**

```json
{
  "forecast_periods": [
    {"period": "2025-Q1", "forecast": 480000, "actual": 520000},
    {"period": "2025-Q2", "forecast": 550000, "actual": 510000}
  ],
  "category_breakdowns": {
    "by_rep": [
      {"category": "Rep A", "forecast": 200000, "actual": 210000},
      {"category": "Rep B", "forecast": 280000, "actual": 310000}
    ]
  }
}
```

### 3. GTM Efficiency Calculator

Calculates core SaaS GTM efficiency metrics with industry benchmarking, ratings, and improvement recommendations.

**Input:** JSON file with revenue, cost, and customer metrics
**Output:** Magic Number, LTV:CAC, CAC Payback, Burn Multiple, Rule of 40, NDR with ratings

**Usage:**

```bash
python scripts/gtm_efficiency_calculator.py gtm_data.json --format text
```

**Key Metrics Calculated:**

| Metric | Formula | Target |
|--------|---------|--------|
| Magic Number | Net New ARR / Prior Period S&M Spend | >0.75 |
| LTV:CAC | (ARPA x Gross Margin / Churn Rate) / CAC | >3:1 |
| CAC Payback | CAC / (ARPA x Gross Margin) months | <18 months |
| Burn Multiple | Net Burn / Net New ARR | <2x |
| Rule of 40 | Revenue Growth % + FCF Margin % | >40% |
| Net Dollar Retention | (Begin ARR + Expansion - Contraction - Churn) / Begin ARR | >110% |

**Input Schema:**

```json
{
  "revenue": {
    "current_arr": 5000000,
    "prior_arr": 3800000,
    "net_new_arr": 1200000,
    "arpa_monthly": 2500,
    "revenue_growth_pct": 31.6
  },
  "costs": {
    "sales_marketing_spend": 1800000,
    "cac": 18000,
    "gross_margin_pct": 78,
    "total_operating_expense": 6500000,
    "net_burn": 1500000,
    "fcf_margin_pct": 8.4
  },
  "customers": {
    "beginning_arr": 3800000,
    "expansion_arr": 600000,
    "contraction_arr": 100000,
    "churned_arr": 300000,
    "annual_churn_rate_pct": 8
  }
}
```

---

## Revenue Operations Workflows

### Weekly Pipeline Review

Use this workflow for your weekly pipeline inspection cadence.

1. **Verify input data:** Confirm pipeline export is current and all required fields (stage, value, close_date, owner) are populated before proceeding.

2. **Generate pipeline report:**
   ```bash
   python scripts/pipeline_analyzer.py --input current_pipeline.json --format text
   ```

3. **Cross-check output totals** against your CRM source system to confirm data integrity.

4. **Review key indicators:**
   - Pipeline coverage ratio (is it above 3x quota?)
   - Deals aging beyond threshold (which deals need intervention?)
   - Concentration risk (are we over-reliant on a few large deals?)
   - Stage distribution (is there a healthy funnel shape?)

5. **Document using template:** Use `assets/pipeline_review_template.md`

6. **Action items:** Address aging deals, redistribute pipeline concentration, fill coverage gaps

### Forecast Accuracy Review

Use monthly or quarterly to evaluate and improve forecasting discipline.

1. **Verify input data:** Confirm all forecast periods have corresponding actuals and no periods are missing before running.

2. **Generate accuracy report:**
   ```bash
   python scripts/forecast_accuracy_tracker.py forecast_history.json --format text
   ```

3. **Cross-check actuals** against closed-won records in your CRM before drawing conclusions.

4. **Analyze patterns:**
   - Is MAPE trending down (improving)?
   - Which reps or segments have the highest error rates?
   - Is there systematic over- or under-forecasting?

5. **Document using template:** Use `assets/forecast_report_template.md`

6. **Improvement actions:** Coach high-bias reps, adjust methodology, improve data hygiene

### GTM Efficiency Audit

Use quarterly or during board prep to evaluate go-to-market efficiency.

1. **Verify input data:** Confirm revenue, cost, and customer figures reconcile with finance records before running.

2. **Calculate efficiency metrics:**
   ```bash
   python scripts/gtm_efficiency_calculator.py quarterly_data.json --format text
   ```

3. **Cross-check computed ARR and spend totals** against your finance system before sharing results.

4. **Benchmark against targets:**
   - Magic Number (>0.75)
   - LTV:CAC (>3:1)
   - CAC Payback (<18 months)
   - Rule of 40 (>40%)

5. **Document using template:** Use `assets/gtm_dashboard_template.md`

6. **Strategic decisions:** Adjust spend allocation, optimize channels, improve retention

### Quarterly Business Review

Combine all three tools for a comprehensive QBR analysis.

1. Run pipeline analyzer for forward-looking coverage
2. Run forecast tracker for backward-looking accuracy
3. Run GTM calculator for efficiency benchmarks
4. Cross-reference pipeline health with forecast accuracy
5. Align GTM efficiency metrics with growth targets

---

## Reference Documentation

| Reference | Description |
|-----------|-------------|
| [RevOps Metrics Guide](references/revops-metrics-guide.md) | Complete metrics hierarchy, definitions, formulas, and interpretation |
| [Pipeline Management Framework](references/pipeline-management-framework.md) | Pipeline best practices, stage definitions, conversion benchmarks |
| [GTM Efficiency Benchmarks](references/gtm-efficiency-benchmarks.md) | SaaS benchmarks by stage, industry standards, improvement strategies |

---

## Templates

| Template | Use Case |
|----------|----------|
| [Pipeline Review Template](assets/pipeline_review_template.md) | Weekly/monthly pipeline inspection documentation |
| [Forecast Report Template](assets/forecast_report_template.md) | Forecast accuracy reporting and trend analysis |
| [GTM Dashboard Template](assets/gtm_dashboard_template.md) | GTM efficiency dashboard for leadership review |
| [Sample Pipeline Data](assets/sample_pipeline_data.json) | Example input for pipeline_analyzer.py |
| [Expected Output](assets/expected_output.json) | Reference output from pipeline_analyzer.py |

## Multi-Agent Analysis

當需要**完整 GTM 效率健診**（季度業務回顧、融資前、新 RevOps 上任）時，平行派出 agent。

**Step 1 — 收集 context：**
當前 ARR、本季管線金額、銷售代表人數、本季預測 vs 實際達成率

**Step 2 — 同時派出：**

```javascript
Task({ subagent_type: "Explore", description: "Pipeline coverage & deal health",
  prompt: "Analyze sales pipeline health for {company}. Pipeline: {pipeline_amount} covering {quota_target} target ({coverage}x). Breakdown: (1) Coverage ratio by stage (early/mid/late), (2) Deals aging beyond {avg_cycle_days}-day average cycle — which need intervention?, (3) Concentration risk — any single deal >15% of quarter?, (4) Stage conversion rates vs benchmarks (SDR→SAL 60%, SAL→SQL 50%, SQL→Close 25%), (5) Rep-level pipeline distribution (is pipeline concentrated on 2-3 reps?). Return: pipeline health score, risk flags, and intervention list." })

Task({ subagent_type: "Explore", description: "Forecast accuracy & GTM efficiency",
  prompt: "Analyze forecast accuracy and GTM efficiency for {company}. Given {periods} of forecast history: (1) Calculate MAPE (Mean Absolute Percentage Error) — benchmark <15%, (2) Identify systematic bias (consistently over- or under-forecasting?), (3) Calculate Magic Number ({net_new_arr} ÷ {s_and_m_spend_prior_quarter}) — benchmark >0.75, (4) Calculate CAC ({s_and_m_spend} ÷ {new_customers}), CAC payback period, and LTV:CAC — benchmark >3:1, (5) Revenue per FTE trend. Return: efficiency scorecard with benchmark comparison and top 2 improvement levers per metric." })

Task({ subagent_type: "Plan", description: "RevOps improvement roadmap",
  prompt: "Design RevOps improvement roadmap for {company} based on: pipeline coverage {coverage}x, forecast accuracy {mape}% MAPE, Magic Number {magic_number}. Prioritize: (1) Biggest efficiency leak (pipeline quality vs forecast discipline vs GTM spend allocation), (2) Data hygiene fixes needed in CRM, (3) Process improvements with highest ROI (weekly pipeline review cadence, forecast commit culture, territory redesign), (4) Technology gaps (what tools would most improve visibility). Return: 90-day RevOps roadmap with quick wins (week 1-2), structural fixes (month 1-2), and strategic changes (month 2-3)." })
```

**Step 3 — Synthesize：** GTM 效率綜合評分 + 管線風險清單 + 預測精準度改善計畫 + 90 天 RevOps 路線圖（按 ROI 排序）。
