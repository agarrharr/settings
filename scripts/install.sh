#!/bin/bash
set -euo pipefail

# Ask for the administrator password upfront
sudo -v

function install_zsh () {
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

function homebrew_packages {

  # Install or update Homebrew

  which -s brew
  if [[ $? != 0 ]] ; then
      # Install Homebrew
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
      brew update
  fi

  # Use Homebrew to install command line packages
  for package in $1; do
    brew install $package
  done
}

function npm_packages {

  n latest

  # Use npm to install command line packages
  for package in $1; do
    npm install -g $package
  done
}

function dotfiles {

  # Create dotfile symlinks in home directory
  for file in $1; do
    rm -rf ~/$file
    ln -s $2/$file ~/$file
  done
}

function nvim_plugins {

  # required for deoplete plugin in neovim
  pip3 install neovim

  # Install vim-plug
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # Use vim-plug to install Neovim plugins
  nvim +PlugInstall +qall
}

function gui_apps {

  # Use Homebrew Cask to install gui apps
  for app in $1; do
    brew cask install $app
  done
}

function other_apps {
  gem install timetrap
}

function bootstrap {
  install_zsh
  homebrew_packages "git hub n neovim/neovim/neovim pianobar python3 reattach-to-user-namespace tmux vim z"
  # reattach-to-user-namespace is for tmux
  npm_packages "eslint diff-so-fancy mocha pure-prompt"
  dotfiles ".bin .config .eslintrc .gitconfig .gitignore .hushlogin .hyperterm.js .mutt .muttrc .tmux .tmux.conf .zsh .zshrc" ~/settings/dotfiles
  gui_apps "audacity audacity-lame-library bartender better-window-manager dropbox evernote flux glueprint google-chrome hyperterm istat-menus iterm2 karabiner notational-velocity rescuetime screenflow spotify sublime-text textexpander ynab"
  nvim_plugins
  other_apps
}

# Init
bootstrap
