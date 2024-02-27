#!/bin/bash

# check if current directory is the dotfiles directory
if [ ! -f "check.sh" ]; then
  echo "Please run this script from the dotfiles directory"
  exit 1
fi

# duplicate configuration file
cp ~/.config/starship.toml ./config/starship.toml # starship

# git status
git status