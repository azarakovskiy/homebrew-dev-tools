# Go Core Rules

- Keep exported API small; hide implementation in unexported types/functions.
- Use `New...` constructors when dependencies or invariants must be enforced.
- Prefer concrete types as return values; define interfaces at consuming packages.
- Decide pointer vs value receivers explicitly (mutation, copy cost, method set).
- Design structs to be useful with zero values when feasible.
