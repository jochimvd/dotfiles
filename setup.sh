#!/usr/bin/env bash

DPATH=$(dirname "$(realpath "$0")")

install_deps() {
    # Official packages
    paru -Syu --needed \
        neovim tmux fzf \
        zsh eza zoxide atuin bat \
        ttf-jetbrains-mono-nerd noto-fonts-emoji \
        hyprpaper hypridle hyprlock hyprpicker waybar swaync \
        nautilus gnome-keyring seahorse \
        network-manager-applet blueman udiskie \
        cliphist \
        btop || { echo "Failed to install official packages"; exit 1; }

    # AUR packages
    paru -Syu --needed \
        tofi oh-my-posh-bin \
        uwsm hyprpolkitagent-git \
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
    install_deps
    create_dirs
    create_links
    enable_services
    set_locale
    change_shell
}

main "$@"