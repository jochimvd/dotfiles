# default apps
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="ghostty"

# default folders
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_SCREENSHOTS_DIR="$HOME/Pictures/Screenshots"

# adds ~/bin and ~/.local/bin to $PATH
export PATH="$PATH:$HOME/bin:$HOME/.local/bin"

# cleaning up the home folder
export LESSHISTFILE="-"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export _ZL_DATA="$XDG_CACHE_HOME/zsh/.zlua"
