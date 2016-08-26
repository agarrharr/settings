call plug#begin('~/.nvim/plugged')

" Code linter
function! Installjshint(info)
  if a:info.status == 'installed' || a:info.force
    !npm install -g eslint
  endif
endfunction
Plug 'scrooloose/syntastic', { 'do': function('Installjshint') }
" Commenter
Plug 'tpope/vim-commentary'
" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
function! BuildTern(info)
  if a:info.status == 'installed' || a:info.force
    !npm install -g tern
  endif
endfunction
Plug 'carlitux/deoplete-ternjs', { 'do': function('BuildTern') }
" markdown preview
function! InstallInstantMarkdown(info)
  if a:info.status == 'installed' || a:info.force
    !npm -g install instant-markdown-d
  endif
endfunction
Plug 'suan/vim-instant-markdown', { 'do': function('InstallInstantMarkdown') }
" Expands abbreviations similar to emmet
Plug 'mattn/emmet-vim'
" Fuzzy searching for opening files
Plug 'ctrlpvim/ctrlp.vim'
" JavaScript Beautifier (also html and css)
Plug 'maksimr/vim-jsbeautify'
" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'
" Closes html/xml tags after typing </
Plug 'docunext/closetag.vim'
" Git commands inside vim
Plug 'tpope/vim-fugitive'
" Automatic indentation
Plug 'tpope/vim-sleuth'
" Show the indentation with vertical lines
Plug 'Yggdroot/indentLine'
" Detect the indentation automatically
Plug 'ciaranm/detectindent'
" Show a git diff n the gutter
Plug 'airblade/vim-gitgutter'
" Change the background of css colors to match
Plug 'ap/vim-css-color'
" When searching show 'At match #N out of M matches'
Plug 'vim-scripts/IndexedSearch'
" Plugin to move lines
Plug 'matze/vim-move'
" Multiple Cursors
Plug 'terryma/vim-multiple-cursors'
" Repeat with . after plugin maps
Plug 'tpope/vim-repeat'
" Syntax for jekyll markdown with front matter
Plug 'PProvost/vim-markdown-jekyll'
" Add JavaScript console.log
Plug 'aharris88/consolation-vim'
" Track time spent coding
Plug 'wakatime/vim-wakatime'
" enhances netrw
Plug 'tpope/vim-vinegar'
" Distraction-free writing
Plug 'junegunn/goyo.vim'
" Search
Plug 'mileszs/ack.vim'
" Scratchpad
Plug 'metakirby5/codi.vim'
" Helps you open the right file
Plug 'EinfachToll/DidYouMean'

call plug#end()

