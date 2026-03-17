---
name: article-writing
description: "Structured technical article and blog post writing assistant. Guides audience definition, outlining, drafting, and formatting. Trigger when: write an article, draft a blog post, technical writing, 寫文章, 寫部落格, 撰寫技術文章, article draft, 寫一篇文章."
metadata:
  category: writing
  version: "1.0"
---

# Article Writing

Produces structured, audience-focused technical articles and blog posts by guiding the full process from audience definition through final formatted output.

## Purpose

Guide the complete article writing process: define the audience and goal, build a structured outline, draft each section with concrete examples, edit for clarity, and format for the target platform.

## Trigger

Apply when user requests:
- "write an article", "draft a blog post", "technical writing"
- "寫文章", "寫部落格", "撰寫技術文章", "article draft", "寫一篇文章"

Do NOT trigger for:
- Generating multiple content formats from one topic — use `content-engine`
- Editing an already-complete article — use `skill-edit` or handle inline

## Prerequisites

- A topic or subject to write about
- Optional: target platform (blog, documentation site, Medium, etc.) and desired length

## Steps

1. **Define audience and goal** — identify the target reader profile and the one thing they should take away from the article
2. **Create outline** — build an H2/H3 hierarchy with 3–7 main sections, each with a stated sub-purpose
3. **Draft introduction** — hook that earns the reader's attention, context that frames the problem, thesis statement that states the article's core claim
4. **Draft each section** — lead with the point, follow with supporting details, close with a concrete example relevant to the target audience
5. **Write conclusion** — summarize the key takeaways from each section; add a call to action if appropriate
6. **Edit for clarity** — remove filler phrases; every sentence must add value; prefer active voice and specific language
7. **Format for target platform** — apply Markdown heading levels, wrap code in fenced code blocks, check total length against platform norms

## Output Format

File path: none (article printed to user unless a target file is specified)

```
## Article: <Title>

**Audience:** <target reader profile>
**Goal:** <one takeaway>

---
<article content>
---
**Word count:** ~X
**Reading time:** ~Y min
```

## Rules

### Must
- Confirm audience and goal before drafting — never begin writing without them
- Write to the defined audience — no unexplained jargon; define terms the audience may not know
- Every section must directly serve the article's stated goal
- Include at least one concrete example per main section
- Edit for filler after drafting — the edit step is mandatory, not optional

### Never
- Never start drafting without an outline — structure must precede content
- Never add filler phrases ("It's worth noting...", "As we can see...", "In conclusion, it is clear that...")
- Never exceed three levels of heading nesting (H2 → H3 → H4 maximum)
- Never include off-topic content to pad word count
- Never present an unedited first draft as final output

## Examples

### Good Example

User: "Write an article about React Server Components for senior frontend developers."

```
## Article: Understanding React Server Components

**Audience:** Senior frontend developers familiar with React hooks and client-side rendering
**Goal:** Understand when and why to use RSC instead of client components, with practical migration guidance

---
## Introduction
React Server Components fundamentally change where rendering happens...

## What Problem Do RSCs Solve?
[point → details → concrete benchmark showing bundle size reduction]

## How RSCs Differ from Client Components
[point → details → side-by-side code comparison]

## When to Use Each
[decision matrix with three real-world scenarios]

## Migrating an Existing Component
[step-by-step with before/after code]

## Conclusion
RSCs reduce client bundle size and move data-fetching concerns to the server...
**Call to action:** Start with one data-fetching component in your next PR.
---
**Word count:** ~1,200
**Reading time:** ~5 min
```

### Bad Example

```
React Server Components are a new feature in React. They allow you to render components on the server. This is useful because it can improve performance. There are many things to consider when using them. It's worth noting that they work differently from regular components. As you can see, understanding RSCs is important for modern React development.
```

> Why this is bad: No audience definition, no outline, no concrete examples, full of filler phrases ("It's worth noting...", "As you can see..."), no specific claims, no actionable guidance. Fails the edit step entirely.
