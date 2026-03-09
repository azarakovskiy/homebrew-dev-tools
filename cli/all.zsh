# shellcheck shell=zsh

__devtools_cli_root="${funcsourcetrace[1]%/*}"
for __devtools_cli_file in cli.zsh docker.zsh grepl.zsh sublime-gen-project.zsh use.zsh; do
  if [[ -r "$__devtools_cli_root/$__devtools_cli_file" ]]; then
    source "$__devtools_cli_root/$__devtools_cli_file"
  else
    echo "[devtools][warn] Missing file: $__devtools_cli_root/$__devtools_cli_file" >&2
  fi
done
unset __devtools_cli_root __devtools_cli_file
