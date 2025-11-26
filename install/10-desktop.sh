#!/usr/bin/env bash

paru -S --noconfirm --needed \
    brightnessctl playerctl wireplumber power-profiles-daemon \
    pavucontrol network-manager-applet bluetui udiskie \
    nautilus papers gnome-calculator gnome-keyring seahorse \
    grim slurp wayfreeze-git satty wl-screenrec \
    gearlever \
    chromium zen-browser-bin

sudo systemctl enable --now NetworkManager.service
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now power-profiles-daemon

# set locale
sudo localectl set-locale LANG=en_US.UTF-8
sudo localectl set-locale LC_TIME=en_GB.UTF-8