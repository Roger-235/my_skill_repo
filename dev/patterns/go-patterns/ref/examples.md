# Go Patterns — Full Examples

## Good Example

Consumer-side interface, concrete return, error wrapped with context, goroutine cancelled via context:

```go
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

## Bad Example

Large interface defined next to its only implementation, errors discarded, goroutine with no exit path:

```go
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
