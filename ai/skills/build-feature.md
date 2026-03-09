# Skill: Build Feature

## Use when
- Implementing a new feature or behavior change.
- Performing planned non-trivial code changes.

## Workflow
1. Understand
- Restate the requested outcome and acceptance criteria.
- Identify constraints, dependencies, and impacted code paths.

2. Plan
- Break work into small, testable increments.
- Define validation for each increment.

3. Implement
- Make one focused change at a time.
- Keep interfaces explicit and error handling clear.
- Write tests first when practical (especially bug fixes and core business logic).

4. Validate
- Run relevant tests/checks for each increment.
- Verify edge cases and regression risk.

5. Finalize
- Refactor only to simplify; avoid behavior drift.
- Keep commits atomic and reviewable.

## Guardrails
- Do not expand scope without explicit reason.
- Avoid speculative abstractions.
- Prefer small reversible steps over large rewrites.
