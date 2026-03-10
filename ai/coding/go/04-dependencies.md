# Go Dependencies

- Keep `go.mod` direct requirements intentional and minimal.
- Pin tool install versions in automation (`go install ...@version`).
- Prefer explicit generation workflows (`go:generate` or Make targets) for codegen tools.
- Remove unused modules with `go mod tidy`.
