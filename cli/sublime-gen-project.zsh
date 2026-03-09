# shellcheck shell=zsh

function gen_sublime_project() {
  emulate -L zsh

  local folder_name="$PWD:t"
  local project_file="$folder_name.sublime-project"

  if ls ./*.sublime-project >/dev/null 2>&1; then
    echo "A .sublime-project file already exists in this directory."
  else
    cat > "$project_file" <<PROJECT
{
  "folders": [
    {
      "path": "$PWD",
      "folder_exclude_patterns": ["target", "dist", "node_modules", ".tmp", ".sublime", ".idea"]
    }
  ]
}
PROJECT
    echo "Created $project_file"
  fi

  if command -v subl >/dev/null 2>&1; then
    subl "$PWD"
  else
    echo "subl command is not available. Install Sublime CLI or set alias 'subl'."
  fi
}

alias sublify=gen_sublime_project
alias genSublime=gen_sublime_project
