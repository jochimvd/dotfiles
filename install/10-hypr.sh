#!/usr/bin/env bash

paru -S --noconfirm --needed \
    hyprland hyprpaper hypridle hyprlock hyprshutdown hyprpicker hyprpolkitagent hyprland-guiutils \
    xdg-desktop-portal-gtk xdg-desktop-portal-hyprland qt5-wayland qt6-wayland \
    gtk4 gtk4-layer-shell \
    uwsm

cargo install --locked --force --root "$HOME/.local" \
    --git ssh://git@github.com/jochimvd/varde.git varde

systemctl --user daemon-reload
systemctl --user enable --now varde.service
systemctl --user enable --now hypridle.service
systemctl --user enable --now hyprpaper.service
systemctl --user enable --now hyprpolkitagent.service
systemctl --user restart varde.service
