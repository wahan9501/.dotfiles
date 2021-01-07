#!/bin/bash
echo "Dotfile install start..."

install_aur()
{
    package_name=$1
    package_url=$2
    if [ -z `which $package_name` ]
    then
        temp_dir=/tmp/$USER
        mkdir -p $temp_dir
        git clone $package_url $temp_dir/$package_name

        pushd $temp_dir/$package_name

        makepkg -si
        popd
    else
        echo "$package_name installed"
    fi
}

sudo pacman -Syu
sudo pacman -S zsh --noconfirm
sudo pacman -S stow --noconfirm
sudo pacman -S neovim --noconfirm
sudo pacman -S fzf --noconfirm
sudo pacman -S neofetch --noconfirm
sudo pacman -S pkgfile --noconfirm
sudo pkgfile -u

install_aur yay https://aur.archlinux.org/yay.git
yay -Syu --noconfirm
yay -S navi --noconfirm
yay -S antigen --noconfirm

git submodule init
git submodule update

stow zsh
stow config

sudo chsh -s $(which zsh)
echo "Dotfile install finished..."
echo :P

clear && exec zsh

