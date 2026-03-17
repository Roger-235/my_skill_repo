# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

A skill library for Claude Code. Skills are markdown files that instruct Claude how to behave when triggered. This repo is the **authoring environment** — skills are deployed by copying to `.claude/skill/` in target projects.

## Folder Structure

```
skill/
├── _index.md                        ← root index (all categories)
├── <category>/
│   ├── _index.md                    ← grouped skill list for this category
│   ├── <category>-guide/            ← routing-only skill (required per category)
│   │   ├── SKILL.md
│   │   └── README.md
│   ├── <subcategory>/               ← optional grouping (used in dev/ and meta/)
│   │   ├── _index.md                ← compact skill list for this subcategory
│   │   └── <skill-name>/
│   │       ├── SKILL.md             ← skill definition
│   │       └── README.md            ← Chinese documentation
│   └── <skill-name>/                ← skills not in a subcategory
│       ├── SKILL.md
│       └── README.md
```

Valid categories: `dev` · `design` · `writing` · `ops` · `data` · `security` · `meta` · `business`

## Skill Index

See [`_index.md`](_index.md) for the full cross-category index, or per-category:

| Category | Subcategories | `_index.md` |
|----------|--------------|-------------|
| dev | quality · patterns · testing · infra · tools · agents · architecture · api · frontend · backend · data-ml · workspace · productivity · release | [dev/_index.md](dev/_index.md) |
| meta | skill-system (skill-design, skill-maker, skill-edit, skill-audit, skill-readme-sync, skill-index-sync, skill-library-lint, skill-security-auditor, skill-tester) · session (task-planner, checkpoint-recovery, continuous-learning, token-optimizer, pre-output-review, self-improving-agent) | [meta/_index.md](meta/_index.md) |
| business | c-suite (28) · marketing (43) · product (13) · finance (2) · compliance (12) · project-mgmt (6) · growth (4) | [business/_index.md](business/_index.md) |
| data | — | [data/_index.md](data/_index.md) · db-schema, financial-modeling, market-research |
| ops | — | [ops/_index.md](ops/_index.md) · ci-cd-pipeline, deploy-ops |
| writing | — | [writing/_index.md](writing/_index.md) · article-writing, content-engine |
| design | — | [design/_index.md](design/_index.md) · ui-ux-pro-max |
| security | — | [security/_index.md](security/_index.md) · security-audit |

## SKILL.md Format

### Required frontmatter fields
```yaml
name: kebab-case-name          # must match folder name; max 64 chars
description: "..."             # third-person, active, trigger keywords; max 1024 chars
metadata:
  category: <category>         # must match parent folder name
```

### Valid optional frontmatter fields
`argument-hint` · `user-invocable` · `disable-model-invocation` · `model` · `context` · `agent` · `license` · `compatibility` · `format`

**`allowed-tools` is NOT a valid frontmatter field** — tool restrictions go in Rules (Must/Never).

### Required sections (in order)
`## Purpose` · `## Trigger` · `## Prerequisites` · `## Steps` · `## Output Format` · `## Rules` (Must + Never) · `## Examples` (Good + Bad)

### Imported skill format exemption
Skills with `format: github-imported` in frontmatter are exempt from S5–S13 (body section structure). They must still satisfy S1–S4 (frontmatter), S14 (README.md), S15 (≤ 1000 lines), and S16 (no padding). Use this only for skills imported from external sources that have complete, working body content in a different structure.

### Constraints
- SKILL.md must stay under 1000 lines; move reference content to subdirectory files if needed
- Every sentence must earn its place — no padding, no restatement, no filler phrases
- Folder name must exactly match `name` field in frontmatter
- `metadata.category` must match the parent category folder

## Guide Skills

Every category must have exactly one `<category>-guide` skill. It routes users to the correct skill — never performs work itself. Required sections: `## Routing Table` and `## Skill Chains` (if ≥ 3 skills). When a skill is added, renamed, or removed, update the category guide's Routing Table.

## Meta Skill Pipeline

When creating or modifying skills, these meta skills run in sequence:

```
skill-maker  →  skill-audit  →  skill-readme-sync
   (create)       (auto)           (auto after edit)

skill-edit   →  skill-readme-sync  →  skill-audit
  (modify)          (auto)               (auto)
```

`pre-output-review` auto-triggers before every substantive output.

## Category `_index.md` Files

Each category has a `_index.md` with a compact table (skill name · one-line description · trigger keywords). Update when adding, renaming, or removing a skill in that category. Also update the root `_index.md` if the skill count changes.
