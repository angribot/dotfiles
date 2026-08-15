set -x COLORTERM truecolor
set -x GPG_TTY (tty)
set -x LANG "C.UTF-8"
set -x LESS "-R --use-color --ignore-case --jump-target=4 --LONG-PROMPT --no-init --quit-if-one-screen"
set -x PAGER bat
# set -x XDG_CONFIG_HOME "$HOME/.config"
set -x EDITOR vim
set -x VISUAL vim
set -x SUDO_EDITOR vim
# npm follows XDG
set -x NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/config"
set -x NPM_CONFIG_CACHE "$XDG_CACHE_HOME/npm"
set -x NPM_CONFIG_TMP "$XDG_RUNTIME_DIR/npm"
