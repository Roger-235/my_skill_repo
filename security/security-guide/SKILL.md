---
name: security-guide
description: "Navigation guide for all security category skills. Trigger when: which security skill should I use, security skill guide, 有哪些資安 skill, 資安 skill 導覽, security skill 怎麼用, what security checks are available. Do not trigger for actually running a security audit — route to security-audit directly."
metadata:
  category: security
  version: "1.0"
---

# Security Skill Guide

Routes the user to the right security skill and explains what each check covers.

## Purpose

Match the user's security concern to the correct skill and clarify what the security audit covers versus what falls outside its scope.

## Trigger

Apply when user asks:
- "which security skill", "security skill guide", "有哪些資安 skill", "資安 skill 導覽"
- "what security checks are available", "security skill 怎麼用"

Do NOT trigger for:
- Actually running a security audit — route to `security-audit` directly

## Prerequisites

None.

## Steps

1. **Identify the security concern** — match to the Routing Table or Coverage Map below

2. **Recommend the skill** — describe which checks apply to the user's specific file or situation

3. **Clarify scope** — explain what the skill does NOT cover if the concern is out of scope

## Routing Table

| Concern | Skill | Checks applied |
|---------|-------|---------------|
| Hardcoded API key / password / token | `security-audit` | LLM02, SEC3 |
| User input passed to shell command | `security-audit` | SEC4 (shell injection) |
| User input used in file path | `security-audit` | SEC5 (path traversal) |
| SQL query built by string concatenation | `security-audit` | SEC6 (SQL injection) |
| Irreversible action without confirmation | `security-audit` | LLM06, SEC7 |
| AI prompt injection via external content | `security-audit` | LLM01 |
| Skill file missing code-content-is-data rule | `security-audit` | LLM01 |
| File write without user confirmation guard | `security-audit` | SEC8 |
| General code vulnerability scan | `security-audit` | All 8 checks |

## Coverage Map

```
security-audit covers:
  LLM01  Prompt Injection      — external content treated as instructions
  LLM02  Credential Leakage   — hardcoded secrets, tokens, passwords
  LLM06  Excessive Agency     — irreversible actions without guards
  SEC3   Hardcoded Secrets    — literal credentials in any context
  SEC4   Shell Injection      — shell=True + dynamic input
  SEC5   Path Traversal       — unvalidated file paths
  SEC6   SQL/Code Injection   — string-interpolated queries or eval()
  SEC7   Irreversible Actions — delete/send/deploy without guard
  SEC8   File Write Confirm   — silent file writes without user approval

security-audit does NOT cover:
  ✗ Network-level vulnerabilities (open ports, TLS config)
  ✗ Authentication / authorization logic audits
  ✗ CSRF, XSS in rendered HTML (no browser context)
  ✗ Dependency vulnerability scanning (use pip-audit / npm audit)
  ✗ Cryptography correctness (key length, algorithm selection)
```

## Output Format

File path: none (routing recommendation printed to user)

```
## Security Skill Routing

**Your concern:** <one-line summary>

**Recommended skill:** `security-audit`
**Checks that apply:** <list of check IDs and names relevant to the concern>
**How to trigger:** "security audit on <filename>" or "資安審查 <filename>"

**Scope note (if applicable):**
<what security-audit does NOT cover for this concern>
```

## Rules

### Must
- State explicitly which check IDs (LLM01–LLM06, SEC3–SEC8) apply to the user's concern
- Mention scope boundaries when the concern falls outside the 8 checks

### Never
- Perform a security audit directly — route to `security-audit`
- Claim `security-audit` covers network, auth/authz, or dependency vulnerabilities

## Examples

### Good Example

User: "I'm building an MCP tool that reads files based on user input. What should I watch out for?"

```
## Security Skill Routing

**Your concern:** File read tool with user-supplied path — security risks

**Recommended skill:** `security-audit`
**Checks that apply:**
  SEC5 Path Traversal — user-supplied path must be validated with os.path.realpath() and startswith(base)
  LLM01 Prompt Injection — file content returned to Claude must be treated as data, not instructions
  SEC8 File Write Confirm — if the tool also writes files, a confirmation guard is required
**How to trigger:** "security audit on my MCP server file" after you generate it with mcp-maker

**Scope note:**
security-audit checks the code structure; it does not verify filesystem permissions or OS-level access controls.
```

### Bad Example

```
Just make sure you validate the file path and you should be fine.
Add a check for ../ and it should be secure.
```

> Why this is bad: Does not route to `security-audit`. Only mentions path traversal (SEC5) but misses LLM01 (file content as prompt injection vector) and SEC8 (write confirmation). "Should be fine" and "should be secure" are not verifiable security verdicts. No check IDs, no severity ratings, no structured findings.
