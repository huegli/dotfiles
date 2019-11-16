# source "%val{config}/plugins/plug.kak/rc/plug.kak"
# plug "andreyorst/fzf.kak"

colorscheme base16-mine

# <comma><dot> to escape
hook global InsertChar \. %{ try %{
    exec -draft hH <a-k>,\.<ret> d
    exec <esc>
}}

# black formating for Python
hook global WinSetOption filetype=python %{
    jedi-enable-autocomplete
    lint-enable
    set-option global lintcmd 'pylint'
    set-option window formatcmd 'black -q  -'
}

# line numbers
add-highlighter global/ number-lines
