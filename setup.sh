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

# === Define the commonly used and useful functions ===================

error_exit() {
	echo "$0: ${1:-"Unknown Error"}" 1>&2
	exit 1
}

print_usage_and_exit() {
  cat <<-USAGE 1>&2
		USAGE        :  open_browser file ... 
		Description  :  make it easier to open the browser from the console 
	USAGE
  exit 1
}

detectOS() {
   case "$(uname -s)" in
   	Linux*)     echo Linux;;
   	Darwin*)    echo Mac;;
   	CYGWIN*)    echo Cygwin;;
   	MINGW*)     echo MinGw;;
	MSYS*)      echo MSYS;;
   	*)          echo "UNKNOWN:$(uname -s)" ;;
   esac
}

###############################################################################
# Main Routine 
###############################################################################
# === Main Routine ===================================================

case "$(detectOS)" in
	'Linux' | 'Mac' )
		ln -sf $HOME/dotfiles/.vimrc $HOME/.vimrc
		ln -sf $HOME/dotfiles/.bashrc $HOME/.bashrc
		ln -sf $HOME/dotfiles/.vim $HOME/.vim
		;;
	'MSYS' )
		case $( sed -n -e 's/^rem set MSYS=winsymlinks:nativestrict$/set MSYS=winsymlinks:nativestrict/' -e 's/^rem set MSYS2_PATH_TYPE=inherit$/set MSYS2_PATH_TYPE=inherit/' /msys2_shell.cmd ) in 
			'' ) 
				ln -sf $HOME/dotfiles/.vimrc $HOME/.vimrc
				ln -sf $HOME/dotfiles/.bashrc $HOME/.bashrc
				ln -sf $HOME/dotfiles/.vim $HOME/.vim
				;;
			*)
				sed -e 's/^rem set MSYS=winsymlinks:nativestrict$/set MSYS=winsymlinks:nativestrict/' -e 's/^rem set MSYS2_PATH_TYPE=inherit$/set MSYS2_PATH_TYPE=inherit/' /msys2_shell.cmd > "/msys2_shell.cmd.$(date +'%Y%m%d')"
				mv "/msys2_shell.cmd.$(date +'%Y%m%d')" /msys2_shell.cmd
				echo 'Re-Execute setup.sh as administrator'
        exit
				;;
		esac
		;;
	* )
		error_exit "Unsupported OS or System"
esac
