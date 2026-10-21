#!/usr/bin/env bash

paru -S --noconfirm --needed sunshine-bin

# Allow KMS capture (needs to be reapplied after sunshine-bin updates)
sudo setcap cap_sys_admin+p "$(readlink -f /usr/bin/sunshine)"

# Allow Moonlight clients over Tailscale only
sudo ufw allow in on tailscale0 to any port 47984,47989,47990,48010 proto tcp comment 'sunshine'
sudo ufw allow in on tailscale0 to any port 47998:48000 proto udp comment 'sunshine'

systemctl --user enable --now app-dev.lizardbyte.app.Sunshine.service
