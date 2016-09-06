#!/bin/bash

set -euo pipefail

# Ask for the administrator password upfront
sudo -v

fancy_echo() {
  echo $'\e[32;1m'$1$'\e[0m'
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

function install_or_update_homebrew_package {
  if ! brew list $1 >& /dev/null; then
	brew install $1
  fi
}

function homebrew_packages {
  # Install or update Homebrew
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

  # Use Homebrew to install command line packages
  fancy_echo 'Installing Homebrew packages'
  for package in $1; do
    install_or_update_homebrew_package $package
  done
}

function npm_packages {
  fancy_echo 'Installing npm packages'

  n latest

  # Use npm to install command line packages
  for package in $1; do
    npm install -g $package
  done
}

function dotfiles {
  fancy_echo 'Copying dotfiles'

  # Create dotfile symlinks in home directory
  for file in $(find ~/settings/dotfiles -depth 1 -exec basename {} \;); do
    rm -rf ~/$file
    ln -s ~/settings/dotfiles/$file ~/$file
  done
}

function nvim_plugins {
  fancy_echo 'Installing Neovim plugins'

  # required for deoplete plugin in neovim
  pip3 install neovim

  # Install vim-plug
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # Use vim-plug to install Neovim plugins
  nvim +PlugInstall +qall
}

function gui_apps {
  fancy_echo 'Installing GUI apps'

  # Use Homebrew Cask to install gui apps
  for app in $1; do
    brew cask install $app
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
    fancy_echo "Updating %s ..." "$1"
    gem update "$@"
  else
    fancy_echo "Installing %s ..." "$1"
    gem install "$@"
  fi
}

function ruby_gems {
  fancy_echo 'Installing Ruby gems'
  for gem in $1; do
    install_or_update_gem $gem
  done
}

function bootstrap {
  install_zsh
  submodules
  dotfiles
  # reattach-to-user-namespace is for tmux
  homebrew_packages "git gpg hub mutt n neovim/neovim/neovim pianobar python3 reattach-to-user-namespace tmux vim z"
  npm_packages "eslint diff-so-fancy mocha pure-prompt trash-cli"
  gui_apps "audacity audacity-lame-library bartender better-window-manager dropbox evernote flux glueprint google-chrome hyperterm istat-menus iterm2 karabiner notational-velocity rescuetime screenflow spotify sublime-text textexpander"
  nvim_plugins
  ruby
  ruby_gems "bundler timetrap"
}

# Init
bootstrap
