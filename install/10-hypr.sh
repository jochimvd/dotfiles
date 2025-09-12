#!/usr/bin/env bash

paru -S --noconfirm --needed \
    hyprland hyprpaper hypridle hyprlock hyprpicker hyprshot hyprpolkitagent hyprland-qtutils \
    xdg-desktop-portal-gtk xdg-desktop-portal-hyprland qt5-wayland qt6-wayland \
    walker libqalculate \
    waybar swaync \
    uwsm

systemctl --user enable --now waybar.service
systemctl --user enable --now swaync.service
systemctl --user enable --now hypridle.service
systemctl --user enable --now hyprpaper.service
systemctl --user enable --now hyprpolkitagent.service