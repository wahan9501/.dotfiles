#!/bin/bash
echo "Dotfile install start..."

sudo apt update
sudo apt install zsh
sudo apt install stow
sudo apt install neovim

git submodule init
git submodule update

stow zsh
stow config

sudo chsh -s $(which zsh)
echo "Dotfile install finished..."
echo :P

exec zsh
