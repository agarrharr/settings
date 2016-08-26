syntax on
set number

set laststatus=2
set ruler

set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" Set leader key to comma
let mapleader = ","
let maplocalleader = "\\"

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

" Define a thesaurus file
set thesaurus+=~/dotfiles/mthesaur.txt

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

" Put it into insert mode when entering a terminal pane
autocmd BufWinEnter,WinEnter term://* startinsert

" Make the backspace work in terminal
set backspace=indent,eol,start

" Enable better indentation.
set autoindent smartindent
set smarttab

" Setup indicator for 132 columns
set colorcolumn=133

" Code folding for javascript
syntax region foldBraces start=/{/ end=/}/ transparent fold keepend extend
setlocal foldmethod=syntax
setlocal foldlevel=10

" Set comment style for javascript to single line
augroup filetype_js
  autocmd!
  autocmd FileType javascript set commentstring=//\ %s
augroup END

" Copy to system clipboard when you yank
set clipboard=unnamed

" Enable mouse in iTerm2
set mouse=a

" Set indentation to tab characters of 4 width
:set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

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

set updatetime=100

" Fixes issue I was having with background color
if &term =~ '256color'
    " disable Background Color Erase (BCE)
    set t_ut=
endif

" Fixes issue I had with json files hiding quotes
setlocal conceallevel=0
