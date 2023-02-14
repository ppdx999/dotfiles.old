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
PS1='\[\e[1;32m\]\u\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]:$\[\e[0m\] '

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

