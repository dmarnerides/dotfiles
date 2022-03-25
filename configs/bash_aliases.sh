# Use vi mode in bash
# set -o vi

# Preserve history
# https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it
# Save and reload the history after each command finishes
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# export HISTCONTROL=ignoreboth:ignoredups:erasedups

# Useful functions
function mkdirif {
    [ -d $1 ] || mkdir $1
}

function disp {
    DISP=${1:-1}
    echo Setting Display to ":$DISP"
    export DISPLAY=":$DISP"

}


# export CUDNN_LIB_DIR=/usr/local/cuda/lib64
# export CUDNN_INCLUDE_DIR=/usr/local/cuda/include

# Add cuda to path
# export PATH="$PATH:/usr/local/cuda/bin"
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64

# pytorch(){
#     PYTHONSTARTUP="$HOME/.pytorchrc" python -i
# }
# alias torch=pytorch

# Prompt needs fixing for proper colors in tmux
# https://unix.stackexchange.com/questions/468139/color-codes-in-bash-ps1-not-working-in-tmux
export PS1="\[\e]0;\u@\h; \w\a\]${debian_chroot:+($debian_chroot)}"
export PS1="$PS1\[\033[01;32m\]\u@\h\[\033[00m\]:"
export PS1="$PS1\[\033[01;34m\]\w\[\033[00m\]\$ "


# # Set vi to vim such that the environment vim is used when vi is invoked
# alias vi=vim
# # Default vim to nvim
alias vim=nvim
# export PATH="$PATH:/usr/lib/w3m"

alias tmux="env TERM=xterm-256color tmux -2"
function tnew {
    tmux new -d -s $1
    tmux a -t $1 \; run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh
}

function tmoox {
    if [[ -z "$TMUX" ]];then
        tmux a -t $1 -d || tnew $1
    fi
}
alias tmain="tmoox main"
gitcache="git config credential.helper cache"

# Disk usage command for current directory
function dud {
    DIRTODU=${1:-.}
    # h is for human readable
    # x is to not traverse any mounted subdirectories
    du -hx --max-depth 1 -- "$DIRTODU"  | sort -h 
}

alias base="conda activate base"
