# Settings

This directory includes all of my old custom settings and dotfiles for macOS. They have been generalized as much as possible for use by other people, but they are mostly just for my personal use.

The setup script will check to see if `zsh` is installed.  If `zsh` is installed, and it is not already configured as the default shell, the setup script will execute a `chsh -s $(which zsh)`.  This changes the default shell to zsh, and takes effect as soon as a new zsh is spawned or on next login.

I remap my keyboard so that the control is caps lock, and caps lock key is control, but it's only control if you press it in combination with another key, otherwise it's escape. And then my enter/return key is control if pressed in combination, otherwise it's enter.

The `scripts/install.sh` script will:

1. Install zsh and set it as the default shell
1. Install Homebrew
1. Install Homebrew packages
1. Install npm
1. Install npm packages
1. Create symlinks to the dotfiles in `~/settings/dotfiles/` in your home directory
1. Install neovim plugins
1. Install gui apps with Homebrew Cask

## Installation

Download:

``` bash
cd ~ && curl -LO https://github.com/agarrharr/settings/archive/main.zip && unzip main.zip &&  mv ~/settings-main ~/settings && rm main.zip
```

Install Homebrew:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

Install node [from website](https://nodejs.org).

Run the script:

```
~/settings/macos/dotfiles/.config/scripts/install_mine
```

Create Development structure:

```
mkdir -p ~/Development/github/agarrharr
mkdir -p ~/Development/github/others
```

### Neovim

Deoplete requires Python

```
pip3 install --user pynvim
```

## Add Git Remote to Settings Directory

[Add SSH key to Github](https://github.com/settings/ssh)

```bash
ssh-keygen -t rsa -b 4096 -C "your.email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
pbcopy < ~/.ssh/id_rsa.pub
```

```bash
cd ~/settings && git init && git remote add origin git@github.com:agarrharr/settings.git && git remote update -f && git checkout main && cd -
```

## Manual Settings

### Manual System Settings

#### System Settings

- General
  - Date & Time
    - Clock
      - [x] Use a 24-hour clock
  - Language & Region
    - First day of week [Monday]
- Accessibility
  - Zoom
    - [x] Use scroll gesture with modifier keys to zoom:
      - Control
  - Display
    [x] Show window title icons (This shows proxy icons in Finder)
  - Pointer Control
    - Trackpad Options...
      - [x] Enable dragging
        - Dragging style [three finger drag]
- Desktop & Dock
  - Mission Control
      - [ ] Automatically rearrange Spaces based on most recent use
- Displays
  - Night Shift
    - Schedule - Sunrise to Sunset
- Lock Screen
  - [x] Require password [immediately] after sleep or screen saver begins
- iCloud
  - [x] Find My Mac
- Keyboard
  - Keyboard
    - [ ] Adjust keyboard brightness in low light
  - Shortcuts
    - Display
      - [ ] Decrease display brightness
      - [ ] Increase display brightness
    - Modifiers
      - Apple Internal Keyboard
        - Caps Lock -> Control
- Trackpad
  - Point & Click
    - [ ] Look up & data detectors
    - [x] Tap to click
  - More Gestures
    - [ ] Swipe between pages
    - [ ] Launchpad

#### Finder

- Settings
  - General
    - New Finder windows show: Development
- Sidebar
  - Favorites
    - Development
    - Documents
    - Downloads
  - Hide Tags
  - Hide Shared

### Screensaver

Get an [awesome screensaver](https://github.com/chrstphrknwtn/epoch-flip-clock-screensaver/)

### Manual Application Settings

#### iTerm 2

- Profiles
  - General
    - Send text at start: `tmux attach -t base || tmux new -s base`
  - Colors
    - Color Presets
        - Solarized Dark
  - Text
    - Download https://github.com/Karmenzind/monaco-nerd-fonts
    - Monaco Nerd Font Mono

#### Keyboard Maestro

File -> Start Syncing Macros -> Open Existing -> Choose from iCloud Drive Keyboard\ Maestro/"Keyboard Maestro Macros.kmsync"

#### Moom

Should be able to import settings with:

```
defaults import com.manytricks.Moom ~/settings/macos/apps/Moom.plist
```

If you need to back it up again, do:

```
defaults export com.manytricks.Moom ~/settings/macos/apps/Moom.plist
```

- General
  - [x] Launch automatically on login
  - Run as [faceless] application

#### TextExpander

- Appearance
  - [x] Hide TextExpander icon in Dock

### Manual Development Settings

#### Work vimrc

Create `~/.workvimrc`

Put something like this in it to make `:Gbrowse` from vim-fugitive work.

```
let g:fugitive_github_domains = ['git@workgithub.com']
```

#### .local.zshrc

Put something like this in `.local.zshrc`

```
alias ge="git config --global user.email 'agarrharr@users.noreply.github.com'"
alias gwe="git config --global user.email 'adam@work.com'"
```

#### .gitconfig.local

Put something like this in `~/.gitconfig.local`

```
[user]
	email = agarrharr@users.noreply.github.com
	name = Adam Garrett-Harris
```
