# Install Homebrew

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade

# Install packages

apps=(
  # bash-completion2
  coreutils
  # dockutil
  # fasd
  # gifsicle
  git
  # git-extras
  gnu-sed --with-default-names
  grep --with-default-names
  # hub
  # httpie
  imagemagick
  image_optim
  # jq
  # mackup
  # peco
  # psgrep
  python
  # shellcheck
  # ssh-copy-id
  # tree
  wget
  wireshark --with-qt
)

brew install "${apps[@]}"