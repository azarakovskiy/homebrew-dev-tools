# Meta-Skill: Select Best Skill

## Objective
Choose the minimum skill set needed for the current task.

## Context budget
- Always load this file first.
- Load exactly one execution skill by default.
- Maximum loaded skills: 2 total (`select-best-skill` + one execution skill).
- Switch skills only when task mode changes (for example implementation to review).

## Available execution skills
- `ai/skills/build-feature.md`: new features, enhancements, or planned code changes.
- `ai/skills/debug-issue.md`: bug investigation, production issues, flaky tests, regressions.
- `ai/skills/review-change.md`: code review, risk assessment, and quality gate checks.

## Selection logic
1. Identify primary task intent from user request.
2. Pick one execution skill that best matches that intent.
3. If request mixes intents, start with the dominant one and defer others.
4. Switch skill only after completing current phase and summarizing state.

## Senior Go priority lens
When multiple paths are possible, prioritize:
- correctness and failure handling over speed of coding;
- concurrency safety and goroutine lifecycle clarity;
- API stability and clear boundaries between packages;
- observability (logs/metrics/traces) for operability;
- measurable performance work, not speculative optimization;
- simple designs that are easy to maintain.
