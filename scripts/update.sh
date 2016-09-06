#!/bin/bash

set -euo pipefail

# Ask for the administrator password upfront
sudo -v

fancy_echo() {
  echo $'\e[32;1m'$1$'\e[0m'
}

fancy_echo "Running software update script"
fancy_echo "Updating Homebrew packages and Cask graphical apps"
brew update && brew upgrade && brew cleanup
fancy_echo "Updating Git Submodules"
cd ~/setttings && git submodule update && cd -
fancy_echo "Updating Node"
n latest
fancy_echo "Updating npm packages"
npm update -g
fancy_echo "Updating RubyGems"
gem update --system
fancy_echo "Updating Neovim plugins"
nvim +PlugInstall +PlugClean +qall
fancy_echo "Updating Mac"
sudo softwareupdate -iva
fancy_echo "Software update complete!"
