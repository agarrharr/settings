# ==================================================================
# General
# ==================================================================

DEFAULT_USER=`whoami`

# Use emacs keybindings
bindkey -v
bindkey -M vicmd v edit-command-line
autoload edit-command-line; zle -N edit-command-line

# Turn on 256 Color
set -g default-terminal "screen-256color"

DISABLE_AUTO_TITLE=true

setopt APPEND_HISTORY

source $HOME/bin/zshCustomFunctions.sh
source $HOME/.local.zshrc

# include Z, yo
. `brew --prefix`/etc/profile.d/z.sh

export LC_ALL=$LANG

# Type ".." instead of "cd ..", "/usr/include" instead of "cd /usr/include".
setopt auto_cd

# NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# ==================================================================
# Path
# ==================================================================

NPM_PACKAGES="${HOME}/.npm-global/bin"
RUBY_PATH="/usr/local/opt/ruby/bin:/Library/Ruby/Gems/2.0.0/gems"
PYTHON_PATH="$HOME/Library/Python/2.7/bin"
POSTGRES_PATH="/Applications/Postgres.app/Contents/Versions/9.6/bin"
PROJECT_NPM_PATH="./node_modules/.bin"
YARN_PATH="$HOME/.yarn/bin"
export ANDROID_HOME="$HOME/Library/Android/sdk"
ANDROID_PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
LOCAL_PATH="$HOME/bin"
LOCAL_SCRIPTS="$HOME/.config/scripts"
export PATH="$NPM_PACKAGES:$RUBY_PATH:$PYTHON_PATH:$POSTGRES_PATH:$PROJECT_NPM_PATH:$YARN_PATH:$ANDROID_PATH:$LOCAL_PATH:$LOCAL_SCRIPTS:$PATH"

# ==================================================================
# Prompt
# ==================================================================

# https://github.com/sindresorhus/pure/issues/116
fpath+=("/usr/local/share/zsh/site-functions")
# https://github.com/sindresorhus/pure/issues/116
fpath+=/opt/homebrew/share/zsh/site-functions
autoload -U promptinit; promptinit
prompt pure

# ==================================================================
# Aliases
# ==================================================================

alias vi='vim -u ~/.vim/essential.vim'

alias reload="echo 'reload help:\n\r\n\rreload zsh: reloadzsh\n\rreload tmux: prefix r\n\rreload vim: <leader>vs'"
alias reloadzsh=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

alias lsa="ls -la"
alias ...="cd ../.."
alias ....="cd ../../.."
alias 1="cd -"

function take() {
    mkdir $1
    cd $1
}

alias dc="docker-compose"

alias ga="gitAddStatus"
alias gc="git commit --verbose"
alias gcm="git checkout main"
alias gco="git checkout"
alias gd="git diff"
alias gl="git pull"
alias glg="git log --stat"
alias gp="git push"
alias gst="git status"
alias gs="git stash save --include-untracked"

gitAddStatus() {
  git add $*
  git status
}

# Autocomplete git branches with fzf
gch() {
 git checkout "$(git branch | fzf| tr -d '[:space:]')"
}

fd() {
  preview="git diff $@ --color=always -- {-1}"
  git diff $@ --name-only | fzf -m --ansi --preview-window=wrap --preview $preview --bind ctrl-d:preview-page-down,ctrl-u:preview-page-up,ctrl-n:preview-down,enter:preview-down,ctrl-p:preview-up,G:preview-bottom,ctrl-g:preview-top
}

# Preview files in current directory with fzf and bat (cat with syntax highlighting)
preview() {
  fzf --preview 'bat --color=always --style=numbers {}' --bind ctrl-d:preview-page-down,ctrl-u:preview-page-up,ctrl-n:preview-down,enter:preview-down,ctrl-p:preview-up,G:preview-bottom,ctrl-g:preview-top
}

# $1 input_image
# $2 width
# $3 output_dir
# https://www.smashingmagazine.com/2015/06/efficient-image-resizing-with-imagemagick/
smartresize() {
   mogrify -path $3 -filter Triangle -define filter:support=2 -thumbnail $2 -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB $1
}

# $1 input_image
# $2 input_mp3
# $3 output_mp4
imageAndAudioToVideo() {
  ffmpeg -loop 1 -i $1 -i $2 -c:v libx264 -tune stillimage -c:a aac -b:a 192k -pix_fmt yuv420p -shortest $3
}

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
# Ruby
# ==================================================================

# eval "$(rbenv init -)"

# ==================================================================
# Autocompletion
# ==================================================================

# Enable autocompletion
autoload -U compinit
compinit

# Make autocompletion case-insensitive and mid-word completion (not fuzzy)
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

bindkey '^i' expand-or-complete-prefix

# Display dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# fzf keyboard shortcut
fzf-file-widget() {
  local output
  output=$(fzf</dev/tty) && LBUFFER+=${(q-)output}
}
zle -N fzf-file-widget
bindkey -M vicmd "^T" fzf-file-widget
bindkey -M viins "^T" fzf-file-widget

# TODO: fix syntax highlighting
# source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH="/usr/local/sbin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
