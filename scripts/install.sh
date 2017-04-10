#!/bin/bash

set -euo pipefail

# Ask for the administrator password upfront
sudo -v

. $HOME/settings/scripts/fancy_echo.sh

function install_xcode_command_line_tools () {
  fancy_echo 'Installing Xcode Command Line Tools'
  if pkgutil --pkg-info com.apple.pkg.CLTools_Executables >/dev/null 2>&1; then
    echo 'Already installed'
  else
    xcode-select --install
  fi
}

function install_zsh () {
  fancy_echo 'Installing zsh'
  # Test to see if zshell is installed.  If it is:
  if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
      chsh -s $(which zsh)
    fi
  else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
      sudo apt-get install zsh
      install_zsh
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
      echo "Please install zsh, then re-run this script!"
      exit
    fi
  fi
}

function submodules () {
  fancy_echo 'Installing submodules'
  cd ~/settings && git submodule init && git submodule update && cd -
}

function install_or_update_homebrew {
  which -s brew
  if [[ $? != 0 ]] ; then
      fancy_echo 'Installing Homebrew'
      # Install Homebrew
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      sudo chown -R $(whoami) /usr/local
  else
      fancy_echo 'Updating Homebrew'
      brew update
  fi
}

function install_or_update_homebrew_package {
  if ! brew list $1 >& /dev/null; then
	brew install $1
  fi
}

function homebrew_packages {
  install_or_update_homebrew

  packages=$(cat ~/settings/apps/homebrew_packages.txt)

  # Use Homebrew to install command line packages
  fancy_echo 'Installing Homebrew packages'
  for package in $packages; do
    install_or_update_homebrew_package $package
  done
}

function npm_packages {
  fancy_echo 'Installing npm packages'

  n latest

  packages=$(cat ~/settings/apps/npm_packages.txt)

  # Use npm to install command line packages
  for package in $packages; do
    npm install -g $package
  done
}

yarn_get_tarball() {
  # https://yarnpkg.com/install.sh
  reset="\e[0m"
  cyan="\e[0;36m"
  cd ~
  printf "$cyan> Downloading tarball...$reset\n"
  curl -L -o yarn.tar.gz "https://yarnpkg.com/latest.tar.gz" >/dev/null # get tarball

  printf "$cyan> Extracting to ~/.yarn...$reset\n"
  mkdir .yarn
  tar zxf yarn.tar.gz -C .yarn --strip 1 # extract tarball
  rm -rf yarn.tar.gz # remove tarball
  cd -
}

function install_yarn {
  fancy_echo 'Installing Yarn'
  rm -rf $HOME/.yarn
  if  [ ! -d $HOME/.yarn ]; then
    yarn_get_tarball
  fi
}

function dotfiles {
  fancy_echo 'Copying dotfiles'

  # Create dotfile symlinks in home directory
  for file in $(find ~/settings/dotfiles -depth 1 -exec basename {} \;); do
    rm -rf ~/$file
    ln -s ~/settings/dotfiles/$file ~/$file
  done
}

function nvim {
  fancy_echo "Installing Neovim"
  fancy_echo "Brew install neovim"
  brew tap neovim/neovim
  brew install neovim
  fancy_echo "pip install neovim"
  pip2 install neovim
  pip3 install neovim
  fancy_echo "gem install neovim"
  gem install neovim

  # https://github.com/neovim/neovim/wiki/FAQ#my-ctrl-h-mapping-doesnt-work
  infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
  tic $TERM.ti
}

function nvim_plugins {
  fancy_echo 'Installing Neovim plugins'

  # Install vim-plug
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # Use vim-plug to install Neovim plugins
  nvim +PlugInstall +qall
}

function install_or_update_gui_app {
  if ! brew cask list $1 >& /dev/null; then
	brew cask install $1
  fi
}

function gui_apps {
  fancy_echo 'Installing GUI apps'
  apps=$(cat ~/settings/apps/gui_apps.txt)

  # Use Homebrew Cask to install gui apps
  for app in $apps; do
    install_or_update_gui_app $app
  done
}

function ruby {
  if ! command -v rbenv >/dev/null; then
    if ! command -v rvm >/dev/null; then
      fancy_echo 'Installing RVM and the latest Ruby...'
      curl -L https://get.rvm.io | bash -s stable --ruby --auto-dotfiles --autolibs=enable
      . ~/.rvm/scripts/rvm
    else
      local_version="$(rvm -v 2> /dev/null | awk '$2 != ""{print $2}')"
      latest_version="$(curl -s https://raw.githubusercontent.com/wayneeseguin/rvm/stable/VERSION)"
      if [ "$local_version" != "$latest_version" ]; then
        fancy_echo 'Upgrading RVM...'
        rvm get stable --auto-dotfiles --autolibs=enable --with-gems="bundler"
      else
        fancy_echo "Already using the latest version of RVM. Skipping..."
      fi
    fi
  fi
}

function install_or_update_gem {
  if gem list "$1" | grep "^$1 ("; then
    fancy_echo "Updating $1..."
    gem update "$@"
  else
    fancy_echo "Installing $1..."
    gem install "$@"
  fi
}

function ruby_gems {
  gems=$(cat ~/settings/apps/ruby_gems.txt)

  fancy_echo 'Installing Ruby gems'
  for gem in $gems; do
    install_or_update_gem $gem
  done
}

function macos {
  fancy_echo 'Run Mac Scripts'
  ~/settings/scripts/.macos
}

function development {
  fancy_echo 'Create Development directory'
  mkdir -p ~/Development
}

function install {
  install_xcode_command_line_tools
  install_zsh
  submodules
  dotfiles
  homebrew_packages
  npm_packages
  install_yarn
  gui_apps
  nvim
  nvim_plugins
  ruby
  ruby_gems
  macos
  development
}

install
