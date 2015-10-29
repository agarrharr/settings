function getSHA() {
    git log -1 --pretty=format:%H | pbcopy
    echo "Latest SHA1 has been copied to the clipboard"
}
