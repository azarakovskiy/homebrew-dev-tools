# Skill: Review Change

## Use when
- Reviewing PRs, patches, or refactors.
- Performing quality and risk assessment before merge.

## Review order
1. Correctness
- Validate behavior against requirements.

2. Regression risk
- Identify what existing behavior can break.

3. Readability and maintainability
- Check clarity of intent, naming, and structure.

4. Architecture and boundaries
- Verify package/API boundaries and dependency direction.

5. Testing quality
- Ensure critical paths, error paths, and edge cases are covered.

6. Operational concerns
- Evaluate failure modes, observability, and performance impact.

## Output format
- Findings first, ordered by severity.
- Include file/line references and concrete fixes.
- Explicitly note residual risks and missing tests.
