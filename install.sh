#!/usr/bin/env bash

for f in ~/.local/share/dotfiles/install/*.sh; do source "$f"; done

echo "Please reboot to complete installation..."