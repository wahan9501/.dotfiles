#!/bin/zsh
echo "Dotfile clean start..."

stow -D zsh
stow -D tmux
stow -D config
stow -D local

echo "Dotfile clean finished..."
echo :P
