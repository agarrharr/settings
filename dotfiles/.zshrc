# ==================================================================
# General
# ==================================================================

DEFAULT_USER=adamharris

# Use emacs keybindings
bindkey -e

# Turn on 256 Color
set -g default-terminal "screen-256color"

# Turn on interactive comments
setopt interactivecomments

DISABLE_AUTO_TITLE=true

setopt APPEND_HISTORY

source $HOME/.bin/zshCustomFunctions.sh

# include Z, yo
. `brew --prefix`/etc/profile.d/z.sh

export LC_ALL=$LANG

# Type ".." instead of "cd ..", "/usr/include" instead of "cd /usr/include".
setopt auto_cd

# ==================================================================
# Path
# ==================================================================

RUBY_PATH="/usr/local/opt/ruby/bin:/Library/Ruby/Gems/2.0.0/gems"
RVM_PATH="$HOME/.rvm/gems/ruby-2.1.5/bin:$HOME/.rvm/bin"
PLAY_PATH="/Applications/play-1.2.7.2"
export PATH="$PATH:$RUBY_PATH:$RVM_PATH:$PLAY_PATH"

# ==================================================================
# Prompt
# ==================================================================

# https://github.com/sindresorhus/pure/issues/116
fpath+=("/usr/local/share/zsh/site-functions")
autoload -U promptinit && promptinit
prompt pure

# ==================================================================
# Aliases
# ==================================================================

alias git='hub'

alias vi='vim -u ~/.vim/essential.vim'

alias reload="echo 'reload help:\n\r\n\rreloadzsh: reload zsh\n\rreloadtmux: reload tmux'"
alias reloadzsh=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias reloadtmux="source-file ~/.tmux.conf && echo 'tmux config reloaded from ~/.tmux.conf'"

alias lsa="ls -la"
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

# ==================================================================
# History
# ==================================================================

# Enable history search with arrow keys and ctrl+p and ctrl+n
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey '\e[A' history-beginning-search-backward-end
bindkey '\e[B' history-beginning-search-forward-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end

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

# ==================================================================
# Editor
# ==================================================================

export EDITOR=nvim

# ==================================================================
# Pager
# ==================================================================

export PAGER=less

# Change less to ignore case, show colors, and change the less prompt to show file name (file number / how many files) Line line number/total lines in the file
export LESS='-iR-P%f (%i/%m) Line %lt/%L'


# ==================================================================
# Autocompletion
# ==================================================================

# Enable autocompletion
autoload -U compinit
compinit

# Make autocompletion case-insensitive and fuzzy (mid-word completion)
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  '+l:|?=** r:|?=**'

# Autocompletion for timetrap
fpath=(~/.rvm/gems/ruby-2.1.5/gems/timetrap-1.8.14/completions/zsh $fpath)

# Display dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Disable command autocorrection
DISABLE_CORRECTION="true"

source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
