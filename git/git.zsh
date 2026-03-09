# shellcheck shell=zsh

__devtools_git_root="${funcsourcetrace[1]%/*}"
for __devtools_git_file in git_pr.zsh git_cleanup.zsh git_stash.zsh git_rebase_onto_latest.zsh git_branch.zsh git_squash.zsh git_commit.zsh git_log.zsh; do
  if [[ -r "$__devtools_git_root/$__devtools_git_file" ]]; then
    source "$__devtools_git_root/$__devtools_git_file"
  else
    echo "[devtools][warn] Missing file: $__devtools_git_root/$__devtools_git_file" >&2
  fi
done
unset __devtools_git_root __devtools_git_file
