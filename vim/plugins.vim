" Settings for plugins

" ALE {{{
let g:ale_linters={
\ 'python': ['flake8', 'pylsp'],
\ 'c': ['ccls'],
\ 'cpp': ['ccls'],
\}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
" let g:ale_completion_enabled = 1
let g:ale_completion_enabled = 0
" let g:ale_completion_delay = 500
let g:ale_set_ballons = 1
set omnifunc=ale#completion#OmniFunc

" show details on issues in preview window, close when going into insert mode
let g:ale_cursor_detail = 1
let g:ale_close_preview_on_insert = 1
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

"" async-complete {{{
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

"let g:asyncomplete_min_chars = 3

"" allow modifying the completeopt variable, or it will
"" be overridden all the time
"let g:asyncomplete_auto_completeopt = 0

"set completeopt=menuone,noinsert,noselect,preview

"" Use ALE's function for asyncomplete defaults
"" call asyncomplete#register_source(asyncomplete#sources#ale#get_source_options({
""     \ 'priority': 10, 
""     \ }))

"" let g:asyncomplete_auto_popup = 0

""" function! s:check_back_space() abort
"""       let col = col('.') - 1
"""       return !col || getline('.')[col - 1]  =~ '\s'
"""  endfunction
""" 
"""  inoremap <silent><expr> <TAB>
"""     \ pumvisible() ? "\<C-n>" :
"""     \ <SID>check_back_space() ? "\<TAB>" :
"""     \ asyncomplete#force_refresh()
"""  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


"" call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
""     \ 'name': 'buffer',
""     \ 'allowlist': ['*'],
""     \ 'blocklist': ['go'],
""     \ 'completor': function('asyncomplete#sources#buffer#completor'),
""     \ 'config': {
""       \    'max_buffer_size': 5000000,
""     \  },
""     \ }))


"" }}}

" indentLine {{{
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" }}}

" YouCompleteMe {{{
let g:ycm_show_diagnostics_ui = 0
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" }}}
" SuperTab {{{
let g:SuperTabDefaultCompletionType = '<C-n>'
" }}}
