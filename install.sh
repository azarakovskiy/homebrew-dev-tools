#!/bin/sh

# This script install dev-tools from scratch.
# It is supposed to run on an empty MacOS machine.

set -e

# Install all the tools

## Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/alexey.zarakovskiy/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
echo "Done"

echo "Installing essential stuff with Homebrew..."
brew install --cast iterm2 bitwarden sublime-text
brew install zsh wget git gpg hammerspoon
echo "Done"

echo "Installing Oh My ZSH..."
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
echo "Done"

echo "Tapping dev-tools..."
brew tap azarakovskiy/homebrew-dev-tools
echo "\n" >> ~/.zshrc
echo "source /usr/local/Homebrew/Library/Taps/azarakovskiy/homebrew-dev-tools/all.zsh" >> ~/.zshrc
echo "\n" >> ~/.zshrc
echo "Done"

echo "Create directories and links..."
mkdir ~/dev
mkdir ~/dev/azarakovskiy
mkdir ~/dev/azarakovskiy/homebrew-dev-tools

cd /opt/homebrew/Library/Taps/azarakovskiy/homebrew-dev-tools
git remote add dev git@github.com:azarakovskiy/homebrew-dev-tools.git
cd ~

ln -s /opt/homebrew/Library/Taps/azarakovskiy/homebrew-dev-tools/ ~/dev/azarakovskiy/homebrew-dev-tools
ln -s /opt/homebrew/Library/Taps/azarakovskiy/homebrew-dev-tools/hammerspoon ~/.hammerspoon
echi "Done"

echo "Add ssh config..."
mkdir ~/.ssh
echo "Host *\n  AddKeysToAgent yes\n  UseKeychain yes\n  IdentityFile ~/.ssh/id_ed25519" > ~/.ssh/config
echo "Now the manual part..."
echo "Copy or generate ssh keys (id_ed25519) and put them under ~/.ssh"
read -s -k '?Press any key to continue.'
ssh-add -K ~/.ssh/id_ed25519
echo "Done"

echo "Please add GPG keys..."
read -s -k '?Press any key to continue.'

echo "Please copy Git config..."
read -s -k '?Press any key to continue.'

source ~/.zshrc
