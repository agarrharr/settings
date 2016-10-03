" Deoplete
let g:deoplete#enable_at_startup = 1
let g:tern_request_timeout = 1

" Fugitive
" Automatically remove fugitive buffers from the buffer list
augroup plugin_fugitive
  autocmd!
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

" Syntastic
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_args = "--config ~/.eslintrc"

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

let g:ctrlp_cmd='CtrlP :pwd'
let g:ctrlp_match_window = 'results:100'
