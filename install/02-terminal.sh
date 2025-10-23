#!/usr/bin/env bash

paru -S --noconfirm --needed \
    ghostty tmux \
    zsh eza zoxide atuin bat fzf jq fd \
    oh-my-posh-bin \
    man-db man-pages tlrc-bin \
    wget curl inetutils \
    wl-clipboard cliphist btop \
    rate-mirrors

# change shell
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    chsh -s /usr/bin/zsh || { echo "Failed to change shell to zsh"; exit 1; }
fi