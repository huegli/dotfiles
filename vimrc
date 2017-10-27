" Vundle {{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'matchit.zip'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
"Plugin 'tmux-plugins/vim-tmux'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'chrisbra/csv.vim'
Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
Plugin 'itchyny/lightline.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'morhetz/gruvbox'
Plugin 'altercation/vim-colors-solarized.git'
" Plugin 'shinchu/lightline-gruvbox.vim'
" Plugin 'arrufat/vala.vim'
Plugin 'severin-lemaignan/vim-minimap'
Plugin 'majutsushi/tagbar'
Plugin 'vhda/verilog_systemverilog.vim'
Plugin 'tmhedberg/SimpylFold' 
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Bundle 'nfvs/vim-perforce'
" Plugin 'Valloric/YouCompleteMe'

" All your Plugins must be added before the following line
call vundle#end()		" required
filetype plugin indent on	" required
" }}}

" Settings {{{
" Switch syntax highlighting on, when the terminal has colors
syntax on

" Use vim, not vi api
set nocompatible

" No backup files
set nobackup

" No write backup
set nowritebackup

" No swap file
set noswapfile

" Command history
set history=100

" Always show cursor
set ruler

" Show incomplete commands
set showcmd

" Incremental searching (search as you type)
set incsearch

" Highlight search matches
set hlsearch

" Ignore case in search
set smartcase

" Make sure any searches /searchPhrase doesn't need the \c escape character
set ignorecase

" A buffer is marked as ‘hidden’ if it has unsaved changes, and it is not currently loaded in a window
" if you try and quit Vim while there are hidden buffers, you will raise an error:
" E162: No write since last change for buffer “a.txt”
set hidden

" Turn word wrap off
set nowrap

" Allow backspace to delete end of line, indent and start of line characters
set backspace=indent,eol,start

" Convert tabs to spaces
set expandtab

" Set tab size in spaces (this is for manual indenting)
set tabstop=4

" The number of spaces inserted for a tab (used for auto indenting)
set shiftwidth=4

" Turn on line numbers
set number

" Highlight tailing whitespace
" See issue: https://github.com/Integralist/ProVim/issues/4
set list listchars=tab:\ \ ,trail:·

" Get rid of the delay when pressing O (for example)
" http://stackoverflow.com/questions/2158516/vim-delay-before-o-opens-a-new-line
set timeout timeoutlen=1000 ttimeoutlen=100

" Always show status bar
set laststatus=2

" Hide the toolbar
set guioptions-=T

" UTF encoding
set encoding=utf-8

" Autoload files that have changed outside of vim
set autoread

" Use system clipboard
" http://stackoverflow.com/questions/8134647/copy-and-paste-in-vim-via-keyboard-between-different-mac-terminals
set clipboard+=unnamed

" Don't show intro
set shortmess+=I

" Better splits (new windows appear below and to the right)
set splitbelow
set splitright

" Highlight the current line
set cursorline

" Ensure Vim doesn't beep at you every time you make a mistype
set visualbell

" Visual autocomplete for command menu (e.g. :e ~/path/to/file)
set wildmenu

" redraw only when we need to (i.e. don't redraw when executing a macro)
set lazyredraw

" highlight a matching [{()}] when cursor is placed on start/end character
set showmatch

" Set built-in file system explorer to use layout similar to the NERDTree plugin
let g:netrw_liststyle=3

" Always highlight column 80 so it's easier to see where
" cutoff appears on longer screens
autocmd BufWinEnter * highlight ColorColumn ctermbg=darkred
set colorcolumn=80
" }}}


" fix unicode
" if has("multi_byte")
" "  if &termencoding == ""
" "    let &termencoding = &encoding
" "  endif
"   set encoding=utf-8
"   scriptencoding utf-8
"   setglobal fileencoding=utf-8
"   "setglobal bomb
"   set fileencodings=ucs-bom,utf-8,latin1
" endif


" ============================= Nikolai's stuff goes here ==================


" Show line numbers & ruler
" set relativenumber


" helps discover completions
set wildmode=longest,list,full

" this converts help files to full-screen tabs
" augroup HelpInTabs
" 	autocmd!
" 	autocmd BufEnter *.txt call HelpInNewTab()
" augroup END

