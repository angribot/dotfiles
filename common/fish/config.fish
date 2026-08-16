status is-interactive; or return
# Commands to run in interactive sessions can go here
set fish_greeting
fish_vi_key_bindings
fish_config theme choose everforest
# prompt
starship init fish | source
tirith init --shell fish | source
zoxide init --cmd cd fish | source
