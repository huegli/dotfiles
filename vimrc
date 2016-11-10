set nocompatible	" be iMproved, required
filetype off		" required

" fix unicode
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  scriptencoding utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'matchit.zip'
Plugin 'cazador481/vim-systemverilog'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'chrisbra/csv.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'morhetz/gruvbox'
Plugin 'shinchu/lightline-gruvbox.vim'
 
" All your Plugins must be added before the following line
call vundle#end()		" required
filetype plugin indent on	" required


" ============================= Nikolai's stuff goes here ==================


" Show line numbers & ruler
set number
set relativenumber
set ruler

" No wrapping of lines
set nowrap

" helps discover completions
set wildmenu

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

" fix backspace behavior
set backspace=start,indent,eol

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" Font for GVIM
if has('gui_running')
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 11
endif

" load lightline
if hostname() == "vl-nikolai-ice" || hostname() == "vl-nikolai-scl"
    let g:lightline = {
          \ 'colorscheme': 'solarized',
          \ 'component': {
          \   'readonly': '%{&readonly?"":""}',
          \ },
          \ 'separator': { 'left': '', 'right': '' },
          \ 'subseparator': { 'left': '', 'right': '' }
          \ }
else
    let g:lightline = {
          \ 'colorscheme': 'gruvbox',
          \ 'component': {
          \   'readonly': '%{&readonly?"":""}',
          \ },
          \ 'separator': { 'left': '', 'right': '' },
          \ 'subseparator': { 'left': '', 'right': '' }
          \ }
endif
set laststatus=2

filetype detect
syntax enable

" host-specific colorscheme
if hostname() == "vl-nikolai-ice" || hostname() == "vl-nikolai-scl"
    colorscheme solarized
    set background=dark
else
    colorscheme gruvbox
    set background=dark
    highlight normal ctermbg=none
endif

let g:ctrlp_max_depth = 5
let g:ctrlp_max_files = 500
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_follow_symlinks = 0
let g:ctrlp_default_input = 1
let g:ctrlp_use_caching = 0
