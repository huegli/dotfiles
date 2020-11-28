source "%val{config}/plugins/plug.kak/rc/plug.kak"

source "%val{config}/oberon.kak"

source "%val{config}/prelude.kak"
require-module prelude

source "%val{config}/connect.kak"
require-module connect

plug "andreyorst/fzf.kak" config %{
    map -docstring 'fzf mode' global user 'p' ': fzf-mode<ret>'
} defer fzf %{
    set-option global fzf_preview_width '65%'
    set-option global fzf_project_use_tilda true
    set-option global fzf_file_command "find . \( -path '*/venv*' -o -path '*/.git*' \) -prune -o -type f -print"
}

# plug "andreyorst/smarttab.kak" defer smarttab %{
#     # when `backspace' is pressed, 4 spaces are deleted at once
#     set-option global softtabstop 4
# } config %{
#     # these languages will use `expandtab' behavior
#     hook global WinSetOption filetype=(python|kak|sh) expandtab
#     # these languages will use `noexpandtab' behavior
#     hook global WinSetOption filetype=(makefile|go) noexpandtab
#     # these languages will use `smarttab' behavior
#     hook global WinSetOption filetype=(c|cpp) smarttab
# }

# plug "alexherbo2/prelude.kak"
# plug "alexherbo2/connect.kak"

# plug "andreyorst/kaktree" defer kaktree %{
#     # settings for fancy icons as on the screenshot above.
#     set-option global kaktree_dir_icon_open  '▾ 📂' # 📂 📁
#     set-option global kaktree_dir_icon_close '▸ 📁'
#     set-option global kaktree_file_icon      '⠀⠀  ' # 🖺 🖻
#                                             # ^^ these are not spaces. It is invisible characters.
#                                             # This needed to make folding work correctly if you do
#                                             # space alignment of icons.
# } config %{
#     map global user 'f' ": kaktree-toggle<ret>" -docstring "toggle filetree panel"
#     hook global WinSetOption filetype=kaktree %{
#         remove-highlighter buffer/numbers
#         remove-highlighter buffer/matching
#         remove-highlighter buffer/wrap
#         remove-highlighter buffer/show-whitespaces
#     }
#     kaktree-enable
# }

plug 'delapouite/kakoune-cd' %{
    # Suggested mapping
    map global user c ': enter-user-mode cd<ret>' -docstring 'cd'
    # Suggested aliases
    alias global cdb change-directory-current-buffer
    alias global cdr change-directory-project-root
    alias global ecd edit-current-buffer-directory
    alias global pwd print-working-directory
}

# EasyMotion
plug 'danr/kakoune-easymotion'  %{
    map global user e ': enter-user-mode easymotion<ret>' -docstring 'EasyMotion'
    face global EasyMotionBackground rgb:999999
    face global EasyMotionForeground yellow+b
    face global EasyMotionSelected white+b
}


# Favorite color scheme
colorscheme base16-mine

# Tab's for completion
hook global InsertCompletionShow .* %{
    try %{
        # this command temporarily removes cursors preceded by whitespace;
        # if there are no cursors left, it raises an error, does not
        # continue to execute the mapping commands, and the error is eaten
        # by the `try` command so no warning appears.
        execute-keys -draft 'h<a-K>\h<ret>'
        map window insert <tab> <c-n>
        map window insert <s-tab> <c-p>
    }
}
hook global InsertCompletionHide .* %{
    unmap window insert <tab> <c-n>
    unmap window insert <s-tab> <c-p>
}

# <comma><dot> to escape
hook global InsertChar \. %{ try %{
    exec -draft hH <a-k>,\.<ret> d
    exec <esc>
}}

# black formating for Python
hook global WinSetOption filetype=python %{
    jedi-enable-autocomplete
    lint-enable
    set-option window lintcmd 'flake8'
    set-option window formatcmd 'black -q  -'
}

# Formating and Listing for Go
hook global WinSetOption filetype=go %{
    set-option window formatcmd 'gofmt'
}

# grep with ag
set global grepcmd 'ag --column'

# line numbers
add-highlighter global/ number-lines -relative

# TMUX panes & window creation
define-command -docstring "vsplit [<commands>]: split tmux vertically" \
vsplit -params .. -command-completion %{
        tmux-terminal-horizontal kak -c %val{session} -e "%arg{@}"
}

