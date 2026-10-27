#!/usr/bin/env bash

paru -S --noconfirm --needed mise rustup

# Tools from ~/.config/mise, including the dotfiles' conf.d/dotfiles.toml
mise install

rustup default stable
rustup component add rust-analyzer
