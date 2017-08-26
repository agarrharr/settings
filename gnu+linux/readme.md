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

### Install Other Software

- [Android Studio](https://developer.android.com/studio/index.html)
  - Download
  - `sudo unzip android-studio-ide-141.2178183-linux.zip -d /opt`
  - Create `~/.local/share/applications/androidstudio.desktop` with the following
    ```
    [Desktop Entry]
    Version=1.0
    Type=Application
    Name=Android Studio
    Exec="/opt/android-studio/bin/studio.sh" %f
    Icon=/opt/android-studio/bin/studio.png
    Categories=Development;IDE;
    Terminal=false
    StartupNotify=true
    StartupWMClass=android-studio
    ```
   - Open Android Studio and install the Android SDK
- [Chrome](https://www.google.com/chrome/)
- [Dropbox](https://www.dropbox.com/)
- [Expo XDE](https://expo.io/)
- [Skype](https://www.skype.com/en/)
- [TikzEdit](http://www.tikzedt.org/)

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

- Brave
  - Settings
    - Search
      - [x] DuckDuckGo
- Files
  - Move Dropbox to bookmarks
- Firefox
  - Preferences (about:preferences)
    - Search
      - Default Search Engine: DuckDuckGo
    - New Tab Controls
      - [x] Show blank page
  - Add-ons (about:addons)
    - Extensions
      - [Custom Tab Width](https://addons.mozilla.org/en-US/firefox/addon/custom-tab-width/)
        - Preferences
          - min: 30
- Terminal
  - Profiles
    - Edit
      - Command
        - [x] Run command as a login shell ([This is so that rvm works](https://github.com/rvm/ubuntu_rvm)
- Tweak Tool
  - Typing
    - Ctrl key position: Caps Lock as Ctrl
- VLC
  - Tools
    - Effects and Filters
      - Audio effects
        - Spatializer
          - [x] Enable

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
