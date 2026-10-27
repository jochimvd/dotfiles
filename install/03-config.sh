#!/usr/bin/env bash

# Copy config
mkdir -p ~/.config
cp -R ~/.local/share/dotfiles/config/* ~/.config/
echo "source ~/.config/zsh/.zshenv" >~/.zshenv

systemctl --user enable --now keyboard-battery-monitor.timer

# Copy .desktop files
mkdir -p ~/.local/share/applications
cp ~/.local/share/dotfiles/share/applications/*.desktop ~/.local/share/applications/
cp ~/.local/share/dotfiles/share/applications/hidden/*.desktop ~/.local/share/applications/

update-desktop-database ~/.local/share/applications

# Symlink resolved stub-resolv to /etc/resolv.conf
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# Public servers only when no network provides one
sudo mkdir -p /etc/systemd/resolved.conf.d
sudo tee /etc/systemd/resolved.conf.d/30-dns.conf >/dev/null <<'EOF'
[Resolve]
FallbackDNS=1.1.1.1 8.8.8.8
EOF

# Answer ARP only on the interface that holds the address, so a machine on
# Ethernet and Wi-Fi in the same subnet doesn't get its replies sent to the
# wrong interface
sudo tee /etc/sysctl.d/90-multihome-arp.conf >/dev/null <<'EOF'
net.ipv4.conf.all.arp_ignore = 1
net.ipv4.conf.all.arp_announce = 2
EOF
sudo sysctl --system >/dev/null

# Cap the space the journal and crash dumps can use
sudo mkdir -p /etc/systemd/journald.conf.d /etc/systemd/coredump.conf.d
printf '[Journal]\nSystemMaxUse=1G\n' | \
    sudo tee /etc/systemd/journald.conf.d/dotfiles.conf >/dev/null
printf '[Coredump]\nMaxUse=1G\n' | \
    sudo tee /etc/systemd/coredump.conf.d/dotfiles.conf >/dev/null
sudo systemctl restart systemd-journald

sudo systemctl enable --now systemd-networkd
sudo systemctl enable --now systemd-resolved
sudo systemctl reload-or-restart systemd-resolved

# Prevent systemd-networkd-wait-online timeout on boot
sudo systemctl disable systemd-networkd-wait-online.service
sudo systemctl mask systemd-networkd-wait-online.service