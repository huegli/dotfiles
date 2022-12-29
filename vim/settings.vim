" Very basic Vim

" Basic settings not covered in vim-sensible {{{

set nobackup		" No backup files
set nowritebackup
set noswapfile

set showcmd		" show incomplete commands

set hlsearch
set smartcase		" ignore case in search

set nowrap		" turn word wrap off

set tabstop=4		" set tab size in spaces
set expandtab		" tabs to spacts
set shiftwidth=4	" number of spaces inserted for a tab

set number relativenumber	" show line relative lineumbers

set visualbell      " No beeping

set autoread        " Autoload files that have changed outside of vim

set lazyredraw     " redraw only when needed (e.g. don't redraw when executing a macro)

" highlight matching [{()}] when cursor is placed on start/end character
set showmatch

let g:netrw_liststyle=3     " Set built-in file system explorer to match NERDTree

" }}}

" Coloring / Look & Feel {{{
"

set cursorline      " Highlight current line

" Highlight tailing whitespace
set list listchars=tab:▸\ ,eol:¬

" Highlight column 88
set colorcolumn=88

" exit insert mode
inoremap jk <ESC>
inoremap kj <ESC>

" Leader key is SPACE
let mapleader="\<Space>"

" PaperColor colorscheme
colorscheme PaperColor
set background=dark

" Marker folding for vim
autocmd FileType vim setlocal foldmethod=marker
" }}}

" Source code editing {{{
" no commment continuation in all files
autocmd FileType * setlocal formatoptions-=cro

set wildmenu
set wildmode=longest:full,full
" set wildoptions=fuzzy,pum,tagfile

" }}}
