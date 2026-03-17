---
name: business-guide
description: "Routes business and management requests to the appropriate skill. Covers C-suite advisory, marketing, product management, finance, compliance, project management, and business growth."
metadata:
  category: business
  version: "1.0"
---

## Purpose
Route business and management queries to the correct specialist skill.

## Trigger
When the user asks about business strategy, management, marketing, finance, compliance, project management, or business growth topics.

## Prerequisites
- None

## Routing Table

### C-Suite

| Request Type | Skill | Trigger Keywords |
|---|---|---|
| CEO strategy, company direction | `c-suite/ceo-advisor` | CEO, company strategy, founder decisions |
| CFO, financial strategy | `c-suite/cfo-advisor` | CFO, capital allocation, financial risk |
| CTO, technology strategy | `c-suite/cto-advisor` | CTO, tech roadmap, build vs buy |
| CMO, marketing strategy | `c-suite/cmo-advisor` | CMO, brand positioning, GTM strategy |
| COO, operations | `c-suite/coo-advisor` | COO, operations, process optimization |
| CPO, product strategy | `c-suite/cpo-advisor` | CPO, product vision, roadmap |
| CRO, revenue | `c-suite/cro-advisor` | CRO, revenue growth, sales strategy |
| CHRO, HR strategy | `c-suite/chro-advisor` | CHRO, talent, culture, HR |
| CISO, security strategy | `c-suite/ciso-advisor` | CISO, security governance, risk |
| Chief of Staff | `c-suite/chief-of-staff` | chief of staff, executive coordination |
| Executive mentoring | `c-suite/executive-mentor` | executive coaching, leadership development |
| Founder coaching | `c-suite/founder-coach` | founder, startup, early-stage |
| Board preparation | `c-suite/board-deck-builder` | board deck, investor presentation |
| Board meeting | `c-suite/board-meeting` | board meeting, governance |
| Agent protocols, AI deployment | `c-suite/agent-protocol` | agent protocol, AI deployment, agentic system |
| Change management | `c-suite/change-management` | change management, transformation, org change |
| Company OS, operating model | `c-suite/company-os` | company OS, operating model, management system |
| Competitive intelligence | `c-suite/competitive-intel` | competitive intelligence, market landscape, competitor |
| Context engine, knowledge management | `c-suite/context-engine` | context engine, institutional knowledge, knowledge base |
| Customer onboarding | `c-suite/cs-onboard` | customer onboarding, CS onboarding |
| Culture architecture | `c-suite/culture-architect` | culture, values, team culture, culture design |
| Decision logging | `c-suite/decision-logger` | decision log, decision journal, ADR |
| Internal narrative, messaging | `c-suite/internal-narrative` | internal comms, company narrative, messaging |
| International expansion | `c-suite/intl-expansion` | international expansion, market entry, localization |
| M&A playbook | `c-suite/ma-playbook` | M&A, merger, acquisition, due diligence |
| Org health diagnostic | `c-suite/org-health-diagnostic` | org health, organizational assessment, team health |
| Scenario planning, war room | `c-suite/scenario-war-room` | scenario planning, war room, strategic options |
| Strategic alignment | `c-suite/strategic-alignment` | strategic alignment, OKR alignment, strategy execution |

### Marketing

