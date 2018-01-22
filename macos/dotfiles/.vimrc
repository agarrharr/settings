" General
" Keys
" Functions
" Plugins

"""""""""""""""""""""""""
" Section: InstallPlugins
"""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

" Autocompletion
function! BuildTern(info)
  if a:info.status == 'installed' || a:info.force
    !npm install -g tern
  endif
endfunction
Plug 'carlitux/deoplete-ternjs', { 'do': function('BuildTern') }
" Formatting and Linting
Plug 'w0rp/ale'
" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Commenter
Plug 'tpope/vim-commentary'
" Fuzzy searching for opening files
Plug 'ctrlpvim/ctrlp.vim'
" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'
" Closes html/xml tags after typing </
Plug 'docunext/closetag.vim'
" Git commands inside vim
Plug 'tpope/vim-fugitive'
" Automatic indentation
Plug 'tpope/vim-sleuth'
" Show a git diff n the gutter
Plug 'airblade/vim-gitgutter'
" Change the background of css colors to match
Plug 'ap/vim-css-color'
" When searching show 'At match #N out of M matches'
Plug 'vim-scripts/IndexedSearch'
" Plugin to move lines
Plug 'matze/vim-move'
" Repeat with . after plugin maps
Plug 'tpope/vim-repeat'
" Syntax for jekyll markdown with front matter
Plug 'PProvost/vim-markdown-jekyll'
" Add JavaScript console.log
Plug 'agarrharr/consolation-vim'
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
" Color theme
Plug 'trevordmiller/nova-vim'
" JavaScript syntax highlighting and indentation
Plug 'pangloss/vim-javascript'
" JavaScript React
Plug 'mxw/vim-jsx'
" Highlight yanked text
Plug 'machakann/vim-highlightedyank'
" Calculate
Plug 'arecarn/vim-crunch'
" Code coverage
Plug 'ruanyl/coverage.vim'
" TypeScript Syntax
Plug 'HerringtonDarkholme/yats.vim'
Plug 'leafgarland/typescript-vim'
Plug 'runoshun/tscompletejob'

call plug#end()

""""""""""""""""""
" Section: General
""""""""""""""""""

set number

let mapleader = "\<Space>"

colorscheme nova

set mouse=a

" Turn on spell checking for commit messages and automatic wrapping at the recommended 72 characters
augroup filetype_gitcommit
  autocmd!
  autocmd Filetype gitcommit setlocal spell textwidth=72
augroup END

" Turn on spell checking for markdown files
augroup filetype_markdown
  autocmd!
  autocmd Filetype markdown setlocal spell
augroup END

" Turn on search highlighting
set hlsearch
set incsearch
set undofile
" Hide undo files in netrw
let g:netrw_list_hide='.*\.un\~$\|.*\.swp$'

" I don't need this (plus there's a possible security problem)
set modelines=0
" Don't add newline to end of file
set fileformats+=dos

set wildignorecase
set wildignore+=*.zip
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.pdf
set wildignore+=*.swp
set wildignore+=*/.git/*
set wildignore+=*DS_Store*
set wildignore+=*/node_modules/*
set wildignore+=npm-debug.log
set wildignore+=.eslintcache
set wildignore+=*/build/*
set wildignore+=*/lib/*
set wildignore+=*/dist/*
set wildignore+=*/vendor/*
set wildignore+=*/compiled/*
set wildignore+=*/cache/*

" Put it into insert mode when entering a terminal pane
autocmd BufWinEnter,WinEnter term://* startinsert

" Setup indicator for 132 columns
set colorcolumn=133

" Set comment style for JavaScript to single line
augroup filetype_js
  autocmd!
  autocmd FileType javascript set commentstring=//\ %s
augroup END

" Helps gf know how to open JavaScript files
set path+=**
set suffixesadd+=.js

" Copy to system clipboard when you yank/copy
set clipboard=unnamed

" Close the Omni-Completion tip window when a selection is made
" These lines close it on movement in insert mode or when leaving insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Invisible Characters
" Shortcut to toggle invisible characters
" Use the same symbols as TextMate for tabstops and EOLs
:set list listchars=tab:\ \ ,trail:-
nnoremap <leader>i :set list<CR>:set listchars=tab:▸\ ,eol:¬<CR>
nnoremap <leader>io :set list<CR>:set listchars=tab:\ \ ,trail:-<CR>
" Change color to gray
highlight NonText ctermfg=7 guifg=gray
" Show this character when the line wraps
set showbreak=↪\ " Note the trailing space (escaped with a backslash) because this character is wider than 1 normal character

" Fixes issue with highlighting current word being too slow
set updatetime=100

" Fixes issue I had with json files hiding quotes
setlocal conceallevel=0

"""""""""""""""
" Section: Keys
"""""""""""""""

" Mappings to open config files
nnoremap <leader>ev :tabnew $MYVIMRC<cr>
nnoremap <leader>et :tabnew ~/.tmux.conf<cr>
nnoremap <leader>ez :tabnew ~/.zshrc<cr>
nnoremap <leader>em :tabnew ~/.muttrc<cr>
nnoremap <leader>eg :tabnew ~/.gitconfig<cr>

nnoremap <leader>vs :source $MYVIMRC<cr>

" Mappings for moving around panes
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Mappings for movement in insert mode
inoremap <C-h> <Esc><C-w>h
inoremap <C-j> <Esc><C-w>j
inoremap <C-k> <Esc><C-w>k
inoremap <C-l> <Esc><C-w>l


nnoremap <silent> <Leader>, :exe "vertical resize +10"<CR>
nnoremap <silent> <Leader>. :exe "vertical resize -10"<CR>

" Movement commands for :terminal windows
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Mapping for opening splits and moving into it
nnoremap <leader>sv <C-w>v<C-w>l
nnoremap <leader>ss <C-w>s<C-w>j

" Quit terminal mode with escape key
tnoremap <Esc> <C-\><C-n>

" Make Y yank to the end of the line instead of the entire line (i.e. same as yy).
noremap Y y$

" Set mappings for relative line numbering
nnoremap <leader>lr :set relativenumber<CR>
nnoremap <leader>ll :set norelativenumber<CR>

" Timetrap
nnoremap <leader>tt :!t w<CR>
nnoremap <leader>ti :!t in<CR>
nnoremap <leader>to :!t out<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings for Functions
""""""""""""""""""""""""""""""""""""""""""""""""""

" Print current git branch
nnoremap <leader>b :PrintCurrentBranch<CR>

" Highlight the word under the cursor
nnoremap <leader>h :HighlightWordUnderCursor<CR>

nnoremap <Leader>gh :ShowOnGithub<CR>

" Remove all trailing whitespace in a file
nnoremap <leader>w :StripTrailingWhitespaces<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings for Functions
""""""""""""""""""""""""""""""""""""""""""""""""""

" Print current git branch
nnoremap <leader>b :PrintCurrentBranch<CR>

" Highlight the word under the cursor
nnoremap <leader>h :HighlightWordUnderCursor<CR>

nnoremap <Leader>gh :ShowOnGithub<CR>

" Remove all trailing whitespace in a file
nnoremap <leader>w :StripTrailingWhitespaces<CR>

""""""""""""""""""""
" Section: Functions
""""""""""""""""""""

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

""""""""""""""""""
" Section: Plugins
""""""""""""""""""

" Mappings to open config files
nnoremap <leader>ev :tabnew $MYVIMRC<cr>
nnoremap <leader>et :tabnew ~/.tmux.conf<cr>
nnoremap <leader>ez :tabnew ~/.zshrc<cr>
nnoremap <leader>em :tabnew ~/.muttrc<cr>
nnoremap <leader>eg :tabnew ~/.gitconfig<cr>

nnoremap <leader>vs :source $MYVIMRC<cr>

" Mappings for moving around panes
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Mappings for movement in insert mode
inoremap <C-h> <Esc><C-w>h
inoremap <C-j> <Esc><C-w>j
inoremap <C-k> <Esc><C-w>k
inoremap <C-l> <Esc><C-w>l


nnoremap <silent> <Leader>, :exe "vertical resize +10"<CR>
nnoremap <silent> <Leader>. :exe "vertical resize -10"<CR>

" Movement commands for :terminal windows
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Mapping for opening splits and moving into it
nnoremap <leader>sv <C-w>v<C-w>l
nnoremap <leader>ss <C-w>s<C-w>j

" Quit terminal mode with escape key
tnoremap <Esc> <C-\><C-n>

" Make Y yank to the end of the line instead of the entire line (i.e. same as yy).
noremap Y y$

" Set mappings for relative line numbering
nnoremap <leader>lr :set relativenumber<CR>
nnoremap <leader>ll :set norelativenumber<CR>

" Timetrap
nnoremap <leader>tt :!t w<CR>
nnoremap <leader>ti :!t in<CR>
nnoremap <leader>to :!t out<CR>
