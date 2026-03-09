# shellcheck shell=zsh

__devtools_root="${funcsourcetrace[1]%/*}"
for __devtools_file in git/git.zsh cli/all.zsh kube/kube.zsh; do
  if [[ -r "$__devtools_root/$__devtools_file" ]]; then
    source "$__devtools_root/$__devtools_file"
  else
    echo "[devtools][warn] Missing file: $__devtools_root/$__devtools_file" >&2
  fi
done
unset __devtools_root __devtools_file
