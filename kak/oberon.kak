# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*\.Mod %{
    set-option buffer filetype oberon
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=oberon %{
    require-module oberon

    set-option window static_words %opt{oberon_static_words}

    # cleanup trailing whitespaces when exiting insert mode
#    hook window ModeChange pop:insert:.* -group go-trim-indent %{ try %{ execute-keys -draft <a-x>s^\h+$<ret>d } }
#    hook window InsertChar \n -group go-indent go-indent-on-new-line
#    hook window InsertChar \{ -group go-indent go-indent-on-opening-curly-brace
#    hook window InsertChar \} -group go-indent go-indent-on-closing-curly-brace

    hook -once -always window WinSetOption filetype=.* %{ remove-hooks window oberon-.+ }
}

hook -group oberon-highlight global WinSetOption filetype=oberon %{
    add-highlighter window/oberon ref oberon
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/oberon }
}

provide-module oberon %§

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/oberon regions
add-highlighter shared/oberon/code default-region group
# add-highlighter shared/oberon/back_string region '`' '`' fill string
add-highlighter shared/oberon/double_string region '"' (?<!\\)(\\\\)*" fill string
# add-highlighter shared/oberon/single_string region "'" (?<!\\)(\\\\)*' fill string
add-highlighter shared/oberon/comment region \(\* \*\) fill comment
add-highlighter shared/oberon/comment_line region '//' $ fill comment

add-highlighter shared/oberon/code/ regex %{-?([0-9]*\.(?!0[xX]))?\b([0-9]+|0[xX][0-9a-fA-F]+)\.?([eE][+-]?[0-9]+)?i?\b} 0:value

evaluate-commands %sh{
    # Grammar
    keywords='ARRAY BEGIN BY CASE CONST DIV DO ELSE ELSIF END FOR IF IMPORT IN
              IS MOD MODULE OF POINTER PROCEDURE RECORD REPEAT RETURN THEN
              TO TYPE UNTIL VAR WHILE'
    types='BOOLEAN CHAR INTEGER REAL BYTE SET'
    values='FALSE NIL TRUE'
    functions='ABS ODD LEN LSL ASR ROR FLOOR FLT ORD CHR INC DEC INCL EXCL NEW ASSERT PACK UNPK'

    join() { sep=$2; eval set -- $1; IFS="$sep"; echo "$*"; }

    # Add the language's grammar to the static completion list
    printf %s\\n "declare-option str-list oberon_static_words $(join "${keywords} ${attributes} ${types} ${values} ${functions}" ' ')"

    # Highlight keywords
    printf %s "
        add-highlighter shared/oberon/code/ regex \b($(join "${keywords}" '|'))\b 0:keyword
        add-highlighter shared/oberon/code/ regex \b($(join "${attributes}" '|'))\b 0:attribute
        add-highlighter shared/oberon/code/ regex \b($(join "${types}" '|'))\b 0:type
        add-highlighter shared/oberon/code/ regex \b($(join "${values}" '|'))\b 0:value
        add-highlighter shared/oberon/code/ regex \b($(join "${functions}" '|'))\b 0:builtin
    "
}

# Commands
# ‾‾‾‾‾‾‾‾

# define-command -hidden go-indent-on-new-line %~
#     evaluate-commands -draft -itersel %=
#         # preserve previous line indent
#         try %{ execute-keys -draft <semicolon>K<a-&> }
#         # indent after lines ending with { or (
#         try %[ execute-keys -draft k<a-x> <a-k> [{(]\h*$ <ret> j<a-gt> ]
#         # cleanup trailing white spaces on the previous line
#         try %{ execute-keys -draft k<a-x> s \h+$ <ret>d }
#         # align to opening paren of previous line
#         try %{ execute-keys -draft [( <a-k> \A\([^\n]+\n[^\n]*\n?\z <ret> s \A\(\h*.|.\z <ret> '<a-;>' & }
#         # copy // comments prefix
#         try %{ execute-keys -draft <semicolon><c-s>k<a-x> s ^\h*\K/{2,} <ret> y<c-o>P<esc> }
#         # indent after a switch's case/default statements
#         try %[ execute-keys -draft k<a-x> <a-k> ^\h*(case|default).*:$ <ret> j<a-gt> ]
#         # indent after if|else|while|for
#         try %[ execute-keys -draft <semicolon><a-F>)MB <a-k> \A(if|else|while|for)\h*\(.*\)\h*\n\h*\n?\z <ret> s \A|.\z <ret> 1<a-&>1<a-space><a-gt> ]
#         # deindent closing brace(s) when after cursor
#         try %[ execute-keys -draft <a-x> <a-k> ^\h*[})] <ret> gh / [})] <ret> m <a-S> 1<a-&> ]
#     =
# ~
# 
# define-command -hidden go-indent-on-opening-curly-brace %[
#     # align indent with opening paren when { is entered on a new line after the closing paren
#     try %[ execute-keys -draft -itersel h<a-F>)M <a-k> \A\(.*\)\h*\n\h*\{\z <ret> s \A|.\z <ret> 1<a-&> ]
# ]
# 
# define-command -hidden go-indent-on-closing-curly-brace %[
#     # align to opening curly brace when alone on a line
#     try %[ execute-keys -itersel -draft <a-h><a-k>^\h+\}$<ret>hms\A|.\z<ret>1<a-&> ]
# ]
# 
# §
