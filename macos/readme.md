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

``` bash
mv ~ && curl -LO https://github.com/agarrharr/settings/archive/master.zip && unzip master.zip &&  mv ~/settings-master ~/settings && rm master.zip
~/settings/macos/scripts/install.sh
```

Install node [from website](https://nodejs.org).

Make a directory for npm global installations.

```
mkdir ~/.npm-global
```

Change ownership of `/usr/local`.

```
chown adamgarrett-harris /usr/local
```

Create Development structure

```
mkdir -p ~/Development/github/agarrharr
mkdir -p ~/Development/github/others
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

#### System Preferences

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
      - [x] Hammerspoon.app
      - [x] System Events.app
- Spotlight
  - Search Results
    - [x] Applications
    - [x] Calculator
    - [x] Conversion
    - [x] Definition
    - [x] System Preferences
- CDs & DVDs (only shows up if you have an external drive plugged in)
  - When you insert a music CD: Open VLC.app
  - When you insert a picture CD: Open Sequential.app
  - When you insert a video DVD: Open VLC.app
- Displays
  - Night Shift
    - Schedule - Sunrise to Sunset
- Keyboard
  - [ ] Adjust keyboard brightness in low light
  - Modifier Keys...
    - Apple Internal Keyboard / Trackpad
      - Caps Lock (⇪) Key: ⌃ Control
    - Das Keyboard
      - Caps Lock (⇪) Key: ⌃ Control
      - Option (⌥) Key: ⌘ Command
      - Command (⌘) Key: ⌥ Option
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
    - [x] Hammerspoon
    - [x] iTunesHelper
- Siri
  - [ ] Enable Siri
- Date & Time
  - Clock
    - [x] Digital
    - [x] Use a 24-hour clock
- Accessibility
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

### Manual Application Settings

- Make Skim the default app for `.pdf`.
- Make VLC the defalt app for video and audio (`.m4v`, `.mov`, `.mp3`, `.mp4`, etc.).
- Make Sequential the default app for images (`.jpg`, `.jpeg`, `.png`, `.gif`, etc.).

To make an app the default for a file type: Right-click on a file with that extension, and click "Info", change the app under "Open with:", and click "Change All...".

#### Audacity

Get LAME mp3 encoder.

#### Calendar

- Alerts
  - All Day Events: None
  - Birthdays: None
  - [ ] Time to Leave
- Advanced
  - [x] Turn on time zone support

#### Chrome

- Chrome menu -> "Warn Before Quitting (⌘Q)"
- Preferences
  - Settings
    - Search [DuckDuckGo]

#### Dropbox

- Sign in
- Preferences -> Import -> Photos
  - [ ] Enable camera uploads for [Photos and videos]

#### Firefox

- Preferences
  - General
    - Home Page: https://duckduckgo.com/
  - Search
    - Default Search Engine: DuckDuckGo

#### iTerm 2

Download [nova.itermcolors](https://raw.githubusercontent.com/trevordmiller/nova-iterm/master/build/nova.itermcolors)

- Profiles
  - Colors
    - [x] Smart Cursor Color
    - Color Presets
      - Import
        - nova.itermcolors

#### Hammerspoon

- [x] Launch Hammerspoon at login
- [ ] Show dock icon

#### Mail

- General
  - Default email reader: Mail.app
  - New messages sound: None
    - [ ] Play sounds for other mail actions
- Viewing
  - [x] Mark all messages as read when opening a conversation

#### Mutt

On Google, enable 2-step verification and add an [app specific password](https://security.google.com/settings/security/apppasswords). Use this password in the `~/.my-pwds` file.

```
set my_realname="Your Name"
set my_email_a="your.email@gmail.com"
set my_pass_a="password"
set my_url_a="smtp://username@smtp.gmail.com:587/"
```

Create gpg key.

```
gpg --gen-key
```
Accept all the defaults, enter real name, email address, and password for the key. This is the password that you will use for mutt.

Encrypt the password file and delete the old one. srm is a more secure delete.

```
gpg -r adam@gmail.com -e ~/.my-pwds
srm ~/.my-pwds
```

#### Notational Velocity

- Preferences -> Notes -> Storage -> Store and read notes on disk as: Plain Text Files *
- Notes -> Read notes from: ~/Dropbox/notes

#### Surfingkeys

Load settings from `~/.config/surfingkeys/index.js`

### Mac App Store Apps to Install

- Final Cut Pro

#### Other Apps to Install

- [Audacity](http://www.audacityteam.org/)
- [LayerX](https://github.com/yuhua-chen/LayerX)
- [Postgres.app](reattach-to-user-namespace)

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
