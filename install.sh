#!/bin/bash
echo "Dotfile install start..."

install_navi()
{
    if [ -z `which navi` ]
    then
        temp_dir=/tmp/$USER
        mkdir -p $temp_dir
        git clone https://aur.archlinux.org/navi.git $temp_dir/navi

        pushd $temp_dir/navi
        makepkg -si
        popd
    else
        echo "navi installed"
    fi
}

sudo pacman -Syu  zsh --noconfirm
sudo pacman -Syu  stow --noconfirm
sudo pacman -Syu  neovim --noconfirm
sudo pacman -Syu  fzf --noconfirm
sudo pacman -Syu  neofetch --noconfirm
install_navi

git submodule init
git submodule update

stow zsh
stow config

sudo chsh -s $(which zsh)
echo "Dotfile install finished..."
echo :P

clear && exec zsh

