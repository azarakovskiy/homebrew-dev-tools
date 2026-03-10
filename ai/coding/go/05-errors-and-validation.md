# Go Errors And Validation

- Return errors, do not panic for expected failures.
- Wrap propagated errors with context using `fmt.Errorf("...: %w", err)`.
- Compare errors with `errors.Is` / `errors.As` (never by message text).
- Use sentinel `var` errors (`errors.New(...)`) for stable categories.
- Use typed validation errors when field-level detail is required.
- Translate lower-level errors at package boundaries into stable domain/service errors.
