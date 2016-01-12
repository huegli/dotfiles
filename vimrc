set nocompatible	" be iMproved, required
filetype off		" required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'matchit.zip'
Plugin 'voithos/vim-python-matchit'
Plugin 'nachumk/systemverilog.vim'
Plugin 'tpope/vim-surround'

" All your Plugins must be added before the following line
call vundle#end()		" required
filetype plugin indent on	" required


" ============================= Nikolai's stuff goes here ==================

" Show line numbers & ruler
set nu
set ruler

" No wrapping of lines
set nowrap

syntax enable
set background=dark
colorscheme solarized

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

" some configurations for NERDTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowBookmarks=1
let g:NERDTreeWinSize=40
let g:NERDTreeMinimalUI=1
let g:NERDTreeChDirMode=2

" take care of proper tabstops / tab to spaces
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
