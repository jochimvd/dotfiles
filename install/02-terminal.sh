#!/usr/bin/env bash

paru -S --noconfirm --needed \
    ghostty tmux lazygit lazydocker \
    zsh eza zoxide atuin bat fzf jq fd \
    oh-my-posh-bin \
    man-db man-pages tlrc-bin \
    wget curl inetutils \
    cliphist btop \
    rate-mirrors

# change shell
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    chsh -s /usr/bin/zsh || { echo "Failed to change shell to zsh"; exit 1; }
fi