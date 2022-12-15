# Development tools

Used for ZSH on MacOS.

## Installation

- Pre-requisites

You need to have Homebrew installed on your system.

- Install a tap

`brew tap azarakovskiy/homebrew-dev-tools`

- Source it from main `.zshrc`

`source '/usr/local/Homebrew/Library/Taps/azarakovskiy/homebrew-dev-tools/all.zsh'` 

Note: on M1 Mac brew installs everything to `/opt/homebrew/Library/Taps/azarakovskiy`

If you only need a part of it, you can reference it using the relative paths from this repository. 
E.g.: 

`source '/usr/local/Homebrew/Library/Taps/azarakovskiy/homebrew-dev-tools/git/all.zsh`

## Structure

Each folder represents part of tools for a specific thing. (e.g. `/git/` is obviously for Git stuff.)

Each folder has a `all.zsh` file to import everything from it, an each command might be imported individually too.

## Contains

+ Git `/git/`
  + `.gitignore` - Default Git ignore file that you put under your `~` folder to apply to the whole system.
  + `.gitconfig` - Default Git config file that you put under your `~` folder. Review it before using and edit the placeholders.
  + `.gitmessage` - Default Git commit message template file that you put under your `~` folder. Now when you use `git commit` command without `-m` this template will be opened for editing.

  + `gpr X` - Creates a local branch `PR-X` where `X` is a PR number on GitHub (`https://github.com/azarakovskiy/fake-repo/pull/X`)
  + `gstash pop|push [X]` - (un)Stashes local changes with a given optional name `X`.
  + `grebase X` - Rebases current branch onto latest `origin/X`. An `X` must have an upstream branch.
  + `gsquash` - Squashes last two commits of a current branch
  + `gloggy release` - Generates release message from `git log`. Assumes all the features are merged on GitHub with `#num` hashtag.
  + `gbranch X` - Creates a new branch or check out the existing with a name `X`
  + `gclean X` - [this one might be **ruthless**] Cleans up current Git repository by removing all the local branches that are merged and their remotes, and reporting on remote branches that don't have a local reference or are not merged. `X` is a branch that you consider to be a base branch (develop or master). Basically, it removes branched that are merged into your specified base branch. Never removes `develop` or `master`.

+ Docker tools  
  + `dockstop` - Stops all running docker containers
  
+ Cli `/cli/`
  + Key-bindings that enable word-by-word navigation in ZSH
  + Quick aliases `zxc` and `zxcv` to open and reload respectively `.zshrc` file
  + Auto-detection that a folder has `.zsh_config` in it, and thus auto-loading of it
