#!/bin/zsh
echo "Dotfile install start..."
echo

git submodule init
git submodule update

stow zsh

echo
echo "Dotfile install finished..."
echo :P
