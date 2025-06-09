#!/usr/bin/env bash

# Install build dependencies
sudo pacman -S --needed base-devel cmake ninja curl || { echo "Failed to install build dependencies"; exit 1; }

# Install Neovim from source
mkdir -p ~/Repos

if [ ! -d ~/Repos/neovim ]; then
    git clone https://github.com/neovim/neovim ~/Repos/neovim || { echo "Failed to clone neovim"; exit 1; }
fi

cd ~/Repos/neovim
git fetch --prune --tags --force
git checkout stable
sudo make distclean
make CMAKE_BUILD_TYPE=Release
sudo make install
