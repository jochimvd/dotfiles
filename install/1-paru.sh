#!/usr/bin/env bash

if ! command -v paru &> /dev/null; then
    sudo pacman -S --needed --noconfirm base-devel
    git clone https://aur.archlinux.org/paru.git /tmp/paru || { echo "Failed to clone paru"; exit 1; }
    cd /tmp/paru
    makepkg -si
    cd -
    rm -rf /tmp/paru
fi