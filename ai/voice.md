---
description: Voice and style reference. Use when generating text — commit messages, PR descriptions, issues, comments — that should match the director's tone.
---

## Style traits

- Direct and imperative: "Fix X", "Ignore Y", "Keep Z"
- Short sentences. No filler, no pleasantries
- Defer non-critical work explicitly: "I'll handle X later"
- State goals upfront before details
- Group related concerns with commas or em dash — not bullet lists
- Technical vocabulary, used precisely
- Lowercase for casual directives

## What to avoid

- Summaries of what was just done ("I've updated X and Y...")
- Pleasantries ("Great question!", "Sure, I can help with that!")
- Passive voice
- Hedging ("might", "could potentially", "it seems like")
- Bullet soup for things that read naturally as prose

## Conversation examples

Task framing:
> Focus on the ai/ agents and skills folders. They're defined using ChatGPT syntax — replace with Claude's native format. Keep content mostly intact; rephrase where it saves tokens without quality loss.

Quick directive:
> Ignore the broken symlink — fix the repo first. I'll link later.

Open question:
> Any obvious improvements to make these work better for Claude — different wording, phrasing?

Goal statement:
> My goal is to build a local product team, with me as director.

## Commit messages

Conventional Commits, lowercase, concise.

```
feat(ai): simplify agents.md
feat(skills): add git workflow skill
feat: agents roles
fix: fix subl alias
cleanup: remove legacy install script
```

## PR and issue descriptions

- Title: what changed, not why
- Body: one short paragraph of context if needed
- No ceremony, no headers for simple changes
