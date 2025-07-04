#!/usr/bin/env bash

paru -S --noconfirm --needed kvantum-qt5 gnome-themes-extra

gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"