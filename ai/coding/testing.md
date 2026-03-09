# Testing Standards

## Goals
- Protect behavior, not implementation details.
- Prioritize tests for business logic, edge cases, and error paths.

## Test quality
- Keep tests deterministic and isolated.
- Avoid flaky tests and hidden shared state.
- Use clear arrange/act/assert structure.
- Name tests by behavior and scenario, not internal method names.

## Scope and balance
- Add tests for new behavior and bug fixes.
- Prefer fast unit tests; add integration tests where boundaries matter.
- Avoid network, clock, randomness, and external process dependency unless required.

## Reliability
- Control time and randomness through injection or fakes.
- Use fixtures/builders sparingly; keep setup explicit and readable.
- Ensure failures are easy to diagnose from test output.
