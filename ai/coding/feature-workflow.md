# Feature Implementation Workflow

Use this sequence for feature work:

1. Understand
- Clarify goal, constraints, and non-goals.
- Identify affected components and interfaces.
- Confirm acceptance criteria before coding.

2. Plan
- Break work into small, testable steps.
- Identify risks, edge cases, and migration impact.
- Decide validation strategy (tests, manual checks, metrics).

3. Implement
- Execute in small increments.
- Keep changes scoped to the agreed plan.
- Maintain readability and clear error handling.
- Keep each increment independently reviewable.

4. Validate
- Run relevant tests and checks.
- Verify acceptance criteria and error paths.
- Check for regressions in nearby behavior.
- Commit in small atomic units once each validated increment is stable.

5. Refactor
- Simplify after behavior is correct.
- Remove duplication and dead code introduced during implementation.
- Preserve behavior unless change is explicitly requested.
