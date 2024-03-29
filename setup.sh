#!/bin/sh -ue

dotdir=$(
  cd "$(dirname "$0")" || exit
  pwd
)

is_file() {
  file="$1"

  [ -f "$file" ] && return 0
  return 1
}

is_dir() {
  file="$1"

  [ -d "$file" ] && return 0
  return 1
}

is_file_or_dir() {
  file="$1"

  if is_file "$file" || is_dir "$file"; then
    return 0
  else
    return 1
  fi
}

ask_user_permission() {
  msg="$1"
  printf "%s" "$msg" >&2
  while true; do
    read -r answer
    case $answer in
    [Yy]*) return 0 ;;
    [Nn]*) return 1 ;;
    *) printf "Please answer yes or no. (y/n) " >&2 ;;
    esac
  done
}

has_overwrite_permission() {
  file="$1"

  if ! is_file_or_dir "$file"; then
    return 0
  fi

  msg="$file is already exist. Do you overwrite it? (y/n) "
  if ask_user_permission "$msg"; then
    return 0
  fi

  return 1
}

make_link() {
  src_path="$1"
  dest_path="$2"

  if has_overwrite_permission "$dest_path"; then
    if [ -L "$dest_path" ]; then
      unlink "$dest_path"
    fi
    ln -sf "$src_path" "$dest_path"
    printf "%s --> %s link is created.\n" "$src_path" "$dest_path" >&2
  else
    printf "%s isn't permitted to be overwritten\n" "$dest_path" >&2
  fi
}

setup_vim() {
  make_link "$dotdir/vim/.vim" "$HOME/.vim"
  make_link "$dotdir/vim/.vimrc" "$HOME/.vimrc"
}

setup_nvim(){
  make_link "$dotdir/nvim" "$HOME/.config/nvim"
}

setup_tmux(){
  make_link "$dotdir/tmux/.tmux.conf" "$HOME/.tmux.conf"
}

setup_git() {
  git config --global user.email "ppdx999@gmail.com"
  git config --global user.name "ppdx999"
  git config --global core.editor "vim"
  git config --global diff.tool vimdiff
  git config --global difftool.prompt false
  git config --global --add merge.ff false
  git config --global --add pull.ff only
  git config --global core.hooksPath "$HOME/.git_hooks"
  make_link "$dotdir/git/hooks" "$HOME/.git_hooks"
  git config --global alias.tree 'log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s"'
}

setup_bash() {
  make_link "$dotdir/bash/.bashrc" "$HOME/.bashrc"
  make_link "$dotdir/bash/completions" "$HOME/.bash_completions"
}

setup_zsh() {
  make_link "$dotdir/zsh/.zshrc" "$HOME/.zshrc"
  make_link "$dotdir/zsh/completions" "$HOME/.zsh_completions"
  make_link "$dotdir/zsh/git-prompt.sh" "$HOME/.zsh_git-prompt.sh"
}

setup_bin() {
  make_link "$dotdir/bin" "$HOME/bin"
}

setup_yabai() {
  make_link "$dotdir/yabai/.skhdrc" "$HOME/.skhdrc"
  make_link "$dotdir/yabai/.yabairc" "$HOME/.yabairc"
}

main() {
  :
  # setup_tmux
  # setup_git
  # setup_vim
  # case $SHELL in
  # */zsh) setup_zsh ;;
  # */bash) setup_bash ;;
  # *) ;;
  # esac
  # setup_yabai
}

main "$@"
