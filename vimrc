set nocompatible	" be iMproved, required
filetype off		" required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle managa Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'

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

" Need this for Nerdtree
" let g:NERDTreeDirArrows=0

" helps discover completions
set wildmenu

" this converts help files to full-screen tabs
augroup HelpInTabs
	autocmd!
	autocmd BufEnter *.txt call HelpInNewTab()
augroup END

function! HelpInNewTab ()
	if &buftype == 'help'
		"Convert to help windo to a tab...
		execute "normal \<C-W>T"
	endif
endfunction

" fix backspace behavior
set backspace=start,indent,eol

" take care of proper tabstops / tab to spaces
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
