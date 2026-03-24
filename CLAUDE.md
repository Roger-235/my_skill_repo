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
| dev | quality (14) · patterns (4) · testing (5) · infra (12) · tools (3) · agents (7) · architecture (4) · api (4) · frontend (3) · backend (3) · data-ml (5) · workspace (4) · productivity (8) · release (5) | [dev/_index.md](dev/_index.md) |
| meta | skill-system (skill-design, skill-maker, skill-edit, skill-audit, skill-readme-sync, skill-index-sync, skill-library-lint, skill-security-auditor, skill-tester, skill-web-importer) · session (task-planner, checkpoint-recovery, continuous-learning, token-optimizer, pre-output-review, self-improving-agent, careful, freeze, retro) | [meta/_index.md](meta/_index.md) |
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
`argument-hint` · `user-invocable` · `disable-model-invocation` · `model` · `context` · `agent` · `license` · `compatibility` · `format` · `version` · `author`

**`allowed-tools` is NOT a valid frontmatter field** — tool restrictions go in Rules (Must/Never).

### Required sections (in order)
`## Purpose` · `## Trigger` · `## Prerequisites` · `## Steps` · `## Output Format` · `## Rules` (Must + Never) · `## Examples` (Good + Bad)

### Imported skill format exemption
Skills with `format: github-imported` in frontmatter are exempt from S5–S13 (body section structure). They must still satisfy S1–S4 (frontmatter), S14 (README.md), S15 (≤ 1000 lines), and S16 (no padding). Use this only for skills imported from external sources that have complete, working body content in a different structure.

### Constraints
- SKILL.md must stay under 1000 lines
- **Progressive Disclosure (required):** any section >50 lines of pure reference material (tables, API specs, extended examples, lookup data) must be moved to `ref/<topic>.md` and referenced by path — never inline bulk reference content in SKILL.md
- Every sentence must earn its place — no padding, no restatement, no filler phrases
- Folder name must exactly match `name` field in frontmatter
- `metadata.category` must match the parent category folder

### Skill Folder Structure (with Progressive Disclosure)

```
<skill-name>/
├── SKILL.md        ← core actionable content only
├── README.md       ← Chinese documentation
└── ref/            ← optional; created when any section exceeds 50 lines of reference material
    ├── examples.md
    ├── security-rules.md
    └── <topic>.md
```

Reference files in `ref/` use relative paths: `[<topic>.md](ref/<topic>.md)`

## Guide Skills

Every category must have exactly one `<category>-guide` skill. It routes users to the correct skill — never performs work itself. Required sections: `## Routing Table` and `## Skill Chains` (if ≥ 3 skills). When a skill is added, renamed, or removed, update the category guide's Routing Table.

## Pre-Edit Research (Required)

Before creating any skill or reference file, or modifying a `format: github-imported` skill:

1. **Search online broadly** — use WebSearch and WebFetch to find authoritative sources: existing implementations, official documentation, industry standards, or any reference material that will end up in `ref/` files; do not generate domain-specific facts from scratch when real sources exist
2. **Check the original repo** (for `format: github-imported` skills) — fetch the current version from the source repo (e.g. `raw.githubusercontent.com/alirezarezvani/claude-skills/main/...`) to see if there is a newer version; diff local vs. upstream before proposing changes
3. **Fetch reference files first** — if `references/` or `assets/` files are missing, attempt to download them from the original source before generating; only generate from scratch if the file genuinely does not exist upstream

**Why:** AI-generated reference content is inferior to authoritative sources. Fetched content is up-to-date, credible, and avoids duplication with upstream.

## Meta Skill Pipeline

When creating or modifying skills, these meta skills run in sequence:

```
skill-maker  →  skill-audit  →  skill-readme-sync  →  skill-index-sync
   (create)       (auto)           (auto)                  (auto)

skill-edit   →  skill-readme-sync  →  skill-audit  →  skill-index-sync
  (modify)          (auto)               (auto)            (if needed)

skill-web-importer  →  skill-maker  →  skill-audit  →  skill-readme-sync  →  skill-index-sync
  (web import gate)     (create)        (auto)             (auto)                  (auto)
```

`pre-output-review` auto-triggers before every response the user will act on or read.

