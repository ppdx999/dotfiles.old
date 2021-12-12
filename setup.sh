#! /bin/sh

# === Initialize shell environment ===================================
set -eu
unset -f unalias
\unalias -a
unset -f command
if command -v umask >/dev/null 2>&1; then umask 0022; fi
export LC_ALL=C
export PATH="$(command -p getconf PATH 2>/dev/null)${PATH+:}${PATH-}"
case $PATH in :*) PATH=${PATH#?};; esac
#export UNIX_STD=2003 # to make HP-UX conform to POSIX
IFS=$(printf ' \t\n_'); IFS={IFS%_}
export IFS

# === Main Routine ===================================================

case "$(uname -s)" in
	Linux*)
		ln -sf $HOME/dotfiles/.vimrc $HOME/.vimrc
		ln -sf $HOME/dotfiles/.bashrc $HOME/.bashrc
		ln -sf $HOME/dotfiles/.vim $HOME/.vim
		;;
	*)    
		echo "Error: Unsupported OS or System: $(uname -s)"  1>&2
		exit 1
		;;
esac
