# dotfiles

A Hyprland desktop on Arch Linux, installed on top of a fresh archinstall.
`setup.sh` clones this repo to `~/.local/share/dotfiles` and runs `install.sh`.

## archinstall choices

The install scripts build on these, and don't set them up themselves:

- **Profile:** Minimal. The dotfiles install Hyprland, Ly and the desktop.
- **Audio:** PipeWire.
- **Network configuration:** Copy ISO network configuration. This gives
  systemd-networkd and systemd-resolved with DHCP on every wired, wireless and
  mobile interface.
