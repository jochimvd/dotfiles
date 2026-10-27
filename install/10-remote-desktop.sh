#!/usr/bin/env bash

# Allow KMS capture, and reapply it whenever sunshine-bin is installed or
# upgraded because a new binary loses the capability
sudo mkdir -p /etc/pacman.d/hooks
sudo tee /etc/pacman.d/hooks/sunshine-setcap.hook >/dev/null <<'EOF'
[Trigger]
Operation = Install
Operation = Upgrade
Type = Package
Target = sunshine-bin

[Action]
Description = Allowing Sunshine KMS capture...
When = PostTransaction
Exec = /usr/bin/sh -c 'setcap cap_sys_admin+p "$(readlink -f /usr/bin/sunshine)"'
EOF

paru -S --noconfirm --needed sunshine-bin

# Allow Moonlight clients over Tailscale only
sudo ufw allow in on tailscale0 to any port 47984,47989,47990,48010 proto tcp comment 'sunshine'
sudo ufw allow in on tailscale0 to any port 47998:48000 proto udp comment 'sunshine'

systemctl --user enable --now app-dev.lizardbyte.app.Sunshine.service
