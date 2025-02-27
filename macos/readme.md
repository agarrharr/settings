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
cd ~ && curl -LO https://github.com/agarrharr/settings/archive/master.zip && unzip master.zip &&  mv ~/settings-master ~/settings && rm master.zip
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
cd ~/settings && git init && git remote add origin git@github.com:agarrharr/settings.git && git remote update -f && git checkout master && cd -
```

## Manual Settings

### Manual System Settings

#### System Settings

- General
  - Default web browser: Google Chrome.app
- Mission Control
  - [ ] Automatically rearrange Spaces based on most recent use
- Security & Privacy
  - General
    - [x] Require password [immediately] after sleep or screen saver begins
  - Privacy
    - Accessibility
      - [x] Dropbox.app
      - [x] System Events.app
- Spotlight
  - Search Results
    - [x] Applications
    - [x] Calculator
    - [x] Conversion
    - [x] Definition
    - [x] System Preferences
- Displays
  - Night Shift
    - Schedule - Sunrise to Sunset
- Keyboard
  - Keyboard
    - [ ] Adjust keyboard brightness in low light
  - Shortcuts
    - Display
      - [ ] Decrease display brightness
      - [ ] Increase display brightness
- Trackpad
  - Point & Click
    - [ ] Look up & data detectors
    - [x] Tap to click
  - More Gestures
    - [ ] Swipe between pages
    - [ ] Launchpad
- iCloud
  - [x] Find My Mac
- Touch ID
  - Use Touch ID for:
    - [x] Unlocking your Mac
- Users & Groups
  - Login Items
    - [x] Dropbox
- Siri
  - [ ] Enable Siri
- Date & Time
  - Clock
    - [x] Digital
    - [x] Use a 24-hour clock
- Accessibility
  - Display
    [x] Show window title icons (This shows proxy icons in Finder)
  - Zoom
    - [x] Use scroll gesture with modifier keys to zoom:
      - Control
  - Mouse & Trackpad
    - Trackpad Options...
      - [x] Enable dragging [three finger drag]

#### Finder

- Preferences
  - General
    - Show these items on the desktop:
      - [ ] Hard disks
      - [ ] External disks
      - [ ] CDs, DVDs, and iPods
      - [ ] Connected servers
    - New Finder windows show: Development
- Sidebar
  - Favorites
    - Dropbox
    - Development
    - Documents
    - Downloads
  - Hide Tags
  - Hide Shared

### Screensaver

Get an [awesome screensaver](https://github.com/chrstphrknwtn/epoch-flip-clock-screensaver/)

### Manual Application Settings

### Mac App Store Apps to Install

- Airmail
- Cardhop
- Drafts
- Fantastical
- Moom
- OmniFocus

#### Other Apps to Install

- [Mob cli](https://github.com/remotemobprogramming/mob)
- [Chatology](https://www.flexibits.com/chatology)
- [Forecast](https://overcast.fm/forecast)
- [Kibohd Configurator](https://input.club/configurator-ergodox)
- [MonitorControl](https://github.com/MonitorControl/MonitorControl)

#### Cardhop

- General
  - [x] Hide Cardhop in Dock

#### Chrome

- Chrome menu -> "Warn Before Quitting (⌘Q)"
- Preferences
  - Settings
    - Search engine used in the address bar: [DuckDuckgo]
- Dev Tools
  - Network
  - [x] Disable cache

#### Dropbox

- Sign in
- Preferences -> Import -> Photos
  - [ ] Enable camera uploads for [Photos and videos]

#### Fantastical

- General
  - Start week on: Monday

#### Firefox

- Preferences
  - General
    - Home Page: https://duckduckgo.com/
  - Search
    - Default Search Engine: DuckDuckGo

#### iTerm 2

Download [Solarized](https://ethanschoonover.com/solarized)

- Profiles
  - General
    - Send text at start: `tmux attach -t base || tmux new -s base`
  - Colors
    - [x] Smart Cursor Color
    - Color Presets
      - Import
        - Solarized Dark
      - Change Black Bright to "586e75"
  - Text
    - Font size 22

#### Keyboard Maestro

File -> Start Syncing Macros -> Open Existing -> Choose from iCloud Drive Keyboard\ Maestro/"Keyboard Maestro Macros.kmsync"

#### MonitorControl

- General
  - [x] Sync brightness changes from Built-in and Apple displays
  - [x] Start at Login
- Displays
  - [x] Show a slider for contrast

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
  - [ ] Show preferences on launch
  - Run as [faceless] application
- Mouse
  - Zoom Button Controls
    - [x] Enable [hexagon] grid with [6] x [4] cells
  - Snap to Edges and Corners
    - [x] Move & Zoom when dragging a window to a display edge or corner
      - Top [Full Screen]
      - Bottom [-]

#### OmniFocus

In the Projects perspective: [x] Show Inbox

I have icons in a folder for custom perspectives at `~/settings/macos/apps/OmniFocus`. OmniFocus doesn't work with svgs, but I might want to change their color in the future. To do so, change the fill color of the svg, then use ImageMagick to convert it to a png:

```
convert -background none -density 1200 -resize 1024x1024 book.svg book.png
```

#### Surfingkeys

Load settings from `~/.config/surfingkeys/index.js`

#### TextExpander

- Appearance
  - [x] Hide TextExpander icon in Dock

### Manual Development Settings

#### SSH Config

Create `~/.ssh/config`. Here is an example:

```
# Default GitHub
Host github.com
    HostName github.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa

# Work GitHub
Host git.work.com
    HostName git.work.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/work_rsa

# Gitlab
Host gitlab.com
    HostName gitlab.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/gitlab_rsa
```

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
