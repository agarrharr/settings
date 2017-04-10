# Settings

This repository includes all of my custom settings and dotfiles. They have been generalized as much as possible for use by other people, but they are mostly just for my personal use.

I prefer `zsh` instead of `bash`, so the setup script will check to see if `zsh` is installed.  If `zsh` is installed, and it is not already configured as the default shell, the setup script will execute a `chsh -s $(which zsh)`.  This changes the default shell to zsh, and takes effect as soon as a new zsh is spawned or on next login.

I remap my keyboard so that the control is caps lock, and caps lock key is control, but it's only control if you press it in combination with another key, otherwise it's escape. And then my enter/return key is control if pressed in combination, otherwise it's enter.

The install script will:

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
curl -LO https://github.com/aharris88/settings/archive/master.zip && unzip master.zip &&  mv settings-master ~/settings && rm master.zip
~/settings/scripts/install.sh
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
cd ~/settings && git init && git add . && git remote add origin git@github.com:aharris88/settings.git && git remote update && git checkout master && cd -
```

## Manual Settings

### Manual System Settings

#### System Preferences

- General
  - Default web browser: Google Chrome.app
- Mission Control
  - [ ] Automatically rearrange Spaces based on most recent use
  - [x] Displays have separate Spaces
- Security & Privacy
  - Privacy
    - Accessibility
      - [x] Dropbox.app
      - [x] Hammerspoon.app
      - [x] Keyboard Maestro Engine.app
      - [x] Keyboard Maestro.app
      - [x] RescueTime.app
      - [x] Steam.app
      - [x] System Events.app
- Displays
  - Night Shift
    - Schedule - Sunrise to Sunset
- Keyboard
  - [ ] Adjust keyboard brightness in low light
  - [x] Use all keyboard and emoji viewers as standard function keys
  - Modifier Keys...
    - Apple Internal Keyboard / Trackpad
      - Caps Lock (⇪) Key: ⌃ Control
      - Control (⌃) Key: ⇪ Caps Lock
    - Das Keyboard
      - Caps Lock (⇪) Key: ⌃ Control
      - Control (⌃) Key: ⇪ Caps Lock
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
- Users & Groups
  - Login Items
    - [x] Bartender
    - [x] Bitbar
    - [x] Box Sync
    - [x] Dropbox
    - [x] Hammerspoon
    - [x] iTunesHelper
    - [x] Keyboard Maestro Engine
    - [x] RescueTime
- Accessibility
  - Zoom
    - [x] Use scroll gesture with modifier keys to zoom:
      - Control

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
    - [ ] AirDrop
    - [ ] All My Files
    - [ ] Applications
    - [ ] Desktop
    - [ ] iCloud Drive
    - [ ] Box Sync
    - [x] Dropbox
    - [x] Development
    - [x] Documents
    - [x] Downloads
  - Hide Tags
  - Hide Shared

### Manual Application Settings

#### Bartender

- Enable hiding Spotlight with Bartender (https://www.macbartender.com/B2/system-item-setup/)
- Menu Items
  - Completely Hide Menu Bar Item: Battery, Clock, Siri, Spotlight, Notification Center, User
  - Nothing, Bartender does not do anything: BitBar, TogglDesktop
  - Show in Bartender Bar, not in Menu Bar: everything else
  - Airport (wifi)
    - Item Updates
      - [x] Show item in menu bar
        - for: 5 Seconds
- General
  - [x] Launch Bartender at Login
  - [ ] Autohides
  - Clicking on Bartender will (Display Bartender Bar items in menu bar)
- Appearance
  - Gap at right of menu bar: Insert a gap when Notification Center is hidden (off)
- Command + drap  the bartender icon all the way to the right, BitBar, wifi, then volume

#### Calendar

- Alerts
  - All Day Events: None
  - Birthdays: None
  - [ ] Time to Leave
- Advanced
  - [x] Turn on time zone support

#### Chrome

- Chrome menu -> "Warn Before Quitting (⌘Q)"

#### Dropbox

- Sign in
- Preferences -> Import -> Photos
  - [ ] Enable camera uploads for [Photos and videos]

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

#### Pianobar

Create `~/.my-pandora-pwd` that contains password.

#### Surfingkeys

Load settings from `~/.config/surfingkeys/index.js`

#### Todoist

- Preferences
  - Shortcuts
    - Show / Hide Todoist - ⌃⌘T
    - Quick Add Task - ⌃⌘A

#### Toggl

- Preferences
  - General
    - [ ] Idle detection
    - [x] Record timeline
    - [x] Show timer on menu bar
    - [x] Show project on menu bar
  - Reminder
    - [x] Remind to track time
      - (M-F)

### Mac App Store Apps to Install

- Final Cut Pro
- OneDrive
- Todoist

#### Other Apps to Install

- Outlook
- Tweetdeck

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
alias ge="git config --global user.email 'aharris88@users.noreply.github.com'"
alias gwe="git config --global user.email 'adam@work.com'"
```
