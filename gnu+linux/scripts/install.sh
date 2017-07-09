#!/bin/bash

function green_echo {
  GREEN='\033[0;32m'
  NC='\033[0m'
  echo -e "${GREEN}$1${NC}"
}

function red_echo {
  RED='\033[0;31m'
  NC='\033[0m'
  echo -e "${RED}$1${NC}"
}

function uninstall_packages {
  apps='unity-webapps-common'

  for app in $apps; do
    which $app > /dev/null
    if [ $? == 0 ]; then
      green_echo "Uninstalling ${app}"
      sudo apt-get --assume-yes purge $app
    fi
  done
}

function install_packages {
  green_echo 'Installing packages'
  apps=$(cat ~/Development/github/aharris88/settings/gnu+linux/packages.txt)

  for app in $apps; do
    which $app > /dev/null
    if [ $? == 1 ]; then
      green_echo "Installing ${app}"
      sudo apt-get install --assume-yes $app
    fi
  done
}

function copy_dotfiles {
  green_echo 'Copying dotfiles'

  mkdir -p ~/.OLD_DOTFILES

  for file in $(find ~/Development/github/aharris88/settings/gnu+linux/dotfiles -maxdepth 1 -mindepth 1 -exec basename {} \;); do
    if [ -e ~/$file ]
      then mv ~/$file ~/.OLD_DOTFILES/$file
    fi
    ln -s ~/Development/github/aharris88/settings/gnu+linux/dotfiles/$file ~/$file
  done
}

function install {
  uninstall_packages
  copy_dotfiles
  install_packages
}

install