| Request Type | Skill | Trigger Keywords |
|---|---|---|
| SEO audit | `marketing/seo-audit` | SEO, search ranking, organic traffic |
| AI-driven SEO | `marketing/ai-seo` | AI SEO, programmatic SEO, AI content |
| Programmatic SEO | `marketing/programmatic-seo` | programmatic SEO, content at scale |
| Schema markup | `marketing/schema-markup` | schema markup, structured data, JSON-LD |
| Site architecture | `marketing/site-architecture` | site architecture, information architecture, URL structure |
| Content strategy | `marketing/content-strategy` | content strategy, editorial calendar |
| Content production | `marketing/content-production` | content production, content pipeline |
| Content creator | `marketing/content-creator` | content creator, blog post, article writing |
| Content humanizer | `marketing/content-humanizer` | humanize content, AI content rewrite |
| Copywriting | `marketing/copywriting` | copywriting, ad copy, landing page copy |
| Copy editing | `marketing/copy-editing` | copy editing, proofreading, editing |
| Cold email | `marketing/cold-email` | cold email, outbound email, email outreach |
| Email sequence | `marketing/email-sequence` | email sequence, drip campaign, email marketing |
| Social media management | `marketing/social-media-manager` | social media, Twitter, LinkedIn, Instagram |
| Social content creation | `marketing/social-content` | social content, social posts, LinkedIn posts |
| Social media analysis | `marketing/social-media-analyzer` | social analytics, engagement, social metrics |
| X/Twitter growth | `marketing/x-twitter-growth` | Twitter growth, X growth, tweet strategy |
| Paid advertising | `marketing/paid-ads` | paid ads, Google Ads, Facebook Ads, PPC |
| Ad creative | `marketing/ad-creative` | ad creative, banner ads, creative copy |
| Brand guidelines | `marketing/brand-guidelines` | brand guidelines, brand identity, style guide |
| Marketing strategy, PMM | `marketing/marketing-strategy-pmm` | PMM, product marketing, positioning, messaging |
| Marketing demand acquisition | `marketing/marketing-demand-acquisition` | demand gen, lead generation, demand acquisition |
| Marketing operations | `marketing/marketing-ops` | marketing ops, martech, CRM, HubSpot |
| Marketing analytics | `marketing/campaign-analytics` | marketing analytics, campaign performance, attribution |
| Analytics tracking | `marketing/analytics-tracking` | analytics tracking, GA4, GTM, pixel setup |
| Marketing psychology | `marketing/marketing-psychology` | marketing psychology, behavioral marketing, persuasion |
| Marketing ideas | `marketing/marketing-ideas` | marketing ideas, campaign ideas, growth ideas |
| Marketing context | `marketing/marketing-context` | marketing context, positioning context |
| Launch strategy | `marketing/launch-strategy` | product launch, launch strategy, go-to-market |
| Page CRO | `marketing/page-cro` | landing page CRO, conversion rate, page optimization |
| Form CRO | `marketing/form-cro` | form optimization, form CRO, signup form |
| Onboarding CRO | `marketing/onboarding-cro` | onboarding flow, activation, user onboarding CRO |
| Signup flow CRO | `marketing/signup-flow-cro` | signup CRO, registration flow, signup optimization |
| Paywall CRO | `marketing/paywall-upgrade-cro` | paywall, upgrade flow, conversion to paid |
| Popup CRO | `marketing/popup-cro` | popup, modal, exit intent |
| A/B test setup | `marketing/ab-test-setup` | A/B test, split test, experiment |
| Churn prevention | `marketing/churn-prevention` | churn prevention, retention, reduce churn |
| Referral program | `marketing/referral-program` | referral program, referral marketing, word of mouth |
| Free tool strategy | `marketing/free-tool-strategy` | free tool, lead magnet, free product SEO |
| Competitor alternatives | `marketing/competitor-alternatives` | competitor alternatives, vs pages, comparison pages |
| Pricing strategy | `marketing/pricing-strategy` | pricing strategy, price optimization, monetization |
| App store optimization | `marketing/app-store-optimization` | ASO, app store, play store, app ranking |
| Prompt engineer toolkit | `marketing/prompt-engineer-toolkit` | prompt engineering, AI marketing, prompt templates |

### Product

| Request Type | Skill | Trigger Keywords |
|---|---|---|
| Product strategy | `product/product-strategist` | product strategy, OKRs, roadmap |
| Product management toolkit | `product/product-manager-toolkit` | PRD, RICE, product management |
| Agile product owner | `product/agile-product-owner` | agile, product owner, backlog, sprint |
| Product discovery | `product/product-discovery` | product discovery, user problem, opportunity |
| Product analytics | `product/product-analytics` | product analytics, funnel, retention metrics |
| Roadmap communication | `product/roadmap-communicator` | roadmap communication, stakeholder update |
| User research | `product/ux-researcher-designer` | UX research, user interviews, persona |
| Competitive teardown | `product/competitive-teardown` | competitive teardown, product analysis, feature audit |
| Research summarizer | `product/research-summarizer` | research summary, synthesis, insights |
| A/B experiment design | `product/experiment-designer` | A/B test, experiment design, hypothesis |
| SaaS scaffolding | `product/saas-scaffolder` | SaaS boilerplate, Next.js, Stripe |
| Landing page generator | `product/landing-page-generator` | landing page, waitlist page, marketing page |
| UI design system | `product/ui-design-system` | design system, component library, UI tokens |

