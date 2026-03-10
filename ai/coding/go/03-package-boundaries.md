# Go Package Boundaries

- Use `cmd/<app>` for entrypoints and process wiring.
- Use `internal/` for non-public code.
- Keep business logic outside `cmd` and transport packages.
- Keep adapter conversion code explicit between API/domain/storage types.
- Keep generated code isolated in dedicated packages/files.
- Avoid cyclic imports; package boundaries must compile independently.
