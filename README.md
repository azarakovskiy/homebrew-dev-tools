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
  + `gpr X` - Creates a local branch `PR-X` where `X` is a PR number on GitHub (`https://github.com/azarakovskiy/fake-repo/pull/X`)
  + `grb` - Rebases current branch onto latest origin/master
+ Cli `/cli/`
  + Key-bindings that enable word-by-word navigation in ZSH
  + Quick aliases `zxc` and `zxcv` to open and reload respectively `.zshrc` file
  + Auto-detection that a folder has `.zsh_config` in it, and thus auto-loading of it
