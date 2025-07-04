#!/usr/bin/env bash

paru -S --noconfirm --needed \
    signal-desktop spotify-launcher \
    obsidian libreoffice-still obs-studio \
    1password 1password-cli \
    satty pinta

# enable services
sudo systemctl enable --now NetworkManager.service
sudo systemctl enable --now bluetooth.service
systemctl --user enable --now hyprpolkitagent.service


# set locale
sudo localectl set-locale LANG=en_US.UTF-8
sudo localectl set-locale LC_TIME=en_GB.UTF-8

# change shell
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    chsh -s /usr/bin/zsh || { echo "Failed to change shell to zsh"; exit 1; }
fi