# Bind for a console word-by-word navigation
bindkey "^[[1;9D" backward-word
bindkey "^[[1;9C" forward-word

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
  	echo "Loaded .zsh_config from $PWD"
    source $PWD/.zsh_config
  else
    source $HOME/.zshrc
  fi
}

# grep without truncating
function grepl_impl() {
	readonly what=${1:?"Specify what to grep please"}
	readonly regexp=".*$what.*|\$"
	grep -E $regexp
}
alias grepl=grepl_impl

# use tool version
func use() {
    declare -A _roots=(
        ["go 1.13"]="/usr/local/Cellar/go@1.13/1.13.15/libexec"
        ["go 1.14"]="/usr/local/Cellar/go@1.14/1.14.15/libexec" 
	["go 1.15"]="/usr/local/Cellar/go@1.15/1.15.9/libexec" 
	["go 1.16"]="/usr/local/Cellar/go/1.16/libexec" 
	["go latest"]="/usr/local/Cellar/go/1.16/libexec" 
    )
    declare -A _versions=(
        ["go 1.13"]="/usr/local/Cellar/go@1.13/1.13.15"
        ["go 1.14"]="/usr/local/Cellar/go@1.14/1.14.15" 
	["go 1.15"]="/usr/local/Cellar/go@1.15/1.15.9" 
	["go 1.16"]="/usr/local/Cellar/go/1.16/libexec" 
	["go latest"]="/usr/local/Cellar/go/1.16/libexec" 
    )
    declare -A _tools=(
        ["go"]=_setGoVersion 
    )

    readonly name=${1:?"Specify what you want to use"}
    readonly version=${2:?"Specify what version of it you want to use"}

    p1="$name"
    p2="$name $version"
    
    fn=$_tools[$p1]
    v=$_versions[$p2]
    r=$_versions[$p2]
    
    "$fn" "$v" "$r"
}

func _setGoVersion() {
    readonly version=$1
    readonly goroot=$2
    echo $version
    ln -sf "$version/bin/go" /usr/local/bin/go 
    ln -sf "$version/bin/godoc" /usr/local/bin/godoc 
    ln -sf "$version/bin/gofmt" /usr/local/bin/gofmt
    export GOROOT=$goroot
}

# tha cmd to copy zipped THA to a specific folder
function tha() {
    readonly folder=${1:?"Folder name (e.g. alexey_zarakovskiy)"}
    readonly zip=${2:?"Archive name (e.g. beat_tha.zip)"}
    mkdir ~/Projects/Beat/Interviews/THA/$folder && \
    mv ~/Downloads/$zip ~/Projects/Beat/Interviews/THA/$folder && \
    unar -o ~/Projects/Beat/Interviews/THA/$folder  ~/Projects/Beat/Interviews/THA/$folder/$zip && \
    touch  ~/Projects/Beat/Interviews/THA/$folder.tha
    echo "Done. Here: ~/Projects/Beat/Interviews/THA/$folder"
}
