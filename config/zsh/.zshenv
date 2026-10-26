# default apps
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="ghostty"
export BROWSER="dot-cmd-browser"

# default folders
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_SCREENSHOTS_DIR="$HOME/Pictures/Screenshots"

# adds ~/.local/bin, ~/.local/share/dotfiles/bin and ~/.local/share/go/bin to $PATH
# (GOPATH itself is set in ~/.config/go/env, which Go reads however it is started)
export PATH="$HOME/.local/bin:$HOME/.local/share/dotfiles/bin:$HOME/.local/share/go/bin:$PATH"

# cleaning up the home folder
export LESSHISTFILE="-"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export _ZL_DATA="$XDG_CACHE_HOME/zsh/.zlua"
