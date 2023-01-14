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

# NVM 
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Java Setup
# 1. Install java via homebrew
#   $ brew install openjdk
# 2. Create symlink for the system Java wrappers to find this JDK
#   $ sudo ln -sfn /opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
# 3. Add PATH
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"

# Poetry Setup
export PATH="/Users/fujiswork/.local/bin:$PATH"

# Add $HOME/bin to $PATH
export PATH="$HOME/bin:$PATH"

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

setopt PROMPT_SUBST ; PS1='%F{red}[%n@%m]%f %F{green}%~%f %F{cyan}$(__git_ps1 "(%s)")%f %# '
