# Install Homebrew

if [ "$OS" = "macOS" ]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
fi

brew update
brew upgrade

# Install packages

apps=(
  # bash-completion2
  coreutils
  diff-so-fancy
  # dockutil
  fasd
  # gifsicle
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
  pandoc
  # peco
  # psgrep
  postgresql
  python
  # shellcheck
  # ssh-copy-id
  tldr
  # tree
  tomcat
  wget
  wireshark --with-qt
  zsh
  zsh-completions
)

brew install "${apps[@]}"

ln -sfv /usr/local/opt/postgresql/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/
ln -sfv /usr/local/opt/mysql/homebrew.mxcl.mysql.plist ~/Library/LaunchAgents/