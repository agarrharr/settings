" General
" Keys
" Functions
" Plugins

"""""""""""""""""""""""""
" Section: InstallPlugins
"""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

" Autocompletion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
function! BuildTern(info)
  if a:info.status == 'installed' || a:info.force
    !npm install -g tern
  endif
endfunction
Plug 'carlitux/deoplete-ternjs', { 'do': function('BuildTern') }
" NERDTree
Plug 'scrooloose/nerdtree'
" Formatting and Linting
Plug 'w0rp/ale'
" Commenter
Plug 'tpope/vim-commentary'
" Increment dates and times
Plug 'tpope/vim-speeddating'
" Fuzzy searching for opening files
Plug 'ctrlpvim/ctrlp.vim'
" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'
" Closes html/xml tags after typing </
Plug 'docunext/closetag.vim'
" Git commands inside vim
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
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
" Plug 'PProvost/vim-markdown-jekyll'
" Add JavaScript console.log
Plug 'agarrharr/consolation-vim'
" enhances netrw
Plug 'tpope/vim-vinegar'
" Distraction-free writing
" Plug 'junegunn/goyo.vim'
" Search
Plug 'mileszs/ack.vim'
" Scratchpad
Plug 'metakirby5/codi.vim'
" Helps you open the right file
Plug 'EinfachToll/DidYouMean'
" Color theme
Plug 'altercation/vim-colors-solarized'
" JavaScript syntax highlighting and indentation
Plug 'pangloss/vim-javascript'
" JavaScript React
Plug 'mxw/vim-jsx'
" Highlight yanked text
Plug 'machakann/vim-highlightedyank'
" Calculate
Plug 'arecarn/vim-crunch'
" Code coverage
" Plug 'ruanyl/coverage.vim'
" TypeScript
Plug 'HerringtonDarkholme/yats.vim'
Plug 'leafgarland/typescript-vim'
Plug 'runoshun/tscompletejob'
" Ledger cli
Plug 'ledger/vim-ledger'
" Reason
Plug 'reasonml-editor/vim-reason-plus'
" Elm
Plug 'ElmCast/elm-vim'
" Polyglot language pack
" polyglot
let g:polyglot_disabled = ['elm']
Plug 'sheerun/vim-polyglot'
" Ruby on Rails
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
" iOS Development
function! BuildXcodeBuild(info)
  if a:info.status == 'installed' || a:info.force
    !make install
  endif
endfunction
Plug 'wojciech-kulik/xcodebuild.nvim' { 'do': function('BuildXcodeBuild') }
" fzf fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

""""""""""""""""""
" Section: General
""""""""""""""""""

set number

let mapleader = "\<Space>"

syntax enable
set background=dark
let g:solarized_termtrans = 1
colorscheme solarized

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

" Save undo history
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
" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Invisible Characters
" Shortcut to toggle invisible characters
" Use the same symbols as TextMate for tabstops and EOLs
:set list listchars=tab:\ \ ,trail:-
nnoremap <Leader>i :set list<CR>:set listchars=tab:▸\ ,eol:¬<CR>
nnoremap <Leader>io :set list<CR>:set listchars=tab:\ \ ,trail:-<CR>
" Change color to gray
highlight NonText ctermfg=7 guifg=gray
" Show this character when the line wraps
set showbreak=↪\ " Note the trailing space (escaped with a backslash) because this character is wider than 1 normal character

" Fixes issue with highlighting current word being too slow
set updatetime=100

" Fixes issue I had with json files hiding quotes
setlocal conceallevel=0

" Live substitution
if has('nvim')
  set inccommand=nosplit
endif

let g:python_host_prog  = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

"""""""""""""""
" Section: Keys
"""""""""""""""

" Mappings to open config files
nnoremap <Leader>ev :tabnew $MYVIMRC<cr>
nnoremap <Leader>et :tabnew ~/.tmux.conf<cr>
nnoremap <Leader>ez :tabnew ~/.zshrc<cr>
nnoremap <Leader>em :tabnew ~/.muttrc<cr>
nnoremap <Leader>eg :tabnew ~/.gitconfig<cr>

nnoremap <Leader>vs :source $MYVIMRC<cr>

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
if has('nvim')
  " Quit terminal mode with escape key
  tnoremap <Esc> <C-\><C-n>
  " Send escape to the terminal program
  tnoremap <C-v><Esc> <Esc>
  " Mappings for movement in terminal mode
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l

  " Put it into insert mode when entering a terminal pane
  autocmd BufWinEnter,WinEnter term://* startinsert
endif

" Mapping for opening splits and moving into it
nnoremap <Leader>sv <C-w>v<C-w>l
nnoremap <Leader>ss <C-w>s<C-w>j

" Make Y yank to the end of the line instead of the entire line (i.e. same as yy).
noremap Y y$

" Set mappings for relative line numbering
nnoremap <Leader>lr :set relativenumber<CR>
nnoremap <Leader>ll :set norelativenumber<CR>

" Set * to search for the current visual selection
vnoremap * y/<C-R>"<CR>

" Timetrap
nnoremap <Leader>tt :!t w<CR>
nnoremap <Leader>ti :!t in<CR>
nnoremap <Leader>to :!t out<CR>

" VLC transcriptions
nnoremap <Leader>dh :normal! mqO<dt>Host</dt><Esc>`q
nnoremap <Leader>dg :normal! mqO<dt>Guest</dt><Esc>`q
nnoremap <Leader>dd :normal! mqI<dd><Esc>A</dd><Esc>`q
nnoremap <Tab> :!player_control vlc toggle<Enter><Enter>
nnoremap <Leader>0 :!player_control vlc back5<Enter><Enter>
nnoremap <Leader>1 :!player_control vlc speed100<Enter><Enter>
nnoremap <Leader>2 :!player_control vlc speed125<Enter><Enter>
nnoremap <Leader>3 :!player_control vlc speed150<Enter><Enter>
nnoremap <Leader>4 :!player_control vlc speed200<Enter><Enter>

" Search through command history (in command line mode) with Ctrl-P and Ctrl-N
" And make Up and Down go through all of the history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <Up> <C-p>
cnoremap <Down> <C-n>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings for Functions
""""""""""""""""""""""""""""""""""""""""""""""""""

" Print current git branch
nnoremap <Leader>b :PrintCurrentBranch<CR>

" Highlight the word under the cursor
nnoremap <Leader>h :HighlightWordUnderCursor<CR>

nnoremap <Leader>gh :ShowOnGithub<CR>

" Remove all trailing whitespace in a file
nnoremap <Leader>w :StripTrailingWhitespaces<CR>

""""""""""""""""""""
" Section: Functions
""""""""""""""""""""

" autocmd BufWritePost *.swift silent !xed -b % // open this file in Xcode in the background whenever I save a Swift file

autocmd BufWritePost *.swift call OpenInXcode()

function! OpenInXcode()
    " Get the current file path
    let current_file = expand('%')

    " Escape special characters in the file path
    let escaped_file = shellescape(current_file)

    " Run the xed command
    silent execute "!xed -b " . escaped_file
endfunction

""""""""""""""""""""
" Section: Functions
""""""""""""""""""""

" Highlight all instances of word under cursor
" It doesn't clobber the search register
function! HighlightWordUnderCursor()
    if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]'
        execute 'match' 'Search' '/\V\<'.expand('<cword>').'\>/'
    else
        match none
    endif
endfunction
command! -nargs=0 HighlightWordUnderCursor call HighlightWordUnderCursor()

function! ShowOnGithub()
  let u = system("echo ${${${$(git --git-dir=.git config --get remote.origin.url)#git@github.com:}%.git}#https://github.com/} | xargs echo -n")
  silent execute "!open "."https://github.com/".u."/blob/master/".@%.'\#L'.line(".")
endfunction
command! -nargs=0 ShowOnGithub call ShowOnGithub()

nnoremap <Leader>gh :ShowOnGithub<CR>

function! PrintCurrentBranch()
  execute ":.-1read!git rev-parse --abbrev-ref HEAD"
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

function! CmusPause()
  silent execute ":!cmus-remote --pause"
endfunction
command! -nargs=0 CmusPause call CmusPause()

function! CmusBack()
  execute ":!cmus-remote --seek -5"
endfunction
command! -nargs=0 CmusBack call CmusBack()

""""""""""""""""""
" Section: Plugins
""""""""""""""""""

" NERDTree
map <C-n> :NERDTreeToggle<CR>
" map <C-m> :NERDTreeMirror<CR>

" ack.vim
" don't jump to first result automatically
cnoreabbrev Ack Ack!
nnoremap <Leader><Space> :Ack!<Space>"

" deoplete.nvim
let g:deoplete#enable_at_startup = 1
let g:tern_request_timeout = 1
" Disable autocompletion because ALE autocompletion works for TypeScript
autocmd FileType typescript  let b:deoplete_disable_auto_complete = 1
" https://github.com/carlitux/deoplete-ternjs/issues/88
call deoplete#custom#option('num_processes', 4)

" vim-fugitive
" Automatically remove fugitive buffers from the buffer list
augroup plugin_fugitive
  autocmd!
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

" vim-move
nmap <Leader>j <Plug>MoveLineDown
nmap <Leader>k <Plug>MoveLineUp
vmap <Leader>j <Plug>MoveBlockDown
vmap <Leader>k <Plug>MoveBlockUp

" consolate-vim
nnoremap <Leader>c :Consolate<cr>

" ctrlp
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window = 'results:100'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](public|\.cache)$',
  \ 'file': '\v(yarn.lock|package-lock.json)$',
  \ }

" vim-jsx
let g:jsx_ext_required = 0

" coverage.vim
let g:coverage_json_report_path = 'artifacts/coverage/coverage-final.json'
let g:coverage_sign_covered = '⦿'
let g:coverage_interval = 5000
let g:coverage_show_covered = 0
let g:coverage_show_uncovered = 1

" ale
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier'],
\   'scss': ['prettier'],
\}
let g:ale_fix_on_save = 1
" let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'
" Enable completion where available.
let g:ale_completion_enabled = 1
let g:ale_change_sign_column_color = 1
nnoremap <Leader>ad :ALEGoToDefinition<CR>
nnoremap <Leader>ae :ALEDetail<CR>

" TypeScript
" tscompletejob
nnoremap <Leader>ti :TsCompleteJobQuickInfo<CR>
" Disable autocompletion because ALE autocompletion works for TypeScript
let g:tscompletejob_complete_disable = 1

" ledger-cli
au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger

" elm-vim
let g:elm_jump_to_error = 1
let g:elm_setup_keybindings = 0
let g:elm_make_show_warnings = 0
nnoremap <Leader>mr :ElmRepl<CR>
nnoremap <Leader>md :ElmShowDocs<CR>
nnoremap <Leader>mb :ElmBrowseDocs<CR>

" fzf
let g:fzf_layout = { 'down': '~40%' }
" Remember to use :GFiles to fuzzy find files (ignoring .gitignored files)
" Use :Rg to use ripgrep to fuzzy search within files with ripgrep
" Use :Commits to view commit history and Enter to check it out
