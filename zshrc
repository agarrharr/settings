# Path to oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="mh"
DEFAULT_USER=adamharris

# Aliases
alias fch='open -na "Google Chrome" --args "--user-data-dir=$HOME/.fresh-chrome" --enable-precise-memory-info --js-flags="--nocrankshaft --nouse-ic --expose-gc"'

alias geeknote='python ~/geeknote/geeknote.py'
alias ttytter='perl ~/ttytter/ttytter.pl'
alias bower='noglob bower' #Only needed for prezto or oh-my-zsh
# Command for pianobar
alias pandora='pianobar'
alias p='~/.config/pianobar/fifoCommands.sh'
alias playing='ruby ~/.config/pianobar/showCurrentSongNotification.rb --notification'
# Command for timetrap
alias td='t d -f day'
# The Fuck (https://github.com/nvbn/thefuck)
alias doh='eval $(thefuck $(fc -ln -1))'
# trash-cli
alias tr='trash'
# hub
alias git='hub'

alias vi='vim -u ~/.vim/essential.vim'

alias reload="echo 'reload help:\n\r\n\rreloadzsh: reload zsh\n\rreloadtmux: reload tmux'"
alias reloadzsh=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias reloadtmux="source-file ~/.tmux.conf && echo 'tmux config reloaded from ~/.tmux.conf'"

# Turn on 255 Color
set -g default-terminal "screen-256color"

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Turn on interactive comments
setopt interactivecomments

# Disable command autocorrection
DISABLE_CORRECTION="true"

DISABLE_AUTO_TITLE=true

# Enable autocompletion
autoload -U compinit
compinit

# Autocompletion for timetrap
fpath=(~/.rvm/gems/ruby-2.1.5/gems/timetrap-1.8.14/completions/zsh $fpath)
# Autocompletion for tmuxinator
source ~/.bin/tmuxinator.zsh

# Display dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Increase ulimit (soft limit)
# When I ran npm update..., I was getting this error: EMFILE, too many open files
ulimit -n 1024

setopt APPEND_HISTORY

# Plugins
plugins=(bower brew git github gitignore node npm osx pip rvm themes tmux z)

source $ZSH/oh-my-zsh.sh

source $HOME/dotfiles/bin/zshCustomFunctions.sh

# rvm
source ~/.nvm/nvm.sh

# include Z, yo
. `brew --prefix`/etc/profile.d/z.sh

# Path
PATH="/opt/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$HOME/bin:$PATH"
#path to gem installed libraries
PATH="$PATH:/usr/local/opt/ruby/bin"
PATH="$PATH:/Library/Ruby/Gems/2.0.0/gems"
# RVM
PATH="$PATH:$HOME/.rvm/gems/ruby-2.1.5/bin"

#Android SDK
PATH="$PATH:/Library/Android/sdk/platform-tools"
PATH="$PATH:/Library/Android/sdk/tools"
export STUDIO_JDK=/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk
export ANDROID_HOME=/Library/Android/sdk

# Go
export GOPATH=$HOME/Go/
PATH="$PATH:/usr/local/go:/usr/local/go/bin"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$HOME/Go/src:/Go/src/code.google.com/p/portaudio-go

# imgcat
PATH="$PATH:$HOME/dotfiles/bin"

export PATH
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export EDITOR=nvim
export PAGER=less
export LC_ALL=$LANG

# Change less to ignore case, show colors, and change the less prompt to show file name (file number / how many files) Line line number/total lines in the file
export LESS='-iR-P%f (%i/%m) Line %lt/%L'
# Display window names correctly in tmux
export DISABLE_AUTO_TITLE=true

