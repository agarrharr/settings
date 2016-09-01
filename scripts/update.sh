#!/bin/bash
set -euo pipefail

# Ask for the administrator password upfront
sudo -v

echo "Running software update script"
echo "Updating Homebrew packages and Cask graphical apps"
brew update && brew upgrade
echo "Updating Git Submodules"
cd ~/setttings && git submodule update && cd -
echo "Updating Node"
n latest
echo "Updating npm packages"
npm update -g
echo "Updating Neovim plugins"
nvim +PlugInstall +PlugClean +qall
echo "Updating Mac"
sudo softwareupdate -iva
echo "Software update complete!"
