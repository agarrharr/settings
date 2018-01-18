" ack.vim
" don't jump to first result automatically
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>"

" deoplete.nvim
let g:deoplete#enable_at_startup = 1
let g:tern_request_timeout = 1
" Disable autocompletion because ALE autocompletion works for TypeScript
autocmd FileType typescript  let b:deoplete_disable_auto_complete = 1

" vim-fugitive
" Automatically remove fugitive buffers from the buffer list
augroup plugin_fugitive
  autocmd!
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

" vim-move
nmap <leader>j <Plug>MoveLineDown
nmap <leader>k <Plug>MoveLineUp
vmap <leader>j <Plug>MoveBlockDown
vmap <leader>k <Plug>MoveBlockUp

" consolate-vim
nnoremap <leader>c :Consolate<cr>

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
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'
" Enable completion where available.
let g:ale_completion_enabled = 1
nnoremap <leader>d :ALEGoToDefinition<CR>

" TypeScript
" tscompletejob
nnoremap <leader>i :TsCompleteJobQuickInfo<CR>
" Disable autocompletion because ALE autocompletion works for TypeScript
let g:tscompletejob_complete_disable = 1
