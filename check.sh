#!/bin/bash

# check if current directory is the dotfiles directory
if [ ! -f "check.sh" ]; then
  echo "Please run this script from the dotfiles directory"
  exit 1
fi

# duplicate configuration file
cp ~/.config/starship.toml ./config/starship.toml # starship

# duplicate zshrc file
cp ~/.zshrc ./home/.zshrc

# dump homebrew packages
brew bundle dump --describe --force --file="$(pwd)/homebrew/Brewfile"

# iterm2
echo "Remember to check iTerm2 manually!"

# git status
git status