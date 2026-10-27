#!/usr/bin/env bash

paru -S --noconfirm --needed \
    ghostty tmux \
    zsh eza zoxide atuin bat fzf jq fd \
    oh-my-posh-bin \
    man-db man-pages \
    wget curl inetutils \
    wl-clipboard cliphist btop \
    rate-mirrors \
    unzip zip 7zip rsync openssh ripgrep lsof usbutils openbsd-netcat whois \
    pacman-contrib

# Trim the pacman package cache weekly
sudo systemctl enable paccache.timer

# change shell
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    chsh -s /usr/bin/zsh || { echo "Failed to change shell to zsh"; exit 1; }
fi