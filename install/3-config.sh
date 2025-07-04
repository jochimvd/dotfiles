#!/usr/bin/env bash

cp -R ~/.local/share/dotfiles/config/* ~/.config/
echo "source ~/.config/zsh/.zshenv" >~/.zshenv