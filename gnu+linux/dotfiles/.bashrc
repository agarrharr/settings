# Use vim keybindings
set -o vi

source $HOME/.bashrc.local

export TERM=xterm-256color

#==================================================
# Aliases
#==================================================

alias reload="echo 'reload help:\n\r\n\rreload sh: reloadsh\n\rreload tmux: prefix r\n\rreload vim: <leader>vs'"
alias reloadsh=". ~/.bashrc && echo 'BASH config reloaded from ~/.bashrc'"

alias lsa="ls -la"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

function take() {
  mkdir $1
  cd $1
}

#==================================================
# Path
#==================================================

export N_PREFIX="${HOME}/.node_versions"

NPM_PACKAGES_PATH="${HOME}/.npm-packages"
export PATH="$NPM_PACKAGES_PATH/bin:$PATH"

