---
name: build-fix
description: "Diagnoses and fixes build and compilation errors systematically. Trigger when: build fails, compilation error, build error, cannot build, build broken, linker error, type error at build time, 建置失敗, 編譯錯誤, build 出錯, 無法編譯."
metadata:
  category: dev
  version: "1.0"
---

# Build Fix

Systematically diagnoses build and compilation failures by identifying root cause rather than symptoms, then applies targeted fixes.

## Purpose

Systematically diagnose build and compilation failures by identifying root cause rather than symptoms, then apply targeted fixes that resolve the error without masking it.

## Trigger

Apply when the user reports:
- "build fails", "compilation error", "can't build", "build error", "build broken"
- "linker error", "type error at build time"
- "建置失敗", "編譯錯誤", "build 出錯", "無法編譯"

Do NOT trigger for:
- Runtime errors or test failures — use debug instead
- Linting warnings that do not block the build

## Prerequisites

- The full error output from the failed build command must be provided
- The build command used (e.g., `npm run build`, `go build ./...`, `cargo build`) must be known

## Steps

1. **Parse the error output** — extract: file path, line number, error code, and error message; if there are multiple errors, start with the first one (later errors are often downstream of the first)
2. **Classify the error type** — one of: syntax error, type error, import/dependency error, linker error, configuration error, environment issue
3. **Identify root cause** — trace the error to its actual origin, not just the line where it manifests; a type error on line 80 may originate from a wrong interface definition on line 12
4. **Apply the fix** — make the targeted, minimal change to address the root cause
5. **Rebuild** — run the exact same build command to verify the fix resolves the error
6. **If still failing** — return to Step 1 with the new error output; repeat until the build succeeds

## Output Format

```
## Build Fix: <build command>

**Error type:** <syntax / type / dependency / linker / config / environment>
**Root cause:** <one-line explanation>
**Location:** <file:line>

### Error Output
<relevant lines from build output>

### Fix Applied
<diff or description of change>

### Build Result
✓ Build succeeded  /  ✗ Still failing — see new error above
```

## Rules

### Must
- Always identify root cause, not just the immediate error line
- Always rebuild after applying a fix to confirm success
- Address the first error in the list before later errors — downstream errors often disappear once the root cause is fixed
- Show the relevant excerpt of the error output before proposing a fix

### Never
- Never suppress compiler errors with `@ts-ignore`, `#[allow(...)]`, `// nolint`, `pragma: nocover`, or equivalent directives as a fix
- Never delete failing tests or test files to make the build pass
- Never add `any` types or type assertions solely to silence TypeScript errors without fixing the underlying type issue
- Never modify `.gitignore` or build configuration to hide the problem from the build system

## Examples

### Good Example

```
## Build Fix: tsc --noEmit

**Error type:** type
**Root cause:** `getUserById` returns `User | undefined` but the caller treats it as `User` without a null check
**Location:** src/services/auth.ts:34

### Error Output
src/services/auth.ts:34:12 - error TS2532:
Object is possibly 'undefined'.
  34   return user.email;

### Fix Applied
\`\`\`ts
// Before
const user = getUserById(id);
return user.email;

// After
const user = getUserById(id);
if (!user) throw new Error(`User ${id} not found`);
return user.email;
\`\`\`

### Build Result
✓ Build succeeded
```

### Bad Example

```
## Build Fix: tsc --noEmit

The TypeScript error is annoying. I'll add `@ts-ignore` to suppress it:

\`\`\`ts
// @ts-ignore
return user.email;
\`\`\`

### Build Result
✓ Build succeeded
```

> Why this is bad: The underlying null-dereference bug still exists at runtime. `@ts-ignore` silences the compiler warning without fixing the problem, meaning the application will crash when `user` is `undefined`. This approach masks the issue rather than resolving it.
