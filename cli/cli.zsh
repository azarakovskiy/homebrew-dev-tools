# Bind for a console word-by-word navigation
bindkey "^[b" backward-word
bindkey "^[f" forward-word

# Mouse speed
defaults write -g com.apple.mouse.scaling 9.0

# Sublime
SUBL_BIN="/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
SUBLIME=/usr/local/bin/sublime
SUBL=/usr/local/bin/subl
if [ -f $SUBL_BIN ]; then
	if [ ! -L $SUBLIME ]; then
		ln -sv $SUBL_BIN $SUBLIME
	fi
	if [ ! -L $SUBL ]; then
		ln -sv $SUBL_BIN $SUBL
	fi
else
	echo "## Please install Sublime editor. It's good."
fi


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
