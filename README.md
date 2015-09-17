# Dotfiles

This repository includes all of my custom dotfiles.  They should be cloned to your home directory so that the path is `~/dotfiles/`.  The included setup script creates symlinks from your home directory to the files which are located in `~/dotfiles/`.

The setup script is smart enough to back up your existing dotfiles into a `~/dotfiles_old/` directory if you already have any dotfiles of the same name as the dotfile symlinks being created in your home directory.

I also prefer `zsh` as my shell of choice.  As such, the setup script will check to see if `zsh` is installed.  If `zsh` is installed, and it is not already configured as the default shell, the setup script will execute a `chsh -s $(which zsh)`.  This changes the default shell to zsh, and takes effect as soon as a new zsh is spawned or on next login.

So, to recap, the install script will:

1. Back up any existing dotfiles in your home directory to `~/dotfiles_old/`
2. Create symlinks to the dotfiles in `~/dotfiles/` in your home directory
3. Check to see if `zsh` is installed, if it isn't, try to install it.
4. If zsh is installed, run a `chsh -s` to set it as the default shell.

## Installation

``` bash
git clone git://github.com/aharris88/dotfiles ~/dotfiles
cd ~/dotfiles
./setup.sh
```

## Get Homebrew

```
# install homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
```

## Node

```
# install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | bash
# install node
nvm install stable
# install iojs
nvm install iojs
```

## Tmux

```
# install tmux
brew install tmux
# reattach-to-user-namespace allows you to copy from tmux to the system clipboard
# if you don't have it installed then when you start tmux it will exit with `[exited]`
# if you don't want to install this, remove the line in `tmux.conf` that includes `reattach-to-user-namespace`
brew install reattach-to-user-namespace
```

## Keyboard Settings

I remap my keys so that the caps lock key is control and control is caps lock, but it's only control if you press it in combination with another key, otherwise it's escape. And then my enter/return key is control if pressed in combination, otherwise it's enter.

To do this go to System Preferences -> Keyboarda -> Modifier Keys... -> and switch Caps Lock and Control.

Then install [Karabiner](https://github.com/tekezo/Karabiner). And turn on these settings:

Control-L to Control_L (+ When you type Control_L only, send Escape)

Return to Control_L (+ When you type Return only, send Return) + [KeyRepeat]

## Other stuff

```
# pianobar (pandora player)
brew install pianobar
```
