"" source setttings
source ~/dotfiles/nvim/settings.vim

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
