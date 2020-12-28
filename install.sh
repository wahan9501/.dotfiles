#!/bin/zsh
echo "Dotfile install start..."

git submodule init
git submodule update

stow zsh
stow config

echo "Dotfile install finished..."
echo :P
