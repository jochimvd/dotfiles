#!/usr/bin/env bash

# Color output and parallel downloads
grep -q '^Color' /etc/pacman.conf || sudo sed -i '/^\[options\]/a Color' /etc/pacman.conf
sudo sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

# Build AUR packages on all cores, without separate debug packages
sudo mkdir -p /etc/makepkg.conf.d
sudo tee /etc/makepkg.conf.d/dotfiles.conf >/dev/null <<'EOF'
MAKEFLAGS="-j$(nproc)"
OPTIONS=(strip docs !libtool !staticlibs emptydirs zipman purge !debug lto)
EOF

sudo pacman -S --needed --noconfirm base-devel

if ! command -v paru &> /dev/null; then
    git clone https://aur.archlinux.org/paru.git /tmp/paru || { echo "Failed to clone paru"; exit 1; }
    cd /tmp/paru
    makepkg -si
    cd - > /dev/null
    rm -rf /tmp/paru
fi

# Remove packages that were only needed to build an AUR package
sudo sed -i 's/^#RemoveMake/RemoveMake/' /etc/paru.conf