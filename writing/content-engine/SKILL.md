---
name: content-engine
description: "Batch content production engine. Derives multiple content formats (blog, LinkedIn, tweet thread, summary, email) from one core topic. Trigger when: content plan, generate content variations, content strategy, repurpose content, 內容規劃, 批量生產內容, 多格式內容, content batch."
metadata:
  category: writing
  version: "1.0"
---

# Content Engine

Derives multiple platform-adapted content formats from a single core topic and message, ensuring consistency of facts and tone across all outputs.

## Purpose

Take one core topic and produce multiple content formats — each adapted to its platform's tone, length, and audience — while keeping all factual claims consistent across the batch.

## Trigger

Apply when user requests:
- "content plan", "generate content variations", "content strategy", "repurpose content"
- "內容規劃", "批量生產內容", "多格式內容", "content batch"

Do NOT trigger for:
- Writing a single long-form article — use `article-writing`
- Editing an existing piece of content — handle inline

## Prerequisites

- A core topic or source material (can be a draft article, a product announcement, a research finding, etc.)
- Optional: list of target formats and specific audience notes per platform

## Steps

1. **Define the core message** — distill the topic into one sentence that every piece in this batch must communicate; get user confirmation before proceeding
2. **Select target formats** — choose from: blog post, LinkedIn post, tweet thread, TL;DR summary, email newsletter, FAQ; default to all six if the user does not specify
3. **Define the audience for each format** — audiences may differ by platform (LinkedIn: professionals in the field; Twitter/X: broader tech audience; email: existing subscribers)
4. **Generate each format** — adapt tone, length, and structure for the platform; do not copy-paste identical text across formats
5. **Consistency check** — verify all pieces agree on facts, key terms, and core message before delivering

## Output Format

File path: none (batch printed to user unless target files are specified)

```
## Content Batch: <Topic>

**Core message:** <one sentence>

### Blog Post (~800 words)
<content>

### LinkedIn Post (~300 words)
<content>

### Tweet Thread (5–7 tweets)
1/ <tweet>
2/ <tweet>
...

### TL;DR (2–3 sentences)
<content>

### Email Newsletter (~400 words)
**Subject:** <subject line>
<content>

### FAQ (5 questions)
**Q:** <question>
**A:** <answer>
...
```

## Rules

### Must
- Confirm the core message with the user before generating any format
- All formats must derive from and clearly express the same core message
- Adapt tone per platform: formal and insight-led for LinkedIn; conversational and punchy for Twitter/X; direct and scannable for email
- All factual claims must be identical across formats — no format may assert something another contradicts

### Never
- Never copy-paste identical text across formats without platform adaptation
- Never generate content without a confirmed target audience
- Never contradict facts between formats — run consistency check before output
- Never omit the core message statement from the output header

## Examples

### Good Example

User: "Create content about our new open-source observability tool that integrates with OpenTelemetry."

```
## Content Batch: OpenTelemetry-Native Observability Tool Launch

**Core message:** Our open-source tool makes OpenTelemetry integration production-ready in under an hour, with zero vendor lock-in.

### Blog Post (~800 words)
**Why We Built an OpenTelemetry-First Observability Tool**
Instrumenting a distributed system for observability used to mean...
[technical deep-dive with code examples, architecture diagram description]

### LinkedIn Post (~300 words)
We just open-sourced something we've been building for 18 months.
The problem: OpenTelemetry is the right standard, but getting it production-ready takes weeks...
[professional tone, focus on business impact, link to repo]

### Tweet Thread (5–7 tweets)
1/ We open-sourced our observability tool today. Here's why we built it and what makes it different 🧵
2/ OpenTelemetry adoption is rising fast — but production-readying it still takes weeks of config work...
[punchy, each tweet standalone, thread ends with CTA]

### TL;DR (2–3 sentences)
We released an open-source observability tool that wraps OpenTelemetry for production use. It reduces setup from weeks to under an hour and has no vendor lock-in. GitHub: [link]
```

### Bad Example

```
### Blog Post
Our new tool integrates with OpenTelemetry and is very easy to use.

### LinkedIn Post
Our new tool integrates with OpenTelemetry and is very easy to use.

### Tweet Thread
1/ Our new tool integrates with OpenTelemetry and is very easy to use.
```

> Why this is bad: All formats contain identical text with no platform adaptation. No core message defined. No audience differentiation. "Very easy to use" is a vague claim with no evidence. The consistency check was never done because there is nothing to check — all content is the same copy-paste block.
