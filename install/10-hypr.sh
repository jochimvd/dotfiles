#!/usr/bin/env bash

paru -S --noconfirm --needed \
    hyprland hyprpaper hypridle hyprlock hyprshutdown hyprpicker hyprpolkitagent hyprland-guiutils \
    xdg-desktop-portal-gtk xdg-desktop-portal-hyprland qt5-wayland qt6-wayland \
    walker elephant elephant-providerlist elephant-desktopapplications elephant-calc elephant-clipboard elephant-unicode elephant-symbols \
    waybar mako \
    uwsm

# Migrate away from swaync if it was previously enabled
systemctl --user disable --now swaync.service 2>/dev/null || true

systemctl --user enable --now waybar.service
systemctl --user enable --now mako.service
systemctl --user enable --now hypridle.service
systemctl --user enable --now hyprpaper.service
systemctl --user enable --now hyprpolkitagent.service

if ! systemctl --user is-enabled --quiet elephant.service; then
    elephant service enable
fi