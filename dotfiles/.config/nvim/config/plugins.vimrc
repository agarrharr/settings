" ack.vim
" don't jump to first result automatically
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>"

" deoplete.nvim
let g:deoplete#enable_at_startup = 1
let g:tern_request_timeout = 1

" vim-fugitive
" Automatically remove fugitive buffers from the buffer list
augroup plugin_fugitive
  autocmd!
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

" neomake
autocmd! BufWritePost * Neomake
let g:neomake_verbose = 0
let g:neomake_javascript_enabled_makers = ['eslint_d', 'eslint']
let g:neomake_jsx_enabled_makers = ['eslint_d', 'eslint']

" vim-move
nmap <M-j> <Plug>MoveLineDown
nmap <M-k> <Plug>MoveLineUp
vmap <M-j> <Plug>MoveBlockDown
vmap <M-k> <Plug>MoveBlockUp

" vim-autoformat    
nnoremap <leader>f :Autoformat<CR>
nnoremap <leader>w mz:RemoveTrailingSpaces<CR>`z

" consolate-vim
nnoremap <leader>c :Consolate<cr>

" ctrlp
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window = 'results:100'

" vim-jsx
let g:jsx_ext_required = 0
