#!/usr/bin/env bash

DPATH=$(dirname "$(realpath "$0")")

install_paru() {
    if ! command -v paru &> /dev/null; then
        sudo pacman -S --needed base-devel
        git clone https://aur.archlinux.org/paru.git /tmp/paru || { echo "Failed to clone paru"; exit 1; }
        cd /tmp/paru
        makepkg -si
        cd -
        rm -rf /tmp/paru
    fi
}

install_deps() {
    # Official packages
    paru -Syu --needed \
        wezterm-git neovim tmux fzf \
        zsh eza zoxide atuin bat jq \
        ttf-jetbrains-mono-nerd noto-fonts-emoji \
        hyprland hyprpaper hypridle hyprlock hyprpicker waybar swaync \
        xdg-desktop-portal-hyprland qt5-wayland qt6-wayland \
        nautilus gnome-keyring seahorse \
        network-manager-applet blueman udiskie \
        grim slurp satty \
        cliphist \
        btop || { echo "Failed to install official packages"; exit 1; }

    # AUR packages
    paru -Syu --needed \
        tofi oh-my-posh-bin \
        uwsm hyprpolkitagent \
        zen-browser-avx2-bin || { echo "Failed to install AUR packages"; exit 1; }
}

create_dirs() {
    mkdir -p ~/.local/bin
    ln -sf $DPATH/.local/bin/* ~/.local/bin/

    mkdir -p ~/.local/share
    ln -sf $DPATH/.local/share/* ~/.local/share/
}

create_links() {
    CONFIG_DIRS=("hypr" "ohmyposh" "swaync" "tmux" "tofi" "uwsm" "waybar" "wezterm" "zsh")

    for dir in "${CONFIG_DIRS[@]}"; do
        rm -rf ~/.config/$dir
        ln -s $DPATH/.config/$dir ~/.config/$dir
    done

    rm -f ~/.zshenv
    ln -s $DPATH/.zshenv ~/.zshenv
}

enable_services() {
    sudo systemctl enable --now NetworkManager
    sudo systemctl enable --now bluetooth
}

set_locale() {
    sudo localectl set-locale LANG=en_US.UTF-8
    sudo localectl set-locale LC_TIME=en_GB.UTF-8
}

change_shell() {
    if [ "$SHELL" != "/usr/bin/zsh" ]; then
        chsh -s /usr/bin/zsh || { echo "Failed to change shell to zsh"; exit 1; }
    fi
}

main() {
    install_paru
    install_deps
    create_dirs
    create_links
    enable_services
    set_locale
    change_shell
}

main "$@"