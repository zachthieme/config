begin
    set --local AUTOJUMP_PATH $HOME/.autojump/share/autojump/autojump.fish
    if test -e $AUTOJUMP_PATH
        source $AUTOJUMP_PATH
    end
end
starship init fish | source
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
