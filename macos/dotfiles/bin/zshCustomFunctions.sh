function getSHA() {
  git log -1 --pretty=format:%H | pbcopy
  echo "Latest SHA1 has been copied to the clipboard"
}

function base64EncodeSvg() {
  # pass in path to svg file
  echo "background: url('data:image/svg+xml;base64,"$(openssl base64 < $1)"');"
  echo "background: url('data:image/svg+xml;base64,"$(openssl base64 < $1)"');" | pbcopy
}

# note
function note() {
  $EDITOR ~/Dropbox/notes/"$*".txt
}

# note search
function ns() {
  grep "$*" -r ~/Dropbox/notes
}

# note title search
function nts() {
  ls -c ~/Dropbox/notes | grep "$*"
}

function hideAllFiles() {
  defaults write com.apple.finder AppleShowAllFiles -bool NO
  killall Finder
}

function showAllFiles() {
  defaults write com.apple.finder AppleShowAllFiles -bool YES
  killall Finder
}

function stream() {
  youtube-dl -o - "$1" | vlc - 
}

# Steam and download
# Only problem is that it saves it as replay.mp4
# youtube-dl "$1" -o - | tee replay.mp4 | vlc -
