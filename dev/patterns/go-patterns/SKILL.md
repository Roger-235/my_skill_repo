---
name: go-patterns
description: "Go idiomatic patterns: small interfaces, structured error handling, safe concurrency, and standard package layout. Trigger when: Go patterns, Go best practices, Golang idioms, Go conventions, Go error handling, Go concurrency, 寫 Go, Go 規範, Golang."
metadata:
  category: dev
  version: "1.0"
---

# Go Patterns

Enforces Go idiomatic patterns: small consumer-defined interfaces, structured error wrapping, goroutine lifecycle management, and standard package layout.

## Purpose

Enforce Go idiomatic patterns: small consumer-defined interfaces, structured error wrapping, goroutine lifecycle management, and standard package layout.

## Trigger

Apply when writing or reviewing Go code, or when the user asks about:
- "Go patterns", "Golang idioms", "Go best practices"
- "Go error handling", "Go concurrency", "Go conventions"
- "寫 Go", "Go 規範", "Golang"

Do NOT trigger for:
- Runtime panics requiring stack trace analysis — use the `debug` skill instead
- Build errors — use the `build-fix` skill instead

## Prerequisites

- Go 1.21+ project with a `go.mod` file present

## Steps

1. **Interface design** — keep interfaces small (1–2 methods is ideal); define interfaces at the consumer (the package that uses them), not at the producer (the package that implements them); functions should accept interfaces and return concrete structs

2. **Error handling** — wrap errors with context using `fmt.Errorf("operation failed: %w", err)`; inspect errors with `errors.Is` and `errors.As`; never discard a returned error by assigning it to `_`; always handle or propagate — never swallow silently

3. **Concurrency safety** — every goroutine must have a clearly defined lifetime and an exit condition; use `context.Context` for cancellation and timeout propagation; close channels only from the producer side; prefer `sync.WaitGroup` over `time.Sleep` for synchronization; protect shared state with `sync.Mutex` or `sync/atomic`

4. **Package structure** — place executable entry points in `cmd/`; use `internal/` for packages not intended to be imported outside the module; use `pkg/` for reusable packages intended for external consumption

5. **Naming conventions** — keep variable names short in small scopes (`i`, `v`, `err`); use descriptive names for package-level declarations; avoid stutter (`user.UserID` → `user.ID`); unexported identifiers for package-internal types; exported identifiers must have a doc comment

## Output Format

File path: none (output is printed to the user)

```
## Go Patterns Review: <package>

### Interface Issues
<list with before/after>

### Error Handling Issues
```go
// Before
result, _ := someFunc()

// After
result, err := someFunc()
if err != nil {
    return fmt.Errorf("context: %w", err)
}
```

### Concurrency Issues
<list of goroutine lifetime and synchronization problems>

### Package Structure
<assessment of cmd / internal / pkg layout>
```

## Rules

### Must
- All returned errors must be handled — never use `_` to discard an error return value
- `context.Context` must be the first parameter of any function that may be cancelled or time out
- Every goroutine must have a documented exit condition (channel close, context cancellation, or WaitGroup)

### Never
- Never use `panic` in library code — return an error instead
- Never share memory across goroutines without synchronisation (mutex, channel, or atomic operation)
- Never define an interface in the same package that provides its only implementation — accept interfaces, return concretes
- Never use `init()` for logic that can fail — move fallible initialisation to an explicit constructor function

## Examples

### Good Example

```go
// Consumer-side interface, concrete return, error wrapped with context,
// goroutine cancelled via context
type Reader interface {
    Read(ctx context.Context) ([]byte, error)
}

func FetchData(ctx context.Context, r Reader) (*Response, error) {
    data, err := r.Read(ctx)
    if err != nil {
        return nil, fmt.Errorf("fetch data: %w", err)
    }
    return parseResponse(data), nil
}

func startWorker(ctx context.Context, wg *sync.WaitGroup, jobs <-chan Job) {
    defer wg.Done()
    for {
        select {
        case <-ctx.Done():
            return
        case job, ok := <-jobs:
            if !ok {
                return
            }
            process(job)
        }
    }
}
```

Why this is good: interface defined at the consumer, concrete struct returned, error wrapped with `%w`, goroutine exits cleanly on context cancellation or channel close.

### Bad Example

```go
// Large interface defined next to its only implementation,
// errors discarded, goroutine with no exit path
type DataService interface {
    Read() ([]byte, error)
    Write([]byte) error
    Delete(id int) error
    List() ([]Item, error)
    Update(Item) error
    Ping() error
    Close() error
    Stats() Stats
    Reset() error
    Migrate() error
}

func processAll() {
    result, _ := fetchData()   // error silently discarded
    go func() {
        for {                  // no exit condition
            doWork(result)
        }
    }()
}
```

Why this is bad: the 10-method interface is defined beside its only implementation (no abstraction benefit), `_` silently drops the error, and the goroutine spins forever with no cancellation path.
