# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# Load Homebrew environment
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Initialize Oh My Posh with your theme config
eval "$(oh-my-posh init bash --config ~/.themes/z6.omp.json)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Created by `pipx` on 2025-05-27 06:58:40
export PATH="$PATH:/home/z6/.local/bin"
export PATH="$HOME/go/bin:$PATH"

if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
   . ~/.nix-profile/etc/profile.d/nix.sh
fi
export XDG_RUNTIME_DIR=/run/user/$(id -u)
. "$HOME/.cargo/env"
# Cursor settings
