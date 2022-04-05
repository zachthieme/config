# Set Path
set -x PATH $HOME/.cabal/bin /snap/bin /usr/local/bin $PATH

# setup autojump for fish shell
begin
    set --local AUTOJUMP_PATH $HOME/.autojump/share/autojump/autojump.fish
    if test -e $AUTOJUMP_PATH
        source $AUTOJUMP_PATH
    end
end

# setup any fish plugins
fish_vi_key_bindings
set fish_greeting

# setup starship 
starship init fish | source

# ALIASES
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'