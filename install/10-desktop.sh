#!/usr/bin/env bash

paru -S --noconfirm --needed \
    brightnessctl playerctl wireplumber power-profiles-daemon \
    pavucontrol network-manager-applet blueman udiskie \
    nautilus gnome-calculator gnome-keyring seahorse \
    gearlever \
    zen-browser-bin

sudo systemctl enable --now NetworkManager.service
sudo systemctl enable --now bluetooth.service

# set locale
sudo localectl set-locale LANG=en_US.UTF-8
sudo localectl set-locale LC_TIME=en_GB.UTF-8