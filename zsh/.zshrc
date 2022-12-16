#############################
# ENV
############################

# Homebrew to set PATH, MANPATH, etc.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Zsh-completions
if type brew &>/dev/null; then
  fpath=(
    $(brew --prefix)/share/zsh-completions
    $fpath
  )
fi

# Other completions stored in dotfiles
fpath=(
  ${HOME}/.zsh_completions
  ${fpath}
)

# Enable the completions written above.
autoload -Uz compinit && compinit

# set default editor to vim
export EDITOR=vim

############################
# ALIAS
############################
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


############################
# PROMPT
############################

# git-propmt settings
source ${HOME}/.zsh_git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

export PROMPT='%F{red}[%n@%m]%f %F{green}%~%f %F{cyan}$(__git_ps1 "(%s)")%f %# '
