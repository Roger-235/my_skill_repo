---
name: python-patterns
description: "Python code quality standards: PEP 8 formatting, type hints, Google-style docstrings, and modern Python idioms. Trigger when: Python patterns, Python best practices, PEP 8, type hints, Python conventions, 寫 Python, Python 規範, Python 型別標注."
metadata:
  category: dev
  version: "1.0"
---

# Python Patterns

Enforces Python code quality through PEP 8 compliance, complete type hints, Google-style docstrings, and modern Python idioms.

## Purpose

Enforce Python code quality through PEP 8 compliance, complete type hints, Google-style docstrings, and modern Python idioms (f-strings, pathlib, dataclasses).

## Trigger

Apply when writing or reviewing Python code, or when the user asks about:
- "Python patterns", "PEP 8", "type hints"
- "Python best practices", "Python conventions"
- "寫 Python", "Python 規範", "Python 型別標注"

Do NOT trigger for:
- Runtime errors — use the `debug` skill instead
- Data science / ML model analysis — that is a separate domain

## Prerequisites

- Python 3.10+ (required for modern type hint syntax: `list[str]`, `X | None`)
- Project should have a linter configured: `flake8`, `ruff`, or `pylint`

## Steps

1. **Check PEP 8 compliance** — verify `snake_case` for functions and variables, `PascalCase` for classes, `UPPER_CASE` for module-level constants; line length ≤ 88 characters (Black default); exactly two blank lines between top-level definitions

2. **Add type hints** — annotate all function parameters and return values; use `list[str]` not `List[str]` (Python 3.10+ built-in generics); use `X | None` not `Optional[X]`; use `-> None` explicitly for functions with no meaningful return value

3. **Add Google-style docstrings** — every public function and class must have a one-line summary followed by `Args:`, `Returns:`, and `Raises:` sections where applicable; one-liners are acceptable only for trivial private helpers

4. **Apply modern Python idioms** — f-strings instead of `.format()` or `%`; `pathlib.Path` instead of `os.path`; `@dataclass` for data containers instead of plain dicts or manual `__init__`; walrus operator (`:=`) for conditional assignment where it improves readability

5. **Fix error handling** — every `except` clause must name a specific exception type; never use bare `except:`; log or re-raise the exception — never silently swallow it

## Output Format

File path: none (output is printed to the user)

```
## Python Patterns Review: <file>

### PEP 8 Issues
<list of naming and formatting violations>

### Type Hints Added
```python
# Before
def process(data, config=None):

# After
def process(data: list[dict], config: Config | None = None) -> list[Result]:
```

### Docstrings Added
```python
def process(data: list[dict], config: Config | None = None) -> list[Result]:
    """Process input data according to the provided configuration.

    Args:
        data: List of raw data dictionaries to process.
        config: Processing configuration. Uses defaults if None.

    Returns:
        List of processed Result objects.

    Raises:
        ValueError: If data contains invalid entries.
    """
```

### Modern Idioms Applied
<list of before/after replacements>
```

## Rules

### Must
- Every public function and class must have a Google-style docstring
- Every function parameter and return value must have a type hint
- Use specific exception types in all `except` clauses

### Never
- Never use bare `except:` without specifying the exception type
- Never use mutable default arguments: `def foo(items=[])` → use `def foo(items: list | None = None)`
- Never use `print()` for logging in production code — use the `logging` module
- Never add `# type: ignore` comments to suppress type errors without understanding and documenting the root cause

## Examples

### Good Example

```python
# Before — no types, no docstring, legacy string formatting, bare except
def process_users(data, config=None):
    try:
        results = []
        for item in data:
            results.append("User: %s" % item["name"])
        return results
    except:
        return []

# After — type hints, Google docstring, f-string, specific exception
from dataclasses import dataclass

@dataclass
class Config:
    prefix: str = "User"

def process_users(
    data: list[dict],
    config: Config | None = None,
) -> list[str]:
    """Format user display names from raw data.

    Args:
        data: List of dicts each containing a 'name' key.
        config: Display configuration. Uses defaults if None.

    Returns:
        List of formatted user name strings.

    Raises:
        KeyError: If any dict in data is missing the 'name' key.
    """
    cfg = config or Config()
    return [f"{cfg.prefix}: {item['name']}" for item in data]
```

Why this is good: complete type hints with modern syntax, Google-style docstring with all sections, f-string, specific exception handling, dataclass instead of raw dict.

### Bad Example

```python
# type: ignore comments everywhere, bare except, no types
def get_data(id):
    try:
        return fetch(id)  # type: ignore
    except:
        pass
```

Why this is bad: `# type: ignore` hides real issues, bare `except:` swallows all errors silently (including `KeyboardInterrupt`), no type hints, no docstring.
