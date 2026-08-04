status is-interactive; or return
command -sq fzf; or return

set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --strip-cwd-prefix --exclude .git --follow'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_DEFAULT_OPTS '--height=60% --layout=reverse --border=rounded --prompt="  " --pointer="  " --preview-window=right:65%:wrap:border-left'
set -gx _FZF_PREVIEW_CMD 'bat --color=always --style=plain,numbers --line-range=:500 {}'
set -gx FZF_CTRL_T_OPTS "--preview '$_FZF_PREVIEW_CMD'"

fzf --fish | source

function __fzf_file_no_hidden
    set -lx FZF_CTRL_T_COMMAND 'fd --type f --strip-cwd-prefix --exclude .git --follow'
    fzf-file-widget
end

function fish_user_key_bindings
    fzf_key_bindings
    bind \cf __fzf_file_no_hidden
    bind -M insert \cf __fzf_file_no_hidden
end
