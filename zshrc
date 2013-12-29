# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="mh"

# Example aliases
alias ll='ls -la'
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ~='cd ~'
alias gitgraph='git log --graph --oneline --decorate --all'
alias adb='adb forward tcp:9222 localabstract:chrome_devtools_remote'
alias subl='sublime'
alias geeknote='python ~/geeknote/geeknote.py'
alias ttytter='perl ~/ttytter/ttytter.pl'
# alias macvim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias bower='noglob bower' #Only needed for prezto or oh-my-zsh

# Turn on 255 Color
set -g default-terminal "screen-256color"

# Disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# RVM
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

# Customize to your needs...
PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH"
#path to node
PATH="$PATH:/usr/local/lib/node_modules"
#path to gem installed libraries
PATH="$PATH:/usr/local/opt/ruby/bin"
PATH="$PATH:/Library/Ruby/Gems/2.0.0/gems/"
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#Android SDK
PATH="$PATH:/Users/aharris88/adt/sdk/platform-tools:/Users/aharris88/adt/sdk/tools"
#Kdiff3
PATH="$PATH:/Applications/kdiff3.app/Contents/MacOS"

export PATH
