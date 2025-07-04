#!/usr/bin/env bash

paru -S --noconfirm --needed base-devel cmake ninja curl

NVIM_SRC_DIR="$HOME/.local/share/src/neovim"
mkdir -p "$(dirname "$NVIM_SRC_DIR")"

if [ -d "$NVIM_SRC_DIR" ]; then
    read -p "Neovim source directory found. Recompile? (y/N) " -n 1 -r

    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Skipping Neovim compilation."
        exit 0
    fi
else
    git clone https://github.com/neovim/neovim "$NVIM_SRC_DIR"
fi

cd "$NVIM_SRC_DIR"
git fetch --prune --tags --force
git checkout stable
sudo make distclean
make CMAKE_BUILD_TYPE=Release
sudo make install
cd - > /dev/null