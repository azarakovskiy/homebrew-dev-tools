# General Engineering Standards

## Core principles
- Prefer simple, explicit designs over clever abstractions.
- Optimize for maintainability, readability, and safe change.
- Keep scope tight; do not add speculative features.

## Code shape
- Keep functions focused on one responsibility.
- Keep files reasonably small; split when a file becomes hard to navigate.
- Avoid deep nesting; use early returns for clarity.

## Naming and APIs
- Use domain language in names; avoid vague names like `data`, `util`, `helper`.
- Make side effects explicit in function names and signatures.
- Keep public APIs minimal and stable.

## Dependencies
- Prefer standard library and existing project patterns first.
- Add third-party dependencies only with clear payoff.
- Ask for explicit approval before adding new dependencies when security, licensing, or long-term maintenance tradeoffs are non-trivial.
- Remove unused dependencies quickly.

## Error handling
- Fail fast on invalid state and impossible conditions.
- Do not swallow errors; return or handle with clear intent.
- Add context to propagated errors so failures are diagnosable.

## Configuration and observability
- Prefer explicit configuration over hidden globals.
- Log meaningful events and errors with enough context to debug.

## Non-trivial task discipline
- Plan: break work into concrete steps before coding.
- Implement: execute incrementally and keep scope controlled.
- Verify: check correctness, edge cases, and requirement alignment.
- Reflect: improve weak spots before finalizing.
