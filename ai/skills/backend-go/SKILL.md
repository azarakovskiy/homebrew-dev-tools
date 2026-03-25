---
name: backend-go
description: Use for Golang backend implementation or review in services, APIs, workers, and CLIs.
---

Apply these Go rules:

- prefer simple, idiomatic Go
- keep interfaces consumer-driven and small
- use context.Context for request-scoped operations where appropriate
- wrap errors with useful context
- avoid premature abstraction
- avoid hidden global state
- keep functions cohesive and easy to test
- keep package boundaries clear
- prefer table-driven tests where they fit naturally

Before finishing:
- check naming and package placement
- check error paths
- check cancellation / timeouts where relevant
- check testability