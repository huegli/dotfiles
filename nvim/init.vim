"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"" Fix backspace indent (allow backspace over indent, EOL and start of edit)
set backspace=indent,eol,start

"" Tabs. Set to 4, expand tab to spaces 
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Map leader to ,
let mapleader=','

"" use 'jk' as ESC replacement
imap jk <Esc>

"" Searching
set hlsearch    "" highlight all search results
set incsearch   "" incremental search all
set ignorecase
set smartcase

set fileformats=unix,dos,mac

"" Relative line numbers, with absolute on current line 
set number
set relativenumber

"" Dracula Pro colorscheme
packadd! dracula_pro
syntax enable
let g:dracula_colorterm = 0
colorscheme dracula_pro_van_helsing

"" FZF set-up
nnoremap <C-p> :<C-u>Files<CR>

"" Faster exit
:nmap q :q<cr>
:nmap Q :q!<cr>

"" Horizontal Split Window resizing
map _ :resize -1<CR>
map + :resize +1<CR>

"" Command line window related
nnoremap :: q:
nnoremap // q/
nnoremap ?? q?
set cmdwinheight=12

"" use incsearch and hide search results when no longer searching
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
let g:incsearch#auto_nohlsearch = 1
