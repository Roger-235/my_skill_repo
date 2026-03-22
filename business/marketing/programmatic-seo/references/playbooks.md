# Programmatic SEO Playbooks

Detailed implementation guide for the 12 core pSEO playbooks. Each playbook includes pattern definition, data source, template structure, and real-world example.

---

## Playbook 1: Locations

**Pattern:** `[service/product] in [city/region]`
**Examples:** "coworking spaces in Austin", "plumbers in Denver", "best restaurants in Chicago"

**Data source:** Internal location database, Google Places API, or scrape from business directory
**Minimum pages to justify:** 50+ locations
**Unique value per page:** Local reviews, local pricing, local availability, local regulations

**Template structure:**
```
H1: [Service] in [City, State]
- Local introduction (2-3 sentences with city-specific context)
- Top providers list (data-driven, locally verified)
- Price range for [city]
- What to look for (generic + local nuances)
- FAQ targeting "[service] [city]" and "[city] [service] near me"
```

**Risk:** Thin content if pages are just name/address lists. Add genuine local data.

---

## Playbook 2: Comparisons

**Pattern:** `[Product A] vs [Product B]`
**Examples:** "Notion vs Confluence", "HubSpot vs Salesforce", "Figma vs Sketch"

**Data source:** Internal product data, G2/Capterra/Trustpilot APIs, manual research
**Minimum pages to justify:** 10+ meaningful competitor comparisons
**Unique value per page:** Honest verdict, use-case recommendations, pricing comparison

**Template structure:**
```
H1: [Product A] vs [Product B]: [Year] Comparison
- Quick verdict (who should use which)
- Side-by-side feature table
- [Product A] strengths
- [Product B] strengths
- Pricing comparison
- User review summary
- Our recommendation (with criteria)
- FAQ: "Is [A] better than [B]?", "Which is cheaper?", "Can I migrate from A to B?"
```

