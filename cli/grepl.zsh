# shellcheck shell=zsh

function grepl() {
  local pattern="${1:?Specify what to grep.}"
  grep --color=always -E -- "$pattern"
}
