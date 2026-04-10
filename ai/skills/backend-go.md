---
description: Use for Golang backend implementation or review in services, APIs, workers, and CLIs.
---

These rules apply:

## Code style
- Prefer simple, idiomatic Go
- Keep interfaces consumer-driven, small, and defined in the consuming package
- Use `context.Context` for request-scoped operations
- Wrap errors with context before returning up the stack
- Avoid premature abstraction and hidden global state
- Keep functions cohesive and easy to test

## Repository structure
- Keep binaries thin in `cmd/<binary>/main.go`
- Non-exported code under `internal/`
  - `internal/config` — runtime config loading and validation
  - `internal/domain` — pure business rules, algorithms, value types
  - `internal/tech` — integrations and runtime concerns
  - `internal/mocks` — generated mocks
- Add `internal/app` orchestration only when it simplifies current code
- `main` owns: load config, wire dependencies, handle lifecycle, start app — nothing else

## Testing
- Keep tests next to the package they exercise
- Prefer table-driven tests when they improve coverage and readability
- Generate mocks from real consumer-owned interfaces; place `//go:generate` above the interface in the production package
- Keep generated code out of production packages unless the tool requires otherwise

## Dependencies
- HTTP: [gin](https://github.com/gin-gonic/gin) unless already established
- Mocking: [uber-go/mock](https://github.com/uber-go/mock) unless already established
- Assertions: [testify](https://github.com/stretchr/testify) unless already established

## Before finishing
- Check naming and package placement
- Check error paths and context wrapping
- Check cancellation / timeouts where relevant
- Check testability
