# Settings

This repository includes all of my custom settings and dotfiles. They have been generalized as much as possible for use by other people, but they are mostly just for my personal use.

I also prefer `zsh` as my shell of choice.  As such, the setup script will check to see if `zsh` is installed.  If `zsh` is installed, and it is not already configured as the default shell, the setup script will execute a `chsh -s $(which zsh)`.  This changes the default shell to zsh, and takes effect as soon as a new zsh is spawned or on next login.

So, to recap, the install script will:

1. Install zsh and set it as the default shell
1. Install Homebrew
1. Install Homebrew packages
1. Install npm
1. Install npm packages
1. Create symlinks to the dotfiles in `~/settings/dotfiles/` in your home directory
1. Install neovim plugins
1. Install gui apps with Homebrew Cask

## Installation

### Download files
``` bash
curl -LO https://github.com/aharris88/settings/archive/master.zip
unzip master.zip
mv settings-master settings
rm master.zip
```

### Run Install script

```bash
./settings/scripts/install.sh
```

### Add SSH key to Github

Accept the default file (~/.ssh/id_rsa) and enter a passphrase.

```bash
ssh-keygen -t rsa -b 4096 -C "your.email.address@example.com"
```

Ensure ssh-agent is enabled.

```bash
eval "$(ssh-agent -s)"
```

Add your SSH key to the ssh-agent.

```bash
ssh-add ~/.ssh/id_rsa
```

Copy the ssh key to your clipboard.

```bash
pbcopy < ~/.ssh/id_rsa.pub
```

Add new SSH key to github on the [ssh settings page](https://github.com/settings/ssh).

### Add git remote to settings directory

```bash
git init
git add .
git remote add origin git@github.com:aharris88/settings.git
git remote update
```

Enter your password for the SSH key "id_rsa". And check "Remember password in my keychain".

```bash
git checkout master
```

## Keyboard Settings

I remap my keys so that the caps lock key is control and control is caps lock, but it's only control if you press it in combination with another key, otherwise it's escape. And then my enter/return key is control if pressed in combination, otherwise it's enter.

To do this go to System Preferences -> Keyboarda -> Modifier Keys... -> and switch Caps Lock and Control.

Then install [Karabiner](https://github.com/tekezo/Karabiner). And turn on these settings:

Control-L to Control_L (+ When you type Control_L only, send Escape)

Return to Control_L (+ When you type Return only, send Return) + [KeyRepeat]

## Other stuff

### Fix sudo vulnerability

[Fix sudo vulnerability](http://blog.rongarret.info/2015/08/psa-beware-of-sudo-on-os-x.html)
```
sudo visudo
```

and add this line

```
Defaults tty_tickets
```

### iTerm

This fixes the problem with [Ctrl+h not working in neovim](https://github.com/neovim/neovim/issues/2048)

1. Preferences -> Keys
1. Add a new Key Mapping by typing Ctrl+h
1. Choose "Send Escape Sequence" for the Action
1. Type "[104;5u" for Esc+
