#!/bin/zsh
echo "Dotfile clean start..."

stow -D zsh
stow -D config

echo "Dotfile clean finished..."
echo :P
