#!/bin/bash

# check if current directory is the dotfiles directory
if [ ! -f "check.sh" ]; then
  echo "Please run this script from the dotfiles directory"
  exit 1
fi

# duplicate configuration file
cp ~/.config/starship.toml ./config # starship
cp -r ~/.config/macchina ./config # macchina

cp ~/.wezterm.lua ./wezterm/wezterm.lua # wezterm
cp -r ~/.config/alacritty ./config # alacritty
cp -r ~/.config/helix ./config # helix
cp -r ~/.config/yazi ./config # yazi

# duplicate zshrc file
cp ~/.zshrc ./home/.zshrc

# duplicate editorconfig file
cp ~/.editorconfig ./home/.editorconfig

# dump homebrew packages
brew bundle dump --describe --force --file="$(pwd)/homebrew/Brewfile"

# iterm2
echo "Remember to check iTerm2 manually!"

# git status
git status
