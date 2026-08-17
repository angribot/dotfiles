set -gx COLORTERM truecolor
set -gx GPG_TTY (tty)
set -gx LANG "C.UTF-8"
set -gx LESS "-R --use-color --ignore-case --jump-target=4 --LONG-PROMPT --no-init --quit-if-one-screen"
set -gx MANPAGER "bat -l man -p"
set -gx PAGER bat
set -gx EDITOR vim
set -gx VISUAL vim
set -gx SUDO_EDITOR vim
# XDG
set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME "$HOME/.config"
set -q XDG_CACHE_HOME; or set -gx XDG_CACHE_HOME "$HOME/.cache"
set -q XDG_STATE_HOME; or set -gx XDG_STATE_HOME "$HOME/.local/state"
set -q XDG_DATA_HOME; or set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx WGETRC "$XDG_CONFIG_HOME/wget/wgetrc"
# Homebrew
set -gx HOMEBREW_NO_ENV_HINTS 1
