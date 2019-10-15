# Development tools

Used for ZSH on MacOS.

## Installation

- Pre-requisites

You need to have Homebrew installed on your system.

- Install a tap

`brew tap azarakovskiy/homebrew-dev-tools`

- Source it from main `.zshrc`

`source '/usr/local/Homebrew/Library/Taps/azarakovskiy/homebrew-dev-tools/all.zsh'` 

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
  + `grb` - Rebases current branch onto latest origin/master
  + `gsq` - Squashes last two commits of a current branch
  + `gbra X` - Creates a new branch or check out the existing with a name `X`
  + `gclean` - Cleans up current Git repository by removing all the local branches that are merged and their remotes, and reporting on remote branches that don't have a local reference or are not merged 

+ Cli `/cli/`
  + Key-bindings that enable word-by-word navigation in ZSH
  + Quick aliases `zxc` and `zxcv` to open and reload respectively `.zshrc` file
  + Auto-detection that a folder has `.zsh_config` in it, and thus auto-loading of it
