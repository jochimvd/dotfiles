#!/usr/bin/env bash

for f in $(find ~/.local/share/dotfiles/install/ -maxdepth 1 -name "*.sh" | sort -V); do source "$f"; done

echo "Please reboot to complete installation..."