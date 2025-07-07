#!/usr/bin/env bash

set -e

for f in ~/.local/share/dotfiles/install/*.sh; do
    source "$f"
done

echo "Please reboot to complete installation..."