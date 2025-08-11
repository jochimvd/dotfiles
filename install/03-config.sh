#!/usr/bin/env bash

# Copy config
cp -R ~/.local/share/dotfiles/config/* ~/.config/
echo "source ~/.config/zsh/.zshenv" >~/.zshenv

systemctl --user enable --now keyboard-battery-monitor.timer

# Copy .desktop files
mkdir -p ~/.local/share/applications
cp ~/.local/share/dotfiles/share/applications/*.desktop ~/.local/share/applications/
cp ~/.local/share/dotfiles/share/applications/hidden/*.desktop ~/.local/share/applications/

update-desktop-database ~/.local/share/applications

# Prevent systemd-networkd-wait-online timeout on boot
sudo systemctl disable systemd-networkd-wait-online.service
sudo systemctl mask systemd-networkd-wait-online.service