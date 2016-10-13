" Deoplete
let g:deoplete#enable_at_startup = 1
let g:tern_request_timeout = 1

" Fugitive
" Automatically remove fugitive buffers from the buffer list
augroup plugin_fugitive
  autocmd!
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

" Neomake

autocmd! BufWritePost * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']

let g:neomake_error_sign={'text': '✖', 'texthl': 'NeomakeErrorMsg'}
let g:neomake_warning_sign={'text': '⚠️', 'texthl': 'NeomakeErrorMsg'}
let g:neomake_javascript_enabled_makers = ['eslint_d', 'eslint']
let g:neomake_jsx_enabled_makers = ['eslint_d', 'eslint']

" Move
nmap <M-j> <Plug>MoveLineDown
nmap <M-k> <Plug>MoveLineUp
vmap <M-j> <Plug>MoveBlockDown
vmap <M-k> <Plug>MoveBlockUp

" JsBeautify
augroup plugin_fugitive
  autocmd!
  autocmd FileType javascript noremap <buffer>  <leader>bj :call JsBeautify()<cr>
  " for html
  autocmd FileType html noremap <buffer> <leader>bh :call HtmlBeautify()<cr>
  " for css or scss
  autocmd FileType css noremap <buffer> <leader>bc :call CSSBeautify()<cr>
augroup END

" Consolate

nnoremap <leader>c :Consolate<cr>

" CtrlP

let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window = 'results:100'