### When to use `skill-edit` vs direct file edit

**Use `skill-edit`** (required) when:
- Trigger keywords change → must update category guide Routing Table
- Skill is renamed, moved, or deleted → must update index files
- Category changes → must move folder and update both guides

**Direct edit is fine** when:
- Fixing a typo, improving wording, adjusting a description
- Adding/fixing a section that has no index or routing impact
- The only file changing is the SKILL.md body (no trigger or name change)

After any direct edit, manually run `skill-audit` to confirm no regressions.

### Security auditor boundary

| Use case | Skill |
|----------|-------|
| Audit a skill you are creating | `skill-audit` (invokes `security-audit`) |
| Scan a third-party skill before installing | `skill-security-auditor` (static script scan) |
| Import / adapt a skill found on the web | `skill-web-importer` (mandatory pre-creation gate — run before skill-maker) |

### Learning pipeline

| Use case | Skill |
|----------|-------|
| Save a new pattern from this conversation | `continuous-learning` |
| Review + graduate existing memories to rules | `self-improving-agent` (`/si:review`, `/si:promote`) |

## Category `_index.md` Files

Each category has a `_index.md` with a compact table (skill name · one-line description · trigger keywords). Update when adding, renaming, or removing a skill in that category. Also update the root `_index.md` if the skill count changes.

## Context Engineering Rules

### CLAUDE.md Pruning Principle (for target projects)

Every line in a deployed CLAUDE.md must pass this test:
> **"Would removing this line cause Claude to make a mistake?"**
> If no → delete it. If yes → keep it.

Do not add length limits — prune by value, not by count. Common lines to cut:
- Things Claude already knows from reading the code
- Standard conventions the language/framework already enforces
- Explanations and tutorials (link instead)
- File-by-file descriptions of the codebase

### `@` Import Syntax

Reference external files instead of duplicating content:
```markdown
See @.claude/skill/dev/_index.md for available dev skills.
Git workflow: @docs/git-instructions.md
```
This keeps CLAUDE.md lean while making full content available just-in-time.

### Hooks vs Instructions

| Mechanism | Enforcement | Use for |
|-----------|-------------|---------|
| CLAUDE.md instruction | ~70% (advisory) | Preferences, style guidelines |
| PreToolUse hook | 100% (deterministic) | Critical rules: block dangerous commands, enforce secret scanning |
| PostToolUse hook | 100% (deterministic) | Automatic linting, test runs after edits |

Critical security rules (block `rm -rf`, protect `CLAUDE.md`/`settings.json`, detect secrets) **must** be hooks, not CLAUDE.md instructions. See `hooks/` for deployable hook scripts.

| Hook | Tool intercepted | Blocks |
|------|-----------------|--------|
| `careful-mode.sh` | Bash (PreToolUse) | Destructive commands, credential file reads |
| `protect-critical-files.sh` | Edit/Write (PreToolUse) | Direct edits to `settings.json`, `.env*` |
| `post-edit-lint.sh` | Edit/Write (PostToolUse) | Non-blocking; runs linter after each edit |

### `disable-model-invocation: true`

Add this frontmatter flag to skills with significant side effects that must only run when explicitly invoked. Prevents accidental auto-triggering from keyword matches.

Apply to: `standup-notes`, `project-bootstrap`, `canary`, `retro`, `document-release`, `spec-writer`.

### Subagent Pattern for Investigation

For tasks that read many files (codebase exploration, security review, dead code scan), delegate to a subagent so the main context stays clean:
```
"Use a subagent to investigate how authentication handles token refresh."
```
Subagent reads files, returns a 1–2K token summary — main context untouched.
Agent definitions for deployment live in `agents/`. See `agents/README.md`.

### Deployed Project Structure

A project using this skill library should have:
```
.claude/
├── CLAUDE.md          ← lean project rules + @ imports
├── skill/             ← copy from this repo's categories
│   ├── dev/
│   ├── meta/
│   └── ...
├── agents/            ← copy from this repo's agents/
│   ├── security-reviewer.md
│   ├── code-auditor.md
│   └── researcher.md
└── settings.json      ← hooks (copy from hooks/settings.json)
```
See `agents/deployment-template.md` for the full CLAUDE.md starter template.
