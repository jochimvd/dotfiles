#!/usr/bin/env bash

paru -S --noconfirm --needed base-devel cmake ninja curl

# Install Neovim from source
mkdir -p ~/.local/share/src

if [ ! -d ~/.local/share/src/neovim ]; then
    git clone https://github.com/neovim/neovim ~/.local/share/src/neovim
fi

cd ~/.local/share/src/neovim
git fetch --prune --tags --force
git checkout stable
sudo make distclean
make CMAKE_BUILD_TYPE=Release
sudo make install
cd -