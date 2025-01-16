#!/bin/zsh

function git_cleanup() {
  # Prompt for branch to compare against
  read "base_branch?Enter the base branch to compare against (master/main): "

  # Validate base branch input
  if [[ "$base_branch" != "master" && "$base_branch" != "main" ]]; then
    echo "Invalid branch. Please enter 'master' or 'main'."
    return 1
  fi

  # Prompt for text to search in branch names
  read "search_text?Enter text to search for in branch names (leave empty for any): "

  # Find branches that are merged into the specified base branch and match the search text
  merged_branches=$(git branch --merged "$base_branch" | grep -v '^\*' | grep "$search_text")

  if [[ -z "$merged_branches" ]]; then
    echo "No branches found that are merged into '$base_branch' and match '$search_text'."
    return 0
  fi

  # Iterate through the branches and prompt for deletion
  for branch in $merged_branches; do
    read "delete_branch?Do you want to delete the branch '$branch'? (y/n): "
    if [[ "$delete_branch" == "y" ]]; then
      git branch -d "$branch" || echo "Failed to delete branch '$branch'."

      # Prompt to remove the origin branch
      read "delete_remote?Do you want to delete the remote branch 'origin/$branch'? (y/n): "
      if [[ "$delete_remote" == "y" ]]; then
        git push origin --delete "$branch" || echo "Failed to delete remote branch 'origin/$branch'."
      fi
    fi
  done

  # List all remaining branches
  echo "Remaining branches:"
  echo "Merged branches:"
  git branch --merged "$base_branch" | grep -v '^\*'

  echo "Not merged branches:"
  git branch --no-merged "$base_branch" | grep -v '^\*'
}

# Set up an alias
alias git_cleanup="git_cleanup"
