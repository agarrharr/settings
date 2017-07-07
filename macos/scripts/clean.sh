#!/bin/bash
set -euo pipefail

# Ask for the administrator password upfront
sudo -v

rm -rf ~/Downloads/*
sudo rm -rf ~/.Trash
