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

- Evernote
  - Sign in
- Fitbit
  - Sign in
- Spotify
  - Sign in
- Chrome
  - Sign in
  - Set Chrome to default browser
  - Chrome menu -> "Warn Before Quitting (⌘Q)"
  - Sign in to LastPass
- Dropbox
  - Sign in
  - Preferences -> Import -> Photos
    - [ ] Enable camera uploads for [Photos and videos]
- Paw
  - [Download](https://paw.cloud/)
- Notational Velocity
  - Preferences -> Notes -> Storage -> Store and read notes on disk as: Plain Text Files *
  - Notes -> Read notes from: ~/Dropbox/notes
- Bartender
  - Enable hiding Spotlight with Bartender (https://www.macbartender.com/B2/system-item-setup/)
  - Menu Items
    - Completely Hide Menu Bar Item: Battery, Clock, Siri, Spotlight, Notification Center, User
    - Nothing, Bartender does not do anything: BitBar
    - Show in Bartender Bar, not in Menu Bar: everything else
    - Airport (wifi)
      - Item Updates
        - [x] Show item in menu bar
          - for: 5 Seconds
  - General
    - [x] Launch Bartender at Login
    - Clicking on Bartender will (Display Bartender Bar items in menu bar)
  - Appearance
    - Gap at right of menu bar: Insert a gap when Notification Center is hidden (off)
  - Command + drap  the bartender icon all the way to the right, BitBar, wifi, then volume
- iTerm 2
  1. Download [nova.itermcolors](https://raw.githubusercontent.com/trevordmiller/nova-iterm/master/build/nova.itermcolors)
  1. Profiles -> Colors -> Color Presets -> Import
  1. Select "nova.itermcolors"
- System Preferences
  - General
    - Default web browser: Google Chrome.app
  - Mission Control
    - [ ] Automatically rearrange Spaces based on most recent use
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
      - [x] Bartender 2
      - [x] Flux
      - [x] iTunesHelper
      - [x] Box Sync
      - [x] Flycut
      - [x] Dropbox
      - [x] RescueTime
      - [x] Fitbit
  - Accessibility
    - [x] Use scroll gesture with modifier keys to zoom:
      - Control
- Finder
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

## Other Settings

### Mutt

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
gpg -r aharris88@gmail.com -e ~/.my-pwds
srm ~/.my-pwds
```

### SSH Config

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

### Work vimrc

Create `~/.workvimrc`

Put something like this in it to make `:Gbrowse` from vim-fugitive work.

```
let g:fugitive_github_domains = ['git@workgithub.com']
```

### .local.zshrc

Put something like this in `.local.zshrc`

```
alias ge="git config --global user.email 'aharris88@users.noreply.github.com'"
```

### Pianobar

Create `~/.my-pandora-pwd` that contains password.

### Other

- Outlook
- Tweetdeck

## Todo

- [ ] Scripts - [Change update script](https://github.com/trevordmiller/settings/commit/ade02137d090ad02aea47e7bdb48d21966bdce93)
- [ ] Ergodox - Add super key
- [ ] Ergodox - Figure how to control mouse with ergodox
- [ ] Keyboard Maestro - Use superkey for moving windows
- [ ] Keyboard Maestro - Make key binding to move windows between screens
- [ ] Surfingkeys - Add instructions for Surfingkeys and config file
- [ ] Surfingkeys - Learn Surfingkeys
- [ ] Vim - Add config for Wakatime (`~/.wakatime.cfg`)
- [ ] Npm - Add config for npm (.npmrc)
- [ ] Sublime Text - add settings and add this to `.macos`
    `cp -r ~/settings/sublime/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text*/Packages/User/Preferences.sublime-settings 2> /dev/null`
- [ ] Vim - add essential.vim for very basic settings
- [ ] Vim - Figure out why javascript autocomplete sometimes knows built-in js functions and sometimes it doesn't
- [ ] Scripts - Make script to set computer to more normal settings
- [ ] Scripts - Make script to get started for work
- [ ] Scripts - Make script for taking a break
- [ ] Vim - Try out [ale for neovim linting](https://github.com/w0rp/ale)
- [ ] Vim - Make sure JsBeautify still works
- [ ] Install audiobookbinder
- [ ] Install transmit
- [ ] Install Xcode
- [ ] Install steam
- [ ] Install Final Cut Pro
- [ ] Uninstall Evernote