define-command -docstring "split [<commands>]: split tmux horizontally" \
split -params .. -command-completion %{
        tmux-terminal-vertical kak -c %val{session} -e "%arg{@}"
}

define-command -docstring "tabnew [<commands>]: create new tmux window" \
tabnew -params .. -command-completion %{
        tmux-terminal-window kak -c %val{session} -e "%arg{@}"
}

# Ranger
# define-command ranger -params .. -file-completion %(connect ranger %arg(@))

map global user 'v' ": vsplit<ret>" -docstring "Vertical split buffer"
map global user 'h' ": split<ret>" -docstring "Horizontal split buffer"
map global user 't' ": tabnew<ret>" -docstring "New tab with buffer"
# map global user 'r' ": ranger<ret>" -docstring "Vertical split with Ranger"


# Other custom key mapings
map global user ',' ": send-text<ret>" -docstring "Send selection to REPL"

# # fix tilish overlay
# declare-user-mode ctrla
# 
# map global ctrla <a> <a-a> -docstring "Select whole object"
# map global ctrla <b> <a-b> -docstring "Select previous WORD start"
# map global ctrla <B> <a-B> -docstring "Extend previous WORD start"
# map global ctrla <c> <a-c> -docstring "Change select text without yanking"
# map global ctrla <C> <a-C> -docstring "Copy selection on previous lines"
# map global ctrla <d> <a-d> -docstring "Erase selected text withou yanking"
# map global ctrla <e> <a-e> -docstring "Select next WORD end"
# map global ctrla <E> <a-E> -docstring "Extend next WORD end"
# map global ctrla <f> <a-f> -docstring "Select to previous character included"
# map global ctrla <F> <a-F> -docstring "Extend to previous character included"
# map global ctrla <h> <a-h> -docstring "Select to line begin"
# map global ctrla <H> <a-H> -docstring "Extend to line begin"
# map global ctrla <i> <a-i> -docstring "Select inner object"
# map global ctrla <j> <a-j> -docstring "Join lines"
# map global ctrla <J> <a-J> -docstring "Join lines & select spaces"
# map global ctrla <k> <a-k> -docstring "Keep matching selections"
# map global ctrla <K> <a-K> -docstring "Keep non-matching selections"
# map global ctrla <l> <a-l> -docstring "Select to line end"
# map global ctrla <L> <a-L> -docstring "Extend to line end"
# map global ctrla <m> <a-m> -docstring "Select to previous matching character"
# map global ctrla <M> <a-M> -docstring "Extend to previous matching character"
# map global ctrla <n> <a-n> -docstring "Select previous current search pattern"
# map global ctrla <N> <a-N> -docstring "Extend with previous current search pattern"
# map global ctrla <o> <a-o> -docstring "Add a new empty line below"
# map global ctrla <O> <a-O> -docstring "Add a new emply line above"
# map global ctrla <p> <a-p> -docstring "Paste every yanked line after text"
# map global ctrla <P> <a-P> -docstring "Paste every yanked line before text"
# map global ctrla <R> <a-R> -docstring "Replace selected text with all yanked texts"
# map global ctrla <s> <a-s> -docstring "Split on line ends"
# map global ctrla <S> <a-S> -docstring "Select first/last of selection"
# map global ctrla <t> <a-t> -docstring "Select to previous character"
# map global ctrla <T> <a-T> -docstring "Extend to previou character"
# map global ctrla <u> <a-u> -docstring "Move backward in history"
# map global ctrla <U> <a-U> -docstring "Move forward in history"
# map global ctrla <w> <a-w> -docstring "Select to next WORD start"
# map global ctrla <W> <a-W> -docstring "Extend to next WORD start"
# map global ctrla <x> <a-x> -docstring "Extend selections to whole lines"
# map global ctrla <X> <a-X> -docstring "Crop selections to whole lines"
# map global ctrla <z> <a-z> -docstring "Combine selections from register"
# map global ctrla <Z> <a-Z> -docstring "Combine selections to register"
# # Don't worry about Alt-l -> select to end of line
# # Figure out how to handle Alt-t: select/extend previous char
# map global normal <c-a> ':enter-user-mode<space>ctrla<ret>'
