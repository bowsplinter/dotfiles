#!/usr/bin/env bash

# Install Homebrew or make sure it's up to date
which -s brew
if [[ $? != 0 ]] ; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  brew update
  brew upgrade
fi

# Install packages

apps=(
  # bash-completion2
  bat
  coreutils
  ctags
  # dockutil
  fasd
  fd
  fzf
  ffmpeg
  gifsicle
  git
  # git-extras
  gnu-sed --with-default-names
  grep --with-default-names
  # hub
  # httpie
  imagemagick
  # jq
  # mackup
  mysql
  mobile-shell
  mosh
  npm
  pandoc
  # peco
  # psgrep
  p7zip
  postgresql
  python
  ripgrep
  # shellcheck
  # ssh-copy-id
  tldr
  # tree
  tomcat
  vim
  wget
  wireshark --with-qt
  zsh
  zsh-completions
)

brew install "${apps[@]}"

# Cleanup
brew cleanup

# Link applications
ln -sfv /usr/local/opt/postgresql/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/
ln -sfv /usr/local/opt/mysql/homebrew.mxcl.mysql.plist ~/Library/LaunchAgents/
