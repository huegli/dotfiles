source "%val{config}/plugins/plug.kak/rc/plug.kak"

plug "andreyorst/fzf.kak"
map global user 'p' ': fzf-mode<ret>'

plug "andreyorst/smarttab.kak" defer smarttab %{
    # when `backspace' is pressed, 4 spaces are deleted at once
    set-option global softtabstop 4
} config %{
    # these languages will use `expandtab' behavior
    hook global WinSetOption filetype=(python|kak|sh) expandtab
    # these languages will use `noexpandtab' behavior
    hook global WinSetOption filetype=(makefile|go) noexpandtab
    # these languages will use `smarttab' behavior
    hook global WinSetOption filetype=(c|cpp) smarttab
}

plug "alexherbo2/prelude.kak"
plug "alexherbo2/connect.kak"

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
    set-option window lintcmd 'pylint'
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
define-command ranger -params .. -file-completion %(connect ranger %arg(@))

map global user 'v' ": vsplit<ret>" -docstring "Vertical split buffer"
map global user 'h' ": split<ret>" -docstring "Horizontal split buffer"
map global user 't' ": tabnew<ret>" -docstring "New tab with buffer"
map global user 'r' ": ranger<ret>" -docstring "Vertical split with Ranger"


# Other custom key mapings
map global user ',' ": send-text<ret>" -docstring "Send selection to REPL"
