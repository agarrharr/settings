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

### System Settings

- Displays
  - Scale for menu and title bars: 1.12
- Mouse & Touchpad
  - [x] Natural scrolling

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
    - Ctrl key position: Swap Ctrl and Caps Lock


#### .local.zshrc

Put something like this in `~/.gitconfig.local`

```
[user]
	email = aharris88@users.noreply.github.com
	name = Adam Harris
```
