function! StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
command! -nargs=0 StripTrailingWhitespaces call StripTrailingWhitespaces()

" Highlight all instances of word under cursor
" It doesn't clobber the search register
function! HighlightWordUnderCursor()
    if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]'
        exec 'match' 'Search' '/\V\<'.expand('<cword>').'\>/'
    else
        match none
    endif
endfunction
command! -nargs=0 HighlightWordUnderCursor call HighlightWordUnderCursor()

function! ShowOnGithub()
  let u = system("echo ${${${$(git --git-dir=.git config --get remote.origin.url)#git@github.com:}%.git}#https://github.com/} | xargs echo -n")
  silent exec "!open "."https://github.com/".u."/blob/master/".@%.'\#L'.line(".")
endfunction
command! -nargs=0 ShowOnGithub call ShowOnGithub()

nnoremap <Leader>gh :ShowOnGithub<CR>

function! PrintCurrentBranch()
  exec ":.-1read!git rev-parse --abbrev-ref HEAD"
  :execute "normal! A: "
  startinsert!
endfunction
command! -nargs=0 PrintCurrentBranch call PrintCurrentBranch()
