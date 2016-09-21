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


nnoremap <silent> <Leader>. :exe "vertical resize +10"<CR>
nnoremap <silent> <Leader>. :exe "vertical resize -10"<CR>

" Movement commands for :terminal windows
tnoremap <C-h> <C-\><C-n><C-w>h
" Workaround since <C-h> isn't working in neovim right now
" https://github.com/neovim/neovim/wiki/FAQ#my-ctrl-h-mapping-doesnt-work
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Mapping for opening splits and moving into it
nnoremap <leader>sv <C-w>v<C-w>l
nnoremap <leader>ss <C-w>s<C-w>j

" Make Y yank to the end of the line instead of the entire line (i.e. same as yy).
noremap Y y$

" Set mappings for relative line numbering
nnoremap <leader>lr :set relativenumber<CR>
nnoremap <leader>ll :set norelativenumber<CR>

" Remove all trailing whitespace in a file
nnoremap <leader>w :call StripTrailingWhitespaces()<CR>

" Timetrap
nnoremap <leader>tt :!t w<CR>
nnoremap <leader>ti :!t in<CR>
nnoremap <leader>to :!t out<CR>
