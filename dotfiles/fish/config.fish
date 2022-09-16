set -x STARSHIP_CONFIG $HOME/.config/starship.toml
set -x EDITOR nvim

fish_add_path ~/.cargo/bin
fish_add_path ~/snap/bin

set -g fish_term24bit 1
set -g theme_nerd_fonts yes

# setup any fish plugins
fish_vi_key_bindings
set fish_greeting

# setup starship 
starship init fish | source

# setup zoxide
zoxide init fish | source

# ALIASES
alias exa='exa --group-directories-first'
alias l='exa'
alias la='exa -la'
alias a='exa -a'
alias ssh='kitty +kitten ssh'
alias j='z'