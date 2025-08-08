# Source external files
[[ -r ${ZDOTDIR:-$HOME}/.zaliases ]] && source ${ZDOTDIR:-$HOME}/.zaliases

# Check if running on MacOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Set PATH, MANPATH, etc., for Homebrew.
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi


# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"


# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit
_comp_options+=(globdots) # Include hidden files in completions

zinit cdreplay -q


# Vi mode
bindkey -v
bindkey -v '^?' backward-delete-char  # Make backspace work again in vi mode
export KEYTIMEOUT=1

# Function to change cursor style based on ZLE keymap
function zle-keymap-select () {
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    case $KEYMAP in
        vicmd)
            echo -ne $cursor_block
            ;;
        viins|main)
            echo -ne $cursor_beam
            ;;
        *)
            echo -ne $cursor_beam
            ;;
    esac
}

zle -N zle-keymap-select

# Set the cursor style for each new prompt
function precmd() {
    echo -ne '\e[6 q'
}


# Edit line in Vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line


# Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region


# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


# History
export HISTSIZE=100000
export SAVEHIST=20000
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
setopt hist_ignore_dups     # do not record an event that was just recorded again
setopt hist_ignore_all_dups # delete an old recorded event if a new event is a duplicate
setopt hist_ignore_space    # do not record an event starting with a space
setopt hist_save_no_dups    # do not write a duplicate event to the history file
setopt inc_append_history   # write to the history file immediately, not when the shell exits
setopt share_history        # share history between terminals
setopt extended_history     # save timestamp of command

# Load nvm
source /usr/share/nvm/init-nvm.sh

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(oh-my-posh init zsh --config ${XDG_CONFIG_HOME:-$HOME/.config}/ohmyposh/config.toml)"
eval "$(atuin init zsh)"