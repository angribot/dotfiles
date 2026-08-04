if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    fish_config theme choose everforest
    fish_vi_key_bindings
    starship init fish | source
    zoxide init fish --cmd cd| source
end
