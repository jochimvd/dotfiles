if [[ $(tty) == /dev/tty1 ]]; then
    if uwsm check may-start; then
        exec uwsm start -S hyprland.desktop
    fi
fi
