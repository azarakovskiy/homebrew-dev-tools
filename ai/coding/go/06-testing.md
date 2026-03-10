# Go Testing

- Use table-driven tests with `t.Run`.
- Prefer standard `testing` assertions (`t.Fatalf`, `errors.Is`, `errors.As`).
- Mark helper functions with `t.Helper()`.
- Use `go test ./...` as default suite command.
- Use interface mocks (`gomock`) only for boundary dependencies.
