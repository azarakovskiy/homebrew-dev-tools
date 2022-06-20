# use tool version
function useFn() {
    declare -A _roots=(
      ["go 1.13"]="/usr/local/Cellar/go@1.13/1.13.15/libexec"
      ["go 1.14"]="/usr/local/Cellar/go@1.14/1.14.15/libexec"
        ["go 1.15"]="/usr/local/Cellar/go@1.15/1.15.9/libexec"
        ["go 1.16"]="/usr/local/Cellar/go@1.16/1.16.9/libexec"
        ["go 1.17"]="/usr/local/Cellar/go@1.17/1.17.9/libexec"
      ["go 1.18"]="/usr/local/Cellar/go/1.18/libexec"
        ["go latest"]="/usr/local/Cellar/go/1.18/libexec"
    )
    declare -A _versions=(
        ["go 1.13"]="/usr/local/Cellar/go@1.13/1.13.15"
        ["go 1.14"]="/usr/local/Cellar/go@1.14/1.14.15"
        ["go 1.15"]="/usr/local/Cellar/go@1.15/1.15.9"
        ["go 1.16"]="/usr/local/Cellar/go@1.16/1.16.9"
        ["go 1.17"]="/usr/local/Cellar/go@1.17/1.17.9"
        ["go 1.18"]="/usr/local/Cellar/go/1.18"
        ["go latest"]="/usr/local/Cellar/go/1.18"
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

function _setGoVersion() {
    readonly version=$1
    readonly goroot=$2
    echo $version
    ln -sf "$version/bin/go" /usr/local/bin/go
    ln -sf "$version/bin/godoc" /usr/local/bin/godoc
    ln -sf "$version/bin/gofmt" /usr/local/bin/gofmt
    export GOROOT=$goroot
}

alias use=useFn