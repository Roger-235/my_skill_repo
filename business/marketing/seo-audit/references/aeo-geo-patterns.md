# AEO & GEO Content Patterns

Content patterns optimized for Answer Engine Optimization (AEO) and Generative Engine Optimization (GEO) — getting cited by AI search systems (Google AI Overviews, ChatGPT, Perplexity, Claude, Gemini).

---

## How AI Search Systems Select Sources

**Confidence signals AI systems look for:**
1. Direct answer in the first 2 sentences of a section
2. Structured data (FAQ schema, HowTo schema, Article schema)
3. Named author with verifiable credentials
4. Publication date visible and recent
5. Statistics with cited sources
6. Unique data, studies, or primary research
7. Semantic completeness — answers the full question, not fragments

---

## Pattern 1: Direct Answer Block

Place a concise answer immediately after the H2 heading, before supporting detail.

```
## What is [Topic]?

[Topic] is [one-sentence definition]. [Key differentiator or context sentence].

[Expanded explanation follows...]
```

**Why it works:** AI systems extract the first substantive sentence after a heading for featured snippets and AI overviews.

---

## Pattern 2: Definition + Criteria Table

For "What is the best X" or "How to choose X" queries.

```
## How to Choose [Topic]

| Criteria | Description | Why It Matters |
|----------|-------------|----------------|
| [Factor 1] | [Definition] | [Outcome] |
| [Factor 2] | [Definition] | [Outcome] |
```

**Why it works:** Structured tables extract cleanly into AI responses and answer multi-part comparison queries.

---

## Pattern 3: Numbered Process (HowTo)

For "how to" queries. Use HowTo schema markup.

```
## How to [Task]

1. **[Step name]**: [What to do]. [Expected result].
2. **[Step name]**: [What to do]. [Expected result].
3. **[Step name]**: [What to do]. [Expected result].
```

**Why it works:** Numbered steps match the HowTo schema pattern AI systems are trained to extract.

---

## Pattern 4: FAQ Block

Add a dedicated FAQ section targeting question-format queries.

```
## Frequently Asked Questions

**Q: [Exact question phrase from search]**
A: [Direct answer in 1-3 sentences. No hedging.]

**Q: [Next question]**
A: [Direct answer.]
```

**Why it works:** FAQ schema + direct Q&A format matches both PAA (People Also Ask) boxes and AI chatbot response formats.

---

## Pattern 5: Statistic Cluster

Group statistics with citations. AI systems prefer citing pages with verifiable data.

```
## [Topic] by the Numbers

- [Stat 1] ([Source, Year])
- [Stat 2] ([Source, Year])
- [Stat 3] ([Source, Year])
```

**Why it works:** Data-dense pages with named sources score high on E-E-A-T signals that influence AI citation decisions.

---

## Pattern 6: Comparison Table

For "[X] vs [Y]" or "alternatives to [X]" queries.

```
| Feature | [Option A] | [Option B] | [Option C] |
|---------|-----------|-----------|-----------|
| [Criterion 1] | ✓ | ✗ | ✓ |
| [Criterion 2] | [value] | [value] | [value] |
| Best for | [use case] | [use case] | [use case] |
```

**Why it works:** Comparison tables appear verbatim in AI overviews for comparison queries.

---

## Platform-Specific Signals

| Platform | Primary Signal | Content Format |
|----------|---------------|----------------|
| Google AI Overviews | E-E-A-T, structured data, author authority | Long-form with clear H2/H3 hierarchy |
| Perplexity | Citation count, source diversity, recency | Data-heavy with links to primary sources |
| ChatGPT (Browse) | Page authority, semantic completeness | Comprehensive single-page resources |
| Claude | Factual accuracy, source credibility | Well-structured prose + tables |
| Gemini | Google Search signals + Bard training | Standard SEO best practices apply |

---

## Schema Markup Priority

1. **Article / BlogPosting** — publication date, author, organization
2. **FAQPage** — for FAQ blocks
3. **HowTo** — for step-by-step processes
4. **BreadcrumbList** — for navigation context
5. **SpeakableSpecification** — for voice/audio AI extraction

---

## Content Completeness Checklist

- [ ] Direct answer in first 2 sentences of each major section
- [ ] FAQ section targeting 5+ question-format queries from PAA research
- [ ] At least 3 statistics with named sources and years
- [ ] Author bio with credentials visible on page
- [ ] Publication and last-updated date visible
- [ ] At least one comparison table or definition table
- [ ] HowTo or numbered process for procedural content
- [ ] Schema markup implemented (minimum: Article + FAQPage)
- [ ] Internal links to supporting content pages
- [ ] No AI writing tells (see ai-writing-detection.md)
