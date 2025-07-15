#!/usr/bin/env bash

sudo pacman -S --needed --noconfirm base-devel

if ! command -v paru &> /dev/null; then
    git clone https://aur.archlinux.org/paru.git /tmp/paru || { echo "Failed to clone paru"; exit 1; }
    cd /tmp/paru
    makepkg -si
    cd - > /dev/null
    rm -rf /tmp/paru

    # add color to pacman
    sudo sed -i '/^\[options\]/a Color' /etc/pacman.conf
fi