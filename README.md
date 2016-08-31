# Notes on updating to macOS Sierra

- [ ] Karabiner - [does not work yet](https://pqrs.org/osx/karabiner/)
- [ ] Seil - [does not work yet](https://pqrs.org/osx/karabiner/seil.html.en)
- [ ] Bartender 2 - [test build for macOS Sierra](https://www.macbartender.com/blog/macOS%20Sierra%20Test%20Build/)
- [ ] iStat Menus
- [x] Screenflow
- [ ] Creative Cloud
- [ ] Box Sync
- [ ] Karabiner
- [ ] Outlook

# Settings

This repository includes all of my custom settings and dotfiles. They have been generalized as much as possible for use by other people, but they are mostly just for my personal use.

I also prefer `zsh` instead of `bash`, so the setup script will check to see if `zsh` is installed.  If `zsh` is installed, and it is not already configured as the default shell, the setup script will execute a `chsh -s $(which zsh)`.  This changes the default shell to zsh, and takes effect as soon as a new zsh is spawned or on next login.

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

Download files

``` bash
cd ~ && curl -LO https://github.com/aharris88/settings/archive/master.zip && unzip master.zip &&  mv settings-master settings && rm master.zip
```

Run Install script

```bash
./settings/scripts/install.sh
```

Add SSH key to Github on the [ssh settings page](https://github.com/settings/ssh).

```bash
ssh-keygen -t rsa -b 4096 -C "your.email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
pbcopy < ~/.ssh/id_rsa.pub
```

Add git remote to settings directory

```bash
git init && git add . && git remote add origin git@github.com:aharris88/settings.git && git remote update && git checkout master
```

## App Settings

### Karabiner

I remap my keys so that the caps lock key is control and control is caps lock, but it's only control if you press it in combination with another key, otherwise it's escape. And then my enter/return key is control if pressed in combination, otherwise it's enter.

To do this go to System Preferences -> Keyboard -> Modifier Keys... -> and switch Caps Lock and Control.

Open Karabiner

Control_L to Control_L (+ When you type Control_L only, send Escape)

Return to Control_L (+ When you type Return only, send Return) + [KeyRepeat]

### iTerm

This fixes the problem with [Ctrl+h not working in neovim](https://github.com/neovim/neovim/issues/2048)

1. Preferences -> Keys
1. Add a new Key Mapping by typing Ctrl+h
1. Choose "Send Escape Sequence" for the Action
1. Type "[104;5u" for Esc+

### Chrome

- Set Chrome to default browser
- Sign in
- Chrome menu -> "Warn Before Quitting (⌘Q)"
- Sign in to LastPass
- Configure One Number

### Dropbox

Sign in

### Evernote

Sign in

### YNAB

- Put in activation key
- Point to budget file on Dropbox

### Notational Velocity

- Preferences -> Notes -> Storage -> Store and read notes on disk as: Plain Text Files *
- Notes -> Read notes from: ~/Dropbox/notes

### iStat Menus

- Show time and battery
- Use fuzzy clock
- Use the green battery and customize the colors to be red when low, else black and turn on “Customize menubar for different states”

### Bartender

- Enable hiding Spotlight with Bartender (https://www.macbartender.com/B2/system-item-setup/)
- Menu Items
  - Completely Hide Menu Bar Item: User, Battery, Clock, Spotlight, Notification Center
  - Nothing, Bartender does not do anything: iStat Menus Status
  - Show in Bartender Bar, not in Menu Bar: everything else
- Airport (wifi): Item Updates: Show item in menu bar
- General
  - Clicking on Bartender will: Display all items in Menu Bar
  - Startup: Launch Bartender at Login
  - Clicking on Bartender will: Display Bartender Bar items in menu bar
- Appearance
  - Turn off Insert a gap when Notification Center is hidden
- Move iStat Menus Status all the way to the right, then wifi, then volume

## Other stuff

### iCloud

- Sign into iCloud.
- Turn off "Use iCloud for mail, contacts, calendars, reminders, notes, and Safari"
- Turn on "Use Find My Mac"

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

### Fix sudo vulnerability

[Fix sudo vulnerability](http://blog.rongarret.info/2015/08/psa-beware-of-sudo-on-os-x.html)
```
sudo visudo
```

and add this line

```
Defaults tty_tickets
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

### Pianobar

Create `~/.my-pandora-pwd` that contains password.


## Todo

- [ ] Add instructions to create `~/.bin/zshCustomFunctions.sh`
- [ ] Add Sublime Text settings and add this to .macos
    `cp -r ~/settings/sublime/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text*/Packages/User/Preferences.sublime-settings 2> /dev/null`
- [ ] Add colors to scripts (`install.sh` and `update.sh`)
- [ ] Add Surfingkeys instructions and config file
- [ ] Setup Better Window Manager
- [ ] Make script to create `~/Development` directory
- [ ] Add Karabiner file
- [ ] Run `.macos` file in `install.sh`
- [ ] Install Anki
- [ ] Add `clean.sh` to clear trash and downloads
- [ ] Wakatime (`~/.wakatime.cfg`)
- [ ] Add this stuff to `.macos` file
    - Move Applications folder into the Dock FO
    - Display Applications and Downloads as Folder instead of Stack
    - Finder - Remove AirDrop, All My Files, iCloud Drive, Applications, Downloads, Documents, Desktop. It should only have Dropbox and Development
    - Finder - Hide Tags, and Shared
    - Don't light up keyboard
    - Set screensaver
