# Settings

This directory includes all of my custom settings and dotfiles for GNU+Linux.

I am currently using Ubuntu 16.04.2 LTS.

The `scripts/install.sh` script will:

1. Install packages
1. Create symlinks to the dotfiles in `~/settings/dotfiles/` in your home directory and backup old dotfiles to `~/.OLD_DOTFILES`

## Manual Settings

### Install Vim 8

```bash
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim
```

### Install Skype

- Download and install from website.
- Need to find free software alternative

### Install Dropbox

- Download and install from website.
- Move to bookmarks in Files
- Need to find free software alternative

### System Settings

- Displays
  - Scale for menu and title bars: 1.12
- Mouse & Touchpad
  - [ ] Tap to click
  - [x] Natural scrolling
- Time & Date
  - Clock
    - [x] 24-hour time

### Other Programs

- Firefox
  - Search
    - Default Search Engine: DuckDuckGo
  - New Tab Controls
    - [x] Show blank page
- Terminal
  - Profiles
    - Edit
      - Command
        - [x] Run command as a login shell ([This is so that rvm works](https://github.com/rvm/ubuntu_rvm)
- Tweak Tool
  - Typing
    - Ctrl key position: Caps Lock as Ctrl


#### .local.zshrc

Put something like this in `~/.gitconfig.local`

```
[user]
	email = aharris88@users.noreply.github.com
	name = Adam Harris
```
