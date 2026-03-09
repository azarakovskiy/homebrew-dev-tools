# Skill: Debug Issue

## Use when
- Reproducing and fixing bugs or regressions.
- Diagnosing flaky behavior or production incidents.

## Workflow
1. Reproduce
- Establish stable reproduction steps and expected vs actual behavior.

2. Observe
- Collect logs, traces, metrics, and input data needed to diagnose.

3. Hypothesize
- Form ranked root-cause hypotheses.

4. Isolate
- Run focused experiments that test one variable at a time.

5. Fix
- Implement minimal root-cause fix.
- Avoid symptom-only patches unless explicitly temporary.

6. Protect
- Add regression test coverage.
- Verify adjacent failure paths and rollback safety.

## Guardrails
- State evidence for root cause before finalizing.
- Improve observability when diagnosis confidence is low.