### Finance

| Request Type | Skill | Trigger Keywords |
|---|---|---|
| Financial analysis | `finance/financial-analyst` | financial ratios, DCF, valuation, financial model |
| SaaS metrics coaching | `finance/saas-metrics-coach` | ARR, MRR, churn, LTV/CAC, SaaS metrics |

### Compliance

| Request Type | Skill | Trigger Keywords |
|---|---|---|
| FDA compliance | `compliance/fda-consultant-specialist` | FDA, 510(k), medical device |
| GDPR compliance | `compliance/gdpr-dsgvo-expert` | GDPR, data protection, privacy |
| ISO 13485, QMS | `compliance/quality-manager-qms-iso13485` | ISO 13485, QMS, medical device quality |
| ISO 27001, ISMS | `compliance/information-security-manager-iso27001` | ISO 27001, ISMS, information security |
| Risk management (ISO 14971) | `compliance/risk-management-specialist` | ISO 14971, risk assessment, FMEA |
| CAPA management | `compliance/capa-officer` | CAPA, corrective action, preventive action |
| ISMS audit | `compliance/isms-audit-expert` | ISMS audit, ISO 27001 audit, internal audit |
| MDR 2017/745 | `compliance/mdr-745-specialist` | MDR, EU medical device regulation, CE marking |
| QMS audit | `compliance/qms-audit-expert` | QMS audit, quality audit, internal audit |
| Quality documentation | `compliance/quality-documentation-manager` | quality documentation, SOPs, work instructions |
| Quality management representative | `compliance/quality-manager-qmr` | QMR, quality representative, management review |
| Regulatory affairs | `compliance/regulatory-affairs-head` | regulatory affairs, regulatory strategy, submissions |

### Project Management

| Request Type | Skill | Trigger Keywords |
|---|---|---|
| Jira, project tracking | `project-mgmt/jira-expert` | Jira, JQL, sprint, kanban |
| Confluence, documentation | `project-mgmt/confluence-expert` | Confluence, knowledge base, documentation |
| Atlassian admin | `project-mgmt/atlassian-admin` | Atlassian admin, Jira admin, Confluence admin |
| Atlassian templates | `project-mgmt/atlassian-templates` | Atlassian templates, Jira templates, Confluence templates |
| Scrum, agile coaching | `project-mgmt/scrum-master` | scrum, sprint planning, velocity |
| Enterprise project management | `project-mgmt/senior-pm-enterprise` | portfolio, risk quantification, board report |

### Growth

| Request Type | Skill | Trigger Keywords |
|---|---|---|
| Contract and proposal writing | `growth/contract-and-proposal-writer` | contract, SOW, NDA, proposal |
| Customer success | `growth/customer-success-manager` | customer health, churn, upsell |
| Revenue operations | `growth/revenue-operations` | pipeline, forecast, GTM efficiency |
| Sales engineering | `growth/sales-engineer` | RFP, POC, sales demo |

## Skill Chains
- Business launch: `product/product-discovery` → `product/product-strategist` → `marketing/launch-strategy` → `marketing/content-strategy`
- Fundraising: `c-suite/ceo-advisor` → `c-suite/board-deck-builder` → `finance/financial-analyst`
- Compliance program: `compliance/risk-management-specialist` → appropriate ISO/FDA skill → `compliance/quality-documentation-manager`
- Marketing funnel: `marketing/marketing-strategy-pmm` → `marketing/content-strategy` → `marketing/paid-ads` → `marketing/page-cro`

## Rules
### Must
- Route to the most specific skill available
- Explain what the routed skill does before invoking it
- Suggest skill chains when the request spans multiple domains

### Never
- Perform work directly — always route
- Invoke multiple specialist skills simultaneously without user confirmation

## Examples
### Good
User: "Help me prepare for my board meeting"
→ Route to `c-suite/board-deck-builder` with context about the meeting

### Bad
User: "Help me with marketing"
→ Immediately starting to write copy without routing to the appropriate marketing skill