" function! HelpInNewTab ()
" 	if &buftype == 'help'
" 		"Convert to help windo to a tab...
" 		execute "normal \<C-W>T"
" 	endif
" endfunction

" This is needed only for Cmder/cygwin TERM
" if hostname() == "NIKOLAI"
"     inoremap <Char-0x07f> <BS>
" endif


" Font for GVIM
if has('gui_running')
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 11
endif

" let g:airline_theme='gruvbox'
" let g:airline_powerline_fonts = 1

" load lightline
" if hostname() == "scv-nschlegel01.csg.apple.com"  
"     let g:lightline = {
"           \ 'colorscheme': 'solarized',
"           \ 'component': {
"           \   'readonly': '%{&readonly?"":""}',
"           \ },
"           \ 'separator': { 'left': '', 'right': '' },
"           \ 'subseparator': { 'left': '', 'right': '' }
"           \ }
" else
"     let g:lightline = {
"           \ 'colorscheme': 'gruvbox',
"           \ 'component': {
"           \   'readonly': '%{&readonly?"":""}',
"           \ },
"           \ 'separator': { 'left': '', 'right': '' },
"           \ 'subseparator': { 'left': '', 'right': '' }
"           \ }
" endif
" let g:tmuxline_powerline_separators = 0
set noshowmode

set laststatus=2

filetype detect

" host-specific colorscheme
if hostname() == "Nikolais-MacBook-Pro.local"
     set background=dark
     colorscheme solarized
"     let g:lightline = {
"          \ 'colorscheme': 'solarized'
"          \ }
     let g:lightline = {
          \ 'colorscheme': 'solarized',
          \ 'component': {
          \   'readonly': '%{&readonly?"":""}',
          \ },
          \ 'separator': { 'left': '', 'right': '' },
          \ 'subseparator': { 'left': '', 'right': '' }
          \ }
" elseif hostname() == "NIKOLAI" || hostname() == "NIKOLAIS_CINTIQ"
"    set term=pcansi
"    set t_Co=256
"    let &t_AB="\e[48;5;%dm"
"    let $t_AF="\e[38;5;%dm"
"    colorscheme gruvbox
else
    set background=dark
    colorscheme gruvbox
    highlight normal ctermbg=none
"     let g:lightline = {
"         \ 'colorscheme': 'gruvbox'
"         \ }
    let g:lightline = {
        \ 'colorscheme': 'gruvbox',
        \ 'component': {
        \   'readonly': '%{&readonly?"":""}',
        \ },
        \ 'separator': { 'left': '', 'right': '' },
        \ 'subseparator': { 'left': '', 'right': '' }
        \ }
endif

let g:ctrlp_max_depth = 5
let g:ctrlp_max_files = 500
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_follow_symlinks = 0
let g:ctrlp_default_input = 1
let g:ctrlp_use_caching = 0

" Disable valadoc syntax highlight
" let vala_ignore_valadoc = 1

" Enable comment strings
" let vala_comment_strings = 1

" Highlight space errors
" let vala_space_errors = 1

" Disable trailing space errors
"let vala_no_trail_space_error = 1
" Disable space-tab-space errors
" let vala_no_tab_space_error = 1

" Minimum lines used for comment syncing (default 50)
"let vala_minlines = 120

" Some configurations for Python / program editing in general
noremap <space> za

au BufNewFile,BufRead *.py
    \ set softtabstop=4
    \ textwidth=79
    \ autoindent
    \ fileformat=unix

highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
let python_highlight_all=1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler_options = "-std=c++11"

" Apple CE uses the older Exuberant ctags, this overrides it with my own
" version
if hostname() == "scv-nschlegel01.csg.apple.com"
    let g:tagbar_ctags_bin = '$HOME/.local/bin/ctags'
endif

" Leader Key mappings
let g:minimap_show='<leader>ms'
let g:minimap_update='<leader>mu'
let g:minimap_close='<leader>gc'
let g:minimap_toggle='<leader>gt'

" Tagbar stuff
nmap <F8> :TagbarToggle<CR>

" Perforce stuff
let g:perforce_open_on_change = 1

