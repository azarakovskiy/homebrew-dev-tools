# shellcheck shell=zsh

function git_rebase_onto_latest() {
  local target="${1:?You need to provide a branch name to rebase current onto.}"
  local current_branch

  if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "Working tree is not clean."
    echo "Stash with: gstash push [NAME]"
    echo "Or commit with: gcommit"
    return 1
  fi

  current_branch="$(git branch --show-current 2>/dev/null || true)"
  if [[ -z "$current_branch" ]]; then
    echo "Unable to detect current branch."
    return 1
  fi

  if [[ "$current_branch" == "$target" ]]; then
    echo "Already on '$target'."
    return 1
  fi

  if ! git checkout "$target"; then
    echo "Cannot checkout target branch '$target'."
    return 1
  fi

  if ! git pull --rebase; then
    echo "Failed to pull latest changes for '$target'."
    git checkout "$current_branch" >/dev/null 2>&1 || true
    return 1
  fi

  if ! git checkout "$current_branch"; then
    echo "Failed to return to '$current_branch'."
    return 1
  fi

  git rebase -i "$target"
}

alias grebase=git_rebase_onto_latest
