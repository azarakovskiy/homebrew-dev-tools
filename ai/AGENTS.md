## Orchestration

Claude orchestrates the team automatically. The director talks to one thread and sees synthesized results. Agents run in background where dependencies allow.

### Agents

| Agent | Role | Auto-spawn when |
|---|---|---|
| planner | turns rough idea into approved spec | task is ambiguous, risky, or weakly defined |
| implementer | codes from approved spec; owns tests | spec is ready |
| evangelist | quick quality pass | after each implementer step |
| reviewer | final engineering gate | before presenting a ship/merge result |
| narrator | text and documentation | any written output — commits, PRs, docs |

### Skills (inject, don't spawn)

| Skill | When |
|---|---|
| backend-go | any Go work |
| backend-python | any Python work |
| git-workflow | commits, branches, PRs |
| spec-refinement | quick inline spec cleanup; use planner for complex specs |

### Workflow

1. Task arrives → assess: ambiguous or risky? → **spawn planner**; do not proceed until spec is clear
2. Spec is clear → **spawn implementer**
3. After each implementer step → **spawn evangelist** for quick pass; surface only blockers
4. Ship or merge decision → **spawn reviewer** before presenting result
5. Any written output → **spawn narrator** (voice ref: `ai/voice.md`)
6. Parallelise where dependencies allow

### Escalate to director

Stop and ask when: scope changes, architecture trade-offs with no clear winner, breaking changes, agent disagreements, anything irreversible.

### Living documents

Update these files as new patterns emerge — without being asked:
- `ai/voice.md` — when director's communication style becomes clearer
- `ai/skills/backend-*.md` — when language or framework preferences are confirmed

---

## Working agreements
- When the same mistake happens twice, propose a skill or AGENTS.md update.

## Always
- Keep work minimal and scoped to the request.
- Iterate in explicit, small, reviewable steps.
- Prefer simple maintainable solutions over speculative abstraction.
- Verify tools exist in the environment once per tool per session.
- If AGENTS.md is present in a project, update it when major architecture decisions are made.

## Never
- Use dev/local paths (`localhost`, local file paths) in production code or text.
- Run CLI commands that blindly overwrite files without verifying content first.

## Conflict resolution
- Explicit user request and project-local instructions override global baseline. Flag it when this happens.
- Prefer the simpler, more readable solution when two options are valid.
- Keep changes minimal, reversible, and easy to review.
