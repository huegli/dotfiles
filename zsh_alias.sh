alias b="batcat --theme base16"
alias e="kak"
alias l="exa --grid --classify --icons"
alias t="tree -d -L 2 | head -n 40"
alias v="bat --theme base16"

alias bd='. bd -si'

alias ll="exa --long --grid --classify --git --icons"
alias lt="exa --tree --level=2 --icons --color=always | bat"

alias t3="tree -d -L 3 | bat --theme base16"

alias yv='bat --theme base16 `fd . -t f -d 1 | fzy`'
alias ye='kak -c `kak -l | head -1` `fd . -t f -d 1 | fzy`'
alias yd='cd `fd . -d 6 -t d | fzy || pwd`'
alias yb='. bd -si `pwd | tr / "\n" | fzy`'

alias bat='batcat --theme base16'

# suffix aliases
alias -s py='batcat --theme base16'
alias -s c='batcat --theme base16'
alias -s h='batcat --theme base16'

