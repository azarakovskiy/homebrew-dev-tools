---
name: git-workflow
description: Use when creating commits, managing branches, or preparing changes for merge. Do not use for non-version-control tasks.
---

# Workflow

- Follow semi-linear history:
  - rebase branch onto latest `master` or `main` before merging
  - merge using a merge commit (multi-parent), not fast-forward

# Commits

- Each commit must be atomic:
  - one logical change (feature, fix, improvement)
  - no mixed concerns
  - you must flag if changes are unlikely for a single logical change, and enforce it

- Each commit must be functional:
  - project builds successfully
  - deployable from technical perspective

# Commit messages

- Follow Conventional Commits:
  https://www.conventionalcommits.org/en/v1.0.0/

- Structure:
  - type(scope): short description

- Types:
  - feat
  - fix
  - refactor
  - test
  - chore

# Rules

- Prefer multiple small commits over one large commit
- Do not include unrelated changes
- Do not break build between commits