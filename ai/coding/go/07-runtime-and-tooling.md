# Go Runtime And Tooling

- Accept `context.Context` as the first parameter for request-scoped operations.
- Do not store contexts in structs.
- Handle process signals with `signal.NotifyContext` and graceful shutdown timeouts.
- Use explicit Go quality commands: `gofmt -w .`, `go vet ./...`, `go test ./...`.
- Keep Go build/lint/test/generate flows codified in `Makefile` targets.
