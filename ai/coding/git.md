# Git Workflow Standards

## Branching
- Use short-lived branches.
- Branch naming:
  - `feature/<short-description>`
  - `fix/<short-description>`
  - `refactor/<short-description>`
  - `chore/<short-description>`

## Commits
- Keep commits atomic: one concern per commit.
- Commit only files related to the change.
- Write commit messages in imperative mood.
- Preferred format: `type(scope): summary` (example: `fix(auth): handle expired token`).

## History hygiene
- Rebase on the target branch before opening or updating a PR when appropriate.
- Avoid noisy "WIP" history in shared branches.
- Do not rewrite history of shared branches unless coordinated.
- Prefer semi-linear history: each commit is atomic and the branch remains in a working state.
- Rebase feature branches onto the default branch before PR when team workflow allows.

## Pull requests
- Explain problem, approach, risks, and validation steps.
- Include test evidence for behavior changes.
- Keep PRs focused and reviewable; split oversized changes.
