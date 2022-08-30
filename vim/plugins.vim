" Settings for plugins

" ALE {{{
let g:ale_linters={
\ 'python': ['flake8', 'pylsp'],
\}
" }}}

" Fern {{{

" Open drawer with current file selected, all windows same height & size
noremap <silent> <Leader>f :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=

" Open split with current file selected, all windows same height & size
noremap <silent> <Leader>o :Fern . -reveal=%<CR><C-w>=

function! s:init_fern() abort
  " Use 'select' instead of 'edit' for default 'open' action
  nmap <buffer> <Plug>(fern-action-open) <Plug>(fern-action-open:select)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END
" }}}

" Vim-Signify {{{

" Mappings for vim-signify
nnoremap <leader>gd :SignifyDiff<cr>
nnoremap <leader>gp :SignifyHunkDiff<cr>
nnoremap <leader>gu :SignifyHunkUndo<cr>
" }}}

" CtrlP / CtrlPFunky {{{

nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>r :CtrlPMRU<cr>
nnoremap <leader>gf :CtrlPFunky<cr>
" }}}

" FastFold {{{
nmap zuz <Plug>(FastFoldUpdate)                 " Force update in normal mode
let g:fastfold_savehook = 1                     " Update on save
" Update on the following fold commands
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

" Fast fold for the following file types
let g:markdown_folding = 1
let g:rst_fold_enabled = 1
let g:vimsyn_folding = 'af'
let g:xml_syntax_folding = 1
let g:javaScript_fold = 1
let g:sh_fold_enabled= 7
let g:zsh_fold_enable = 1
let g:perl_fold = 1
let g:perl_fold_blocks = 1

" And C like filetyes
autocmd FileType c,cpp setlocal foldmethod=syntax
" }}}


