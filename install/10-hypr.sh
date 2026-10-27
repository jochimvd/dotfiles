#!/usr/bin/env bash

paru -S --noconfirm --needed \
    hyprland hyprpaper hypridle hyprlock hyprshutdown hyprpicker hyprpolkitagent hyprland-guiutils \
    xdg-desktop-portal-gtk xdg-desktop-portal-hyprland qt5-wayland qt6-wayland \
    gtk4 gtk4-layer-shell \
    uwsm ly

# Ly's packaged PAM config also unlocks GNOME Keyring at login
sudo systemctl enable ly@tty2.service

cargo install --locked --force --root "$HOME/.local" \
    --git https://github.com/jochimvd/varde.git varde

systemctl --user daemon-reload
# These need a Hyprland session, so they start at the next login. Restart varde
# only if a session is already running it, to pick up the new build
systemctl --user enable varde.service hypridle.service hyprpaper.service hyprpolkitagent.service
systemctl --user try-restart varde.service
