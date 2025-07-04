#!/usr/bin/env bash

paru -S --noconfirm --needed \
    hyprland hyprpaper hypridle hyprlock hyprpicker hyprshot hyprpolkitagent hyprland-qtutils \
    xdg-desktop-portal-gtk xdg-desktop-portal-hyprland qt5-wayland qt6-wayland \
    rofi-wayland waybar swaync \
    uwsm

systemctl --user enable --now hyprpolkitagent.service