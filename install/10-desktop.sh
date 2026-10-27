#!/usr/bin/env bash

paru -S --noconfirm --needed \
    kernel-modules-hook \
    iwd wireless-regdb \
    brightnessctl playerctl wireplumber power-profiles-daemon \
    pavucontrol impala bluez bluez-utils bluetui udiskie \
    nautilus gvfs-smb webp-pixbuf-loader sushi papers gnome-calculator gnome-keyring seahorse \
    grim slurp satty wl-screenrec \
    gearlever \
    chromium zen-browser-bin \
    imv mpv tailscale syncthing

# Change the login keyring's password when using passwd
if ! grep -q 'pam_gnome_keyring' /etc/pam.d/passwd; then
    printf 'password\toptional\tpam_gnome_keyring.so\n' | \
        sudo tee -a /etc/pam.d/passwd >/dev/null
fi

sudo systemctl enable linux-modules-cleanup.service
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

# Generate the locales set below
sudo sed -i -E 's/^#(en_(US|GB)\.UTF-8 UTF-8)/\1/' /etc/locale.gen
sudo locale-gen >/dev/null

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
