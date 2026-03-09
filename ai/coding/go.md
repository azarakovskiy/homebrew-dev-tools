# Go Conventions

## Idiomatic defaults
- Follow `gofmt` formatting and idiomatic Go style.
- Keep packages cohesive with clear responsibilities.
- Prefer composition over inheritance-like patterns.

## Project layout
- Use `cmd/` for binaries and `internal/` for non-public packages when needed.
- Do not create extra layers or folders without a concrete need.
- Keep package names short, lower-case, and meaningful.

## APIs and interfaces
- Define interfaces at the point of use, not by default.
- Start with concrete types; introduce interfaces only for clear substitution or testing value.
- Keep interfaces small and behavior-focused.

## Error handling
- Return `error` values; avoid panic for expected failures.
- Wrap errors with context using `%w` when propagating.
- Check and handle all returned errors explicitly.

## Concurrency
- Add concurrency only when it improves measurable latency or throughput.
- Pass `context.Context` through request boundaries and honor cancellation.
- Ensure goroutines have clear lifecycle and termination paths.
- The sender closes channels; avoid unclear channel ownership.

## Data and performance
- Prefer zero-value-friendly types where practical.
- Avoid premature optimization; measure before tuning.
- Be explicit about pointer vs value semantics for mutability and copy cost.

## Senior Go priorities
- Reliability first: design for clear failure behavior, retries, idempotency, and safe rollback.
- Concurrency correctness: prevent goroutine leaks, honor cancellation, and validate with race-aware testing.
- API evolution: preserve compatibility where needed, keep contracts explicit, and avoid broad interfaces.
- Operability: emit actionable logs/metrics/traces so issues are diagnosable in production.
- Performance with evidence: use profiling/benchmarks before optimization and document bottlenecks addressed.
- Simplicity at scale: prefer straightforward package boundaries and code that other engineers can modify safely.
