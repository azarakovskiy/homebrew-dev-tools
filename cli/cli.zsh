# List of plugins
plugins=(
 git
)

# Bind for a console word-by-word navigation
bindkey "^[b" backward-word
bindkey "^[f" forward-word

# Quick access aliases to .zshrc
alias zxc='sublime ~/.zshrc'
alias zxcv='source ~/.zshrc'

# If current folder has .zsh_config, load it
function chpwd() {
  if [ -r $PWD/.zsh_config ]; then
    source $PWD/.zsh_config
  else
    source $HOME/.zshrc
  fi
}
