set number

colorscheme nova

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

" Set prettier as the JavaScript formatter
autocmd FileType javascript set formatprg=prettier\ --stdin

" Copy to system clipboard when you yank
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
