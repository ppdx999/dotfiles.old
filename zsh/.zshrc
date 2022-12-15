# Set PATH, MANPATH, etc., for Homebrew. (brew has 'shellenv' subcommands to set up PATH, MANPATH etc...)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Configuration for zsh-completions
if type brew &>/dev/null; then
  fpath=(
    $(brew --prefix)/share/zsh-completions
    $fpath
  )
fi

fpath=(
  ${HOME}/.zsh_completions
  ${fpath}
)

autoload -Uz compinit && compinit
export EDITOR=vim
