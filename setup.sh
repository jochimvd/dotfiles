#!/usr/bin/env bash

echo "Installing dotfiles..."

sudo pacman -Sy --noconfirm --needed git

echo "Cloning repo..."
rm -rf ~/.local/share/dotfiles/
git clone https://github.com/jochimvd/dotfiles.git ~/.local/share/dotfiles >/dev/null

echo "Starting installation..."
source ~/.local/share/dotfiles/install.sh