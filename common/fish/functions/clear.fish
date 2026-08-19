function clear --description 'Clear screen and tmux scrollback'
    command clear

    if set -q TMUX
        tmux clear-history -t "$TMUX_PANE"
    end
end
