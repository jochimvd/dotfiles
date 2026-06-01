#!/usr/bin/env bash

paru -S --noconfirm --needed \
    brightnessctl playerctl wireplumber power-profiles-daemon \
    pavucontrol iwd impala bluetui udiskie \
    nautilus papers gnome-calculator gnome-keyring seahorse \
    grim slurp wayfreeze-git satty wl-screenrec \
    gearlever \
    chromium zen-browser-bin

sudo systemctl enable --now iwd.service
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now power-profiles-daemon

sudo localectl set-locale \
    LANG=en_US.UTF-8 \
    LC_TIME=en_GB.UTF-8 \
    LC_MEASUREMENT=en_GB.UTF-8 \
    LC_PAPER=en_GB.UTF-8