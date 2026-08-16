status is-interactive; or return
# Commands to run in interactive sessions can go here
set fish_greeting
fish_vi_key_bindings
fish_config theme choose everforest
# prompt
type -q starship; and starship init fish | source
type -q tirith; and tirith init --shell fish | source
type -q zoxide; and zoxide init --cmd cd fish | source
