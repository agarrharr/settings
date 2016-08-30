#!/bin/bash
set -euo pipefail

echo "Running software update script"
echo "Updating Homebrew packages and Cask graphical apps"
brew update && brew upgrade
echo "Updating Node"
n latest
echo "Updating npm packages"
npm update -g
echo "Updating Vim plugins"
vim +PluginInstall +PluginClean +qall
echo "Updating Mac"
sudo softwareupdate -iva
echo "Software update complete!"
