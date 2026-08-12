#!/usr/bin/env bash

paru -S --noconfirm --needed \
    iwd wireless-regdb \
    brightnessctl playerctl wireplumber power-profiles-daemon \
    pavucontrol impala bluetui udiskie \
    nautilus sushi papers gnome-calculator gnome-keyring seahorse \
    grim slurp wayfreeze-git satty wl-screenrec \
    gearlever \
    chromium zen-browser-bin \
    imv mpv tailscale syncthing

sudo systemctl enable --now iwd.service
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now power-profiles-daemon
sudo systemctl enable --now tailscaled.service
systemctl --user enable --now syncthing.service

sudo tailscale set --operator="$USER"
tailscale configure systray --enable-startup=systemd
systemctl --user daemon-reload
systemctl --user enable tailscale-systray.service
systemctl --user restart tailscale-systray.service


sudo localectl set-locale \
    LANG=en_US.UTF-8 \
    LC_TIME=en_GB.UTF-8 \
    LC_MEASUREMENT=en_GB.UTF-8 \
    LC_PAPER=en_GB.UTF-8

# Set wireless network regdom based on timezone
dotfiles_timezone=$(timedatectl show --property=Timezone --value)
dotfiles_wireless_regdom=$(
    awk -F '\t' -v timezone="$dotfiles_timezone" \
        '!/^#/ && $3 == timezone { print $1; exit }' \
        /usr/share/zoneinfo/zone.tab
)
dotfiles_wireless_regdom=${dotfiles_wireless_regdom:-00}
printf 'WIRELESS_REGDOM="%s"\n' "$dotfiles_wireless_regdom" | \
    sudo tee /etc/conf.d/wireless-regdom >/dev/null
