---
name: typescript-patterns
description: "TypeScript strict mode and type annotation best practices. Enforces no-any, explicit return types, and correct interface usage. Trigger when: TypeScript patterns, TypeScript best practices, TS strict mode, type annotations, TypeScript conventions, 寫 TypeScript, TypeScript 規範, TS 型別."
metadata:
  category: dev
  version: "1.0"
---

# TypeScript Patterns

Enforces TypeScript strict mode conventions: eliminate `any`, require explicit types, and apply correct use of interfaces, type aliases, generics, and discriminated unions.

## Purpose

Enforce TypeScript strict mode conventions: eliminate `any`, require explicit types, and apply correct use of interfaces, type aliases, generics, and discriminated unions.

## Trigger

Apply when writing or reviewing TypeScript code, or when the user asks about:
- "TypeScript patterns", "TS strict", "TypeScript best practices"
- "type annotations", "TypeScript conventions"
- "寫 TypeScript", "TypeScript 規範", "TS 型別"

Do NOT trigger for:
- JavaScript-only code with no TypeScript types
- Runtime errors — use the `debug` skill instead
- Build failures — use the `build-fix` skill instead

## Prerequisites

- `tsconfig.json` must be accessible in the project root
- TypeScript project (`.ts` or `.tsx` files present)

## Steps

1. **Verify strict mode** — check that `tsconfig.json` contains `"strict": true`; if it is missing, add it and enumerate any new type errors that appear so they can be addressed in subsequent steps

2. **Eliminate `any`** — locate every `any` occurrence; replace with a specific type, `unknown` (with type narrowing), or a generic; document the rationale for each replacement

3. **Require explicit return types** — add return type annotations to all exported functions and public class methods; inferred return types are acceptable only for private/local helpers

4. **Choose interface vs type alias** — use `interface` for object shapes that may be extended or implemented by a class; use `type` for unions, intersections, tuple types, and mapped types

5. **Apply `readonly`** — mark function parameters and object properties that are never mutated as `readonly` to prevent accidental mutation

6. **Use discriminated unions** — for variant types, add a literal `kind` or `type` discriminant field to enable exhaustive `switch` checks and eliminate unsafe casts

## Output Format

File path: none (output is printed to the user)

```
## TypeScript Patterns Review: <file or component>

### tsconfig Check
strict: <enabled | missing — addition required>

### Issues Found
| # | Pattern | Location | Fix |
|---|---------|----------|-----|
| 1 | `any` type | line 42 | Replace with `User` interface |
| 2 | Missing return type | line 17 | Add `: string` to exported function |

### Fixed Code
<corrected TypeScript with proper types applied>
```

## Rules

### Must
- `"strict": true` must be confirmed present in `tsconfig.json` before applying any other fixes
- All exported functions and public class methods must have explicit return type annotations
- Every `any` replacement must use the narrowest correct type available in the codebase

### Never
- Never use `// @ts-ignore` except in test mocking utilities — always fix the underlying type issue
- Never cast with `as <Type>` without a preceding type guard that proves the cast is safe
- Never use `any` to silence type errors — prefer `unknown` with proper narrowing
- Never use `object` or `{}` as a type — always be specific about the shape

## Examples

### Good Example

```ts
// Before — missing return type, `any` parameter, `object` result type
function getUserName(user: any): object {
  return { name: user.name };
}

// After — explicit types throughout
interface User {
  id: number;
  name: string;
}

function getUserName(user: User): { id: number; name: string } {
  return { id: user.id, name: user.name };
}
```

Why this is good: `any` is replaced with the `User` interface (narrowest correct type), return type is explicit and specific, no unsafe casts needed.

### Bad Example

```ts
// Suppressing errors with @ts-ignore and `as any`
// @ts-ignore
const result = riskyFunction() as any;
const name = (result as any).name;
```

Why this is bad: `// @ts-ignore` and `as any` hide real type mismatches instead of fixing them. The underlying issue — `riskyFunction()` returning an unknown shape — must be modelled with a proper interface or `unknown` + type guard.
