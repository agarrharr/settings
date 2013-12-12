# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="mh"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ll='ls -lahG'
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ~='cd ~'
#alias mysql='/usr/local/mysql/bin/mysql'
alias gitstat='git status'
alias gitgraph='git log --graph --oneline --decorate --all'
#alias phpunit='vendor/phpunit/phpunit/composer/bin/phpunit'
#alias sasswatch='sass --watch -r sass-media_query_combiner'
alias adb='adb forward tcp:9222 localabstract:chrome_devtools_remote'
alias cake='lib/Cake/Console/cake'
alias subl='sublime'
alias geeknote='python ~/geeknote/geeknote.py'
alias ttytter='perl ~/ttytter/ttytter.pl'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

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

# Customize to your needs...
PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH"
#path to node
PATH="$PATH:/usr/local/lib/node_modules"
#path to gem installed libraries
PATH="$PATH:/usr/local/opt/ruby/bin"
#path to trigger.io toolkit
#PATH="$PATH:/Applications/TriggerToolkit.app/Contents/MacOS"
#Android SDK
PATH="$PATH:/Users/aharris88/adt/sdk/platform-tools:/Users/aharris88/adt/sdk/tools"
#Kdiff3
PATH="$PATH:/Applications/kdiff3.app/Contents/MacOS"

export PATH
