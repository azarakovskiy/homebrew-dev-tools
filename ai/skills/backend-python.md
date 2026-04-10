---
description: Use for Python backend implementation or review in services, scripts, workers, and tooling.
---

These rules apply:

- prefer simple, readable code over cleverness
- keep functions small and explicit
- make side effects obvious
- validate inputs at boundaries
- keep module responsibilities clear
- avoid unnecessary framework magic in core logic
- structure code for unit testing first
- handle exceptions explicitly and with context

Before finishing:
- check module boundaries
- check error handling
- check typing where the project uses it
- check testability