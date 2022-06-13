# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=20000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


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

# My Settings
addPath "$HOME/bin"
addPath "$HOME/.local/bin"
if [ -d $HOME/.local/lib/shellshoccar/bin ]; then addPath "$HOME/.local/lib/shellshoccar/bin"; fi
if [ -d $HOME/.poetry/bin ]; then addPath "$HOME/.poetry/bin"; fi
    if [ -d $HOME/workspace/kotoriotoko/BIN ]; then addPath "$HOME/workspace/kotoriotoko/BIN"; fi
addPath "/usr/local/go/bin" # go-land
addPath "$HOME/go/bin" # go-land

case "$(uname -s)" in
  Linux* )
    stty -ixon # disable Ctrl-s freez
    bind 'set bell-style none'
    ;;
  MINGW* | CYGWIN* )
    export MSYS=winsymlinks:nativestrict
    # Set env for Japanese
    export LC_ALL=ja_JP.utf8
    export LANG=ja_JP.utf8
    export LANGUAGE=ja_JP.utf8
    export LC_CTYPE="ja_JP.utf8"
    export LC_NUMERIC="ja_JP.utf8"
    export LC_TIME="ja_JP.utf8"
    export LC_COLLATE="ja_JP.utf8"
    export LC_MONETARY="ja_JP.utf8"
    export LC_MESSAGES="ja_JP.utf8"
    if [ -f $HOME/.local/lib/ctags/ctags.exe ]; then PATH="$PATH:$HOME/.local/lib/ctags" ; fi
    ;;
  MSYS* )
    export HOMEX='/c/Users/$USERNAME'
    alias cdh='cd /c/Users/$USERNAME'
esac

# alias
alias ts-node='node_modules/.bin/ts-node' # alias for ts-node
alias cdw='cd ~/workspace' # alias for ts-node
alias v='vim'
alias v='vim'
