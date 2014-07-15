# Path to oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="mh"
DEFAULT_USER=aharris88

# Aliases
alias ll='ls -la'
alias ..='cd ..'
alias ~='cd ~'
alias gitgraph='git log --graph --oneline --decorate --all'
alias geeknote='python ~/geeknote/geeknote.py'
alias ttytter='perl ~/ttytter/ttytter.pl'
alias bower='noglob bower' #Only needed for prezto or oh-my-zsh
# Command for pianobar
alias p='~/.config/pianobar/fifoCommands.sh'
alias playing='~/.config/pianobar/showCurrentSongNotification.rb'
# Command for Chrome
alias chrome='open -a Google\ Chrome'
# Command for timetrap
alias td='t d -f day'

alias reload="echo 'reload help:\n\r\n\rreloadzsh: reload zsh\n\rreloadtmux: reload tmux'"
alias reloadzsh=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias reloadtmux="source-file ~/.tmux.conf && echo 'tmux config reloaded from ~/.tmux.conf'"

# Turn on 255 Color
set -g default-terminal "screen-256color"

# Disable command autocorrection
DISABLE_CORRECTION="true"

# Enable autocompletion
autoload -U compinit
compinit

# Autocompletion for timetrap
fpath=(~/.rvm/gems/ruby-2.0.0-p353/gems/timetrap-1.8.12/completions/zsh $fpath)
# Autocompletion for tmuxinator
source ~/.tmuxinator/
source ~/.rvm/gems/ruby-2.0.0-p353/gems/tmuxinator-0.6.6/completion/tmuxinator.zsh

# Display dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Increase ulimit (soft limit)
# When I ran npm update..., I was getting this error: EMFILE, too many open files
ulimit -n 1024

# Plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Powerline
source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

# RVM
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

# Path
PATH="/opt/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH"
#path to node
PATH="$PATH:/usr/local/lib/node_modules"
#path to gem installed libraries
PATH="$PATH:/usr/local/opt/ruby/bin"
PATH="$PATH:/Library/Ruby/Gems/2.0.0/gems"
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

PATH=$PATH:$HOME/.rvm/gems/ruby-2.1.2/bin # Add RVM to PATH for scripting
#Android SDK
PATH="$PATH:/Users/aharris88/adt/sdk/platform-tools:/Users/aharris88/adt/sdk/tools"
#Android NDK
PATH="$PATH:/Users/aharris88/adt/ndk/platform-tools"

export PATH

export EDITOR=vim
export PAGER=less
export LC_ALL=$LANG
# Change less to ignore case, show colors, and change the less prompt to show file name (file number / how many files) Line line number/total lines in the file
export LESS='-iR-P%f (%i/%m) Line %lt/%L'
# Display window names correctly in tmux
export DISABLE_AUTO_TITLE=true

[ -s "/Users/aharris88/.nvm/nvm.sh" ] && . "/Users/aharris88/.nvm/nvm.sh" # This loads nvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
