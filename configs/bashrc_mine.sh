# NOTE: PS1 is set directly in .bashrc

# Use vi mode in bash
# set -o vi

alias python=python3

# Preserve history
# https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it


# Default vim to nvim
alias vim=nvim

#
# Tmux stuff
#
# Run tmux with correct colors
alias tmux="env TERM=xterm-256color tmux -2"

# Create a new tmux session with the given name and restore it
function tnew {
    if [[ -z "$TMUX" ]];then
        # Start tmux server if it doesn't exist
        # pgrep tmux >& /dev/null || tmux new -d
        # if session exists return
        tmux has-session -t $1 >& /dev/null && return
        # if restoration function exists, use it otherwise just create a new session
        if [[ -f ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh ]];then
            tmux new -d -s $1 \; run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh
        else
            tmux new -d -s $1
        fi
    fi
}

# Attach to a tmux session with the given name
function tmoox {
    if [[ -z "$TMUX" ]];then
        tnew $1
        tmux attach -t $1
    fi
}
alias tmain="tmoox main"

# Start main tmux session in background if it doesn't exist
tnew main

gitcache="git config credential.helper cache"

# Disk usage command for current directory
function dud {
    DIRTODU=${1:-.}
    # h is for human readable
    # x is to not traverse any mounted subdirectories
    du -hx --max-depth 1 -- "$DIRTODU"  | sort -h 
}
