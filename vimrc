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
" Plugin 'altercation/vim-colors-solarized'
" Plugin 'endel/vim-github-colorscheme'
" Plugin 'tomasr/molokai'
Plugin 'summerfruit256.vim'
" Plugin 'scrooloose/nerdtree'
Plugin 'matchit.zip'
Plugin 'voithos/vim-python-matchit'
" Plugin 'cazador481/vim-systemverilog'
" Plugin 'vhda/verilog_systemverilog.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
" Plugin 'bling/vim-airline'
" Plugin 'itchyny/lightline.vim'
" Plugin 'pearofducks/vim-quack-lightline'
" Plugin 'tmux-plugins/vim-tmux'
Plugin 'christoomey/vim-tmux-navigator'
" Plugin 'edkolev/tmuxline.vim'
Plugin 'chrisbra/csv.vim'
Plugin 'ctrlpvim/ctrlp.vim'

" All your Plugins must be added before the following line
call vundle#end()		" required
filetype plugin indent on	" required


" ============================= Nikolai's stuff goes here ==================


" Show line numbers & ruler
set nu
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

" some configurations for NERDTree
"map <C-n> :NERDTreeToggle<CR>
"let g:NERDTreeQuitOnOpen=1
"let g:NERDTreeShowBookmarks=1
"let g:NERDTreeWinSize=40
"let g:NERDTreeMinimalUI=1
"let g:NERDTreeChDirMode=2

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" load matchit here
" runtime macros/matchit.vim

" enable syntax highlighting and proper color scheme
" let g:lightline = {
"      \ 'colorscheme': 'solarized',
"       \ 'component': {
"       \   'readonly': '%{&readonly?"x":""}',
"       \ },
"       \ 'separator': { 'left': '', 'right': '' },
"       \ 'subseparator': { 'left': '|', 'right': '|' }
"      \ }
" let g:lightline = {
"       \ 'colorscheme': 'solarized',
"       \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
"       \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
"       \ }
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
" set t_Co=256
set laststatus=2

" For tmuxline
" let g:tmuxline_separators = {
"     \ 'left' : '',
"     \ 'left_alt': '>',
"     \ 'right' : '',
"     \ 'right_alt' : '<',
"     \ 'space' : ' '}
" 
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#W',
      \'c'    : '#H',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'x'    : '%a',
      \'y'    : '#W %R',
      \'z'    : '#H'}

filetype detect
syntax enable
" if $USER == "nitrous"
"     let g:solarized_termcolors=256
"     let g:solarized_termtrans=1
"     let g:solarized_visibility="high"
" endif
" if $HOSTNAME == "NIKOLAI"
"    set background=light
" elseif $HOSTNAME == "localhost"
"    set background=light
" else
"     set background=dark
" endif
colorscheme summerfruit256

" let g:airline_powerline_fonts = 1
" let g:airline_section_b = '%{getcwd()}'
" let g:airline_section_c = '%t'

let g:ctrlp_max_depth = 5
let g:ctrlp_max_files = 500
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_follow_symlinks = 0
let g:ctrlp_default_input = 1
let g:ctrlp_use_caching = 0
