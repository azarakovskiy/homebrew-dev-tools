# AI Coding Standards Bootstrap

Use this file as the entry point for local coding guidance.

## Load order
1. `ai/coding/general.md`
2. `ai/coding/testing.md`
3. `ai/coding/go.md` (when editing Go code)
4. `ai/coding/git.md` (when creating branches, commits, or PRs)
5. `ai/coding/feature-workflow.md` (for feature work)

## Execution style
- Build in explicit, small steps.
- Keep each change reviewable in size.
- Prefer atomic commits that preserve a working tree state.

## Skill system
Always load:
- `ai/skills/select-best-skill.md`

Then load one primary execution skill:
- `ai/skills/build-feature.md`
- `ai/skills/debug-issue.md`
- `ai/skills/review-change.md`

## Context budget
- Load at most 2 skill files at a time (`select-best-skill` + one execution skill).
- Load additional skill files only when the task explicitly requires mode switching.
- When switching skills, summarize prior state instead of loading all skills together.

## Conflict resolution
- Prefer explicit user request over defaults.
- If a project-local instruction file exists (for example `AGENTS.md`), project-local instructions override this global baseline.
- Prefer simpler and more readable solution when two options are valid.
- Keep changes minimal, reversible, and easy to review.

## Scope
- These are global personal standards, not project-specific conventions.
- Keep adapters for specific IDEs/agents separate from this core content.
