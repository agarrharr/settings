DEFAULT_USER=adamharris

# Aliases
alias git='hub'

alias vi='vim -u ~/.vim/essential.vim'

alias reload="echo 'reload help:\n\r\n\rreloadzsh: reload zsh\n\rreloadtmux: reload tmux'"
alias reloadzsh=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias reloadtmux="source-file ~/.tmux.conf && echo 'tmux config reloaded from ~/.tmux.conf'"

alias lsa="ls -la"
alias -- -="cd -"
alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
function take() {
    mkdir $1
    cd $1
}

alias ga="git add"
alias gc="git commit --verbose"
alias gcm="git checkout master"
alias gco="git checkout"
alias gd="git diff"
alias gl="git pull"
alias glg="git log --stat --max-count=10"
alias gp="git push"
alias gst="git status"

# Turn on 255 Color
set -g default-terminal "screen-256color"

# Turn on interactive comments
setopt interactivecomments

# Disable command autocorrection
DISABLE_CORRECTION="true"

DISABLE_AUTO_TITLE=true

# Enable autocompletion
autoload -U compinit
compinit

# Make autocompletion case-insensitive and fuzzy (mid-word completion)
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  '+l:|?=** r:|?=**'

# Use emacs keybindings
bindkey -e

# Enable history search with arrow keys and ctrl+p and ctrl+n
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# History
if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=10000
SAVEHIST=10000

# Show history
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data
# End History

# Autocompletion for timetrap
fpath=(~/.rvm/gems/ruby-2.1.5/gems/timetrap-1.8.14/completions/zsh $fpath)

# Display dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

setopt APPEND_HISTORY

# prompt
autoload -U promptinit && promptinit
prompt pure

source $HOME/dotfiles/bin/zshCustomFunctions.sh

# rvm
source ~/.nvm/nvm.sh

# include Z, yo
. `brew --prefix`/etc/profile.d/z.sh

# Path
PATH="/opt/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$HOME/bin:$PATH"
# Ruby
PATH="$PATH:/usr/local/opt/ruby/bin:/Library/Ruby/Gems/2.0.0/gems"
# RVM
PATH="$PATH:$HOME/.rvm/gems/ruby-2.1.5/bin:$HOME/.rvm/bin"

# Play Framework
PATH="$PATH:/Applications/play-1.2.7.2"

# dotfiles bin
PATH="$PATH:$HOME/dotfiles/bin"

export PATH

export EDITOR=nvim
export PAGER=less
export LC_ALL=$LANG

# Change less to ignore case, show colors, and change the less prompt to show file name (file number / how many files) Line line number/total lines in the file
export LESS='-iR-P%f (%i/%m) Line %lt/%L'

source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
