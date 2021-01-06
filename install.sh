#!/bin/bash
echo "Dotfile install start..."

sudo pacman -Syu  zsh stow neovim --noconfirm

git submodule init
git submodule update

stow zsh
stow config

sudo chsh -s $(which zsh)
echo "Dotfile install finished..."
echo :P

exec zsh