**Risk:** Biased comparisons (don't sandbagging competitors you beat, users trust neutral analysis).

---

## Playbook 3: Alternatives

**Pattern:** `alternatives to [competitor]` or `[competitor] competitors`
**Examples:** "Notion alternatives", "Zoom competitors", "alternatives to Salesforce"

**Data source:** Competitor database, G2/Capterra category pages, product feature data
**Minimum pages to justify:** 5+ notable competitors in your space

**Template structure:**
```
H1: [N] Best [Competitor] Alternatives in [Year]
- Why people look for alternatives (common complaints)
- Alternatives table (name, best for, pricing, rating)
- Per-alternative deep dive:
  - Key strengths vs. [Competitor]
  - Best for: [use case]
  - Pricing
  - Migration difficulty
- Conclusion: which alternative to choose based on need
```

**Risk:** Don't include irrelevant alternatives just to inflate count. Quality over quantity.

---

## Playbook 4: Integrations

**Pattern:** `[your product] + [other tool]` or `[your product] [other tool] integration`
**Examples:** "HubSpot Slack integration", "Zapier Notion integration", "Stripe WooCommerce"

**Data source:** Your integration catalog, integration partners, Zapier/Make app directory
**Minimum pages to justify:** 20+ integrations

**Template structure:**
```
H1: [Your Product] + [Tool]: Integration Guide
- What the integration does (1-2 sentence summary)
- Use cases (3-5 specific workflows this enables)
- Setup guide (numbered steps with screenshots)
- What data syncs / what doesn't
- Troubleshooting common issues
- FAQ: "Does [Your Product] integrate with [Tool]?", "How do I connect [Your Product] to [Tool]?"
```

**Risk:** Pages for integrations that don't exist yet = trust damage. Only publish live integrations.

---

## Playbook 5: Use Cases / Personas

**Pattern:** `[product] for [role/industry/use case]`
**Examples:** "Airtable for project managers", "Notion for students", "Slack for remote teams"

**Data source:** Customer segmentation data, sales call themes, support ticket patterns
**Minimum pages to justify:** 10+ distinct use cases with search volume

**Template structure:**
```
H1: [Product] for [Persona]: How [Persona] Use [Product]
- Overview: why [persona] chooses [product]
- Specific workflows [persona] uses
- Key features [persona] relies on
- Template or setup guide for [persona]
- Testimonial from [persona] type (if available)
- Pricing recommendation for [persona]
```

**Risk:** Generic pages that could apply to any product. Must be genuinely use-case-specific.

---

## Playbook 6: Glossary / Definitions

**Pattern:** `what is [term]` or `[term] definition` or `[term] meaning`
**Examples:** "what is MRR", "churn rate definition", "CAC meaning"

**Data source:** Industry terms, product jargon, frequently asked questions in your space
**Minimum pages to justify:** 50+ meaningful terms

**Template structure:**
```
H1: What Is [Term]? Definition, Formula, and Examples
- One-sentence definition
- Expanded explanation (2-3 paragraphs)
- Formula (if applicable): [Metric] = [Numerator] / [Denominator] × 100
- Example calculation with real numbers
- Why [Term] matters
- [Term] benchmarks by industry (if available)
- Related terms (link to other glossary pages)
- FAQ: "How do you calculate [term]?", "What's a good [term]?"
```

**Risk:** Shallow definitions that add no value over Wikipedia. Add formulas, benchmarks, examples.

---

## Playbook 7: Templates

**Pattern:** `[thing] template` or `free [thing] template`
**Examples:** "invoice template", "project plan template", "OKR template"

**Data source:** Your template library, user-requested templates, competitor template catalog
**Minimum pages to justify:** 20+ distinct templates

**Template structure:**
```
H1: Free [Thing] Template ([Format]: [Tool/Software])
- Download/copy CTA (above fold)
- What this template includes
- How to use the template (step-by-step)
- Template preview (screenshot or embedded)
- Customization tips
- Related templates (internal links)
```

**Risk:** Template pages with no actual downloadable content. Users expect to get something.

---

## Playbook 8: Tools / Calculators

**Pattern:** `[thing] calculator` or `free [thing] tool`
**Examples:** "CAC calculator", "SEO ROI calculator", "email subject line tester"

**Data source:** Build the actual tool (no database needed — just JavaScript)
**Minimum pages to justify:** 1 tool can rank for hundreds of queries; build selectively

**Template structure:**
```
H1: Free [Thing] Calculator
- Calculator widget (interactive, instant results)
- How to use the calculator (labeled inputs)
- What the result means
- Benchmark: what's a good [result]?
- Formula explained (for credibility)
- Related resources
```

**Risk:** Inaccurate calculators destroy trust. Verify formulas rigorously before publishing.

---

## Playbook 9: Directory / Listing

**Pattern:** `best [thing] in [category]` or `[category] directory`
**Examples:** "best Shopify apps for fashion", "top marketing agencies in NYC", "SaaS tools for HR"

**Data source:** Curated list (manual), or structured data feed (scraped/API)
**Minimum pages to justify:** 20+ categories with 10+ items each

**Template structure:**
```
H1: [N] Best [Category] [Things] in [Year]
- Quick comparison table
- Per-item cards:
  - Name, description, rating
  - Key features
  - Pricing
  - Best for
- How we chose this list (methodology)
- FAQ about the category
```

**Risk:** Outdated listings (tool shut down, pricing changed). Set review cadence every 90 days.

---

## Playbook 10: API / Developer Docs

**Pattern:** `[your product] API` or `[your product] [language] SDK`
**Examples:** "Stripe Python API", "Twilio SMS API tutorial", "Plaid React integration"

**Data source:** Your API documentation, SDK repositories
**Minimum pages to justify:** 1 per programming language + 1 per major feature endpoint

**Template structure:**
```
H1: [Product] [Language] API Reference / Tutorial
- Installation (one command)
- Authentication setup
- Quick start example (copy-paste working code)
- Common operations with code examples
- Error handling
- Rate limits and best practices
- Full API reference (or link to docs)
```

**Risk:** Code examples that don't work. Every code snippet must be tested before publishing.

---

## Playbook 11: How-To Guides

**Pattern:** `how to [task]` or `[task] tutorial`
**Examples:** "how to set up Google Analytics 4", "how to write a cold email", "how to reduce churn"

**Data source:** Support ticket themes, sales call questions, competitor tutorial gaps
**Minimum pages to justify:** 30+ distinct how-to queries in your space

**Template structure:**
```
H1: How to [Task]: Step-by-Step Guide
- What you'll need (prerequisites)
- Steps:
  1. [Action] — [Detail]
  2. [Action] — [Detail]
- Common mistakes to avoid
- Pro tips
- FAQ: "How long does [task] take?", "Can I [variation of task]?"
```

**Risk:** Generic guides that don't account for different tools/setups users may have.

---

## Playbook 12: Event / Date Pages

**Pattern:** `[event] [year]` or `[thing] in [month/year]`
**Examples:** "Black Friday SaaS deals 2025", "Google algorithm update March 2025", "best [product] 2025"

**Data source:** Curated annually, update existing pages rather than create new ones
**Minimum pages to justify:** 5+ recurring events with consistent search interest

**Template structure:**
```
H1: [Event] [Year]: [Benefit Statement]
- Last updated date (visible — critical for "2025" queries)
- Quick summary / TL;DR
- Full event details / deal list
- What's new vs. last year
- How to prepare / take advantage
- Historical context (link to previous year's page)
```

**Risk:** Stale pages that rank for "[year]" queries but still show last year's data. Set calendar reminders to update.

---

## Playbook Selection Matrix

| Business type | Recommended playbooks |
|--------------|----------------------|
| SaaS product | Integrations, Comparisons, Alternatives, Use Cases, Glossary |
| Marketplace | Locations, Directory, Templates |
| Agency/Service | Locations, Use Cases, How-To, Comparisons |
| Developer tool | API/SDK, Integrations, How-To, Glossary |
| E-commerce | Locations, Comparisons, Templates, How-To |
| Media/Publisher | Glossary, How-To, Event Pages, Directory |
