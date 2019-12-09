function git_log_release_notes() {
    git log $(git describe --tags --abbrev=0)..HEAD -i -E --grep="^.*#[0-9]+.*$" --pretty=format:"* %b%n"
}

function _gloggy() {
    readonly what=${1:?"You must specify an action. Curently supported: gloggy release"}

    if [[ $what == "release" ]]; then
        git_log_release_notes
    else
        echo "Curently supported: gloggy release"
    fi
}

alias gloggy=_gloggy
