# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#############################
# History
#############################

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=20000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

#############################
# ENV
#############################
include(){
    case _"$1" in 
      _*"$2"* ) return 0 ;;
      * ) return 1 ;;
    esac
}

addPath() {
    if ! include "$PATH" "$1"; then
        PATH="$PATH:$1"
    fi
}

addPath "$HOME/bin"
addPath "$HOME/.local/bin"
addPath "/usr/local/go/bin" # go-land
addPath "$HOME/go/bin" # go-land

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


############################
# ALIAS
############################
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ts-node='node_modules/.bin/ts-node' # alias for ts-node
alias cdw='cd ~/workspace' # alias for ts-node
alias v='vim'
alias v='vim'

############################
# PROMPT
############################
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# Git Prompt
if [ -f "$HOME/.bash_completions/git-completion.bash" ]; then
    source "$HOME/.bash_completions/git-completion.bash" 
fi

if [ -f "$HOME/.bash_completions/git-prompt.sh" ]; then
    source "$HOME/.bash_completions/git-prompt.sh"
fi

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

# PS1="\[\033[1;32m\]\$(date +%Y/%m/%d_%H:%M:%S)\[\033[0m\] \[\033[33m\]\H:\w\n\[\033[0m\][\u@ \W]\[\033[36m\]\$(__git_ps1)\[\033[00m\]\$ "
PS1="\[\e[1;31m\][\u@\h]\[\e[0m\] \[\e[1;32m\]\w\[\e[0m\]\[\e[1;36m\]\$(__git_ps1)\[\e[0m\] \$ "

