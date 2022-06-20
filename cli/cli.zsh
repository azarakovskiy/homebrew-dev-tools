# Bind for a console word-by-word navigation
bindkey "^[[1;9D" backward-word
bindkey "^[[1;9C" forward-word

# Mouse speed
defaults write -g com.apple.mouse.scaling 9.0

# Quick access aliases to .zshrc
alias zxc='subl ~/.zshrc'
alias zxcv='source ~/.zshrc'

# If current folder has .zsh_config, load it
function chpwd() {
  if [ -r $PWD/.zsh_config ]; then
  	echo "Loaded .zsh_config from $PWD"
    source $PWD/.zsh_config
  else
    source $HOME/.zshrc
  fi
}
