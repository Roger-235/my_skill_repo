---
name: react-patterns
description: "React hooks rules, component design, state management, and Next.js Server Components / SSR/SSG best practices. Trigger when: React patterns, React best practices, hooks rules, Next.js patterns, SSR SSG, React conventions, 寫 React, React 規範, Next.js 最佳實踐."
metadata:
  category: dev
  version: "1.0"
---

# React Patterns

Enforces React hooks rules, proper component boundaries, appropriate state management, and correct use of Next.js Server vs Client Components.

## Purpose

Enforce React hooks rules, proper component boundaries, appropriate state management, and correct use of Next.js Server vs Client Components.

## Trigger

Apply when writing or reviewing React or Next.js code, or when the user asks about:
- "React patterns", "hooks rules", "React best practices"
- "Next.js patterns", "SSR SSG", "React conventions"
- "寫 React", "React 規範", "Next.js 最佳實踐"

Do NOT trigger for:
- Backend-only code with no React components
- Vue or Svelte projects — different frameworks
- Pure styling work — use the `ui-ux-pro-max` skill instead

## Prerequisites

- React 18+ project
- Next.js 13+ with App Router if Next.js-specific patterns are being reviewed

## Steps

1. **Verify hooks compliance** — hooks must only be called at the top level of a function component or custom hook; never inside loops, conditions, or nested functions; if a conditional hook is found, restructure the component so the condition wraps the entire component or extract a child component

2. **Audit `useEffect` dependencies** — every value referenced inside a `useEffect` callback must appear in the dependency array; an empty array `[]` means "run once on mount" — verify this is the deliberate intent; evaluate whether `useEffect` is needed at all: data fetching in Next.js App Router should use async Server Components or React Query/SWR

3. **Component design** — each component should have a single clear responsibility; extract complex logic into custom hooks named with the `use` prefix; component files exceeding 200 lines are a signal that decomposition is needed

4. **State management decision** — choose the right tool for the scope:
   - Local UI state → `useState`
   - Infrequently changing cross-component state → `useContext`
   - Server/async state → React Query or SWR
   - Complex global client state → Zustand or Jotai

5. **Next.js Server vs Client Components** — all components are Server Components by default (no directive needed); add `'use client'` only when the component needs: interactive event handlers, browser-only APIs, `useState`, or `useEffect`; keep the `'use client'` boundary as deep in the tree as possible; never import server-only code (database access, secrets) into a Client Component

## Output Format

File path: none (output is printed to the user)

```
## React Patterns Review: <component or page>

### Hooks Issues
| # | Issue | Location | Fix |
|---|-------|----------|-----|

### State Management Assessment
Current: <what is currently used>
Recommendation: <what should be used and why>

### Server vs Client Components (Next.js)
<per-component assessment with directive and rationale>

### Fixed Code
<corrected React / Next.js code>
```

## Rules

### Must
- Every `useEffect` must have an explicit dependency array (even if empty, with a comment explaining why)
- All custom hooks must start with `use` (enforced by the Rules of Hooks lint rule)
- Server Components must not import client-only code such as event handlers or browser APIs

### Never
- Never mutate state directly — always use the setter function or produce a new object/array
- Never call hooks conditionally or inside loops — restructure the component instead
- Never add `'use client'` to a parent component just because one child needs it — extract a minimal Client Component for the interactive part only
- Never use `useEffect` for data fetching in Next.js App Router — use async Server Components instead

## Examples

### Good Example

```tsx
// app/users/page.tsx — Server Component fetches data directly
export default async function UsersPage() {
  const users = await db.getUsers(); // server-side, no useEffect needed
  return <UserList users={users} />;
}

// app/users/UserList.tsx — Server Component, no directive
function UserList({ users }: { users: User[] }) {
  return (
    <ul>
      {users.map(u => (
        <li key={u.id}>
          {u.name} <DeleteButton userId={u.id} />
        </li>
      ))}
    </ul>
  );
}

// app/users/DeleteButton.tsx — minimal Client Component
'use client';
function DeleteButton({ userId }: { userId: number }) {
  return <button onClick={() => deleteUser(userId)}>Delete</button>;
}

// Custom hook encapsulates form logic
function useFormState(initial: FormValues) {
  const [values, setValues] = useState(initial);
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) =>
    setValues(prev => ({ ...prev, [e.target.name]: e.target.value }));
  return { values, handleChange };
}
```

Why this is good: page stays a Server Component and fetches data directly; only the interactive button is a Client Component with the boundary as deep as possible; custom hook is prefixed with `use` and encapsulates logic cleanly.

### Bad Example

```tsx
'use client'; // entire page forced to client
export default function UsersPage() {
  const [users, setUsers] = useState([]);

  useEffect(() => { // useEffect for data fetching in App Router
    fetch('/api/users').then(r => r.json()).then(setUsers);
  }, []);

  const handleDelete = (id) => {
    users.splice(users.findIndex(u => u.id === id), 1); // direct mutation
    setUsers(users); // same reference, React won't re-render
  };
  return <ul>{users.map(u => <li key={u.id}>{u.name}</li>)}</ul>;
}
```

Why this is bad: the whole page is `'use client'` for no reason, `useEffect` is used for data fetching instead of an async Server Component, and state is mutated directly with `splice` (same array reference, React will not detect the change).
