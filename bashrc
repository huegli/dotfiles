#########
# Aliases
#########

alias ll="ls -lhA"
alias dir="ls -l"
alias vm="ssh -Y nschlegel@scv-nschlegel01.csg.apple.com"
alias v="vim"

#############
# Other Stuff
#############
set -o vi
export PS1="[\h] \w % "

################################################################################################
## Perforce
export P4IGNORE=.p4ignore
export P4CONFIG=.p4config
export P4EDITOR=vim
export P4USER=nschlegel

export P4PORT=scv-vlsip4.csg.apple.com:1668

## This needs to have the P4V application installed
export P4MERGE=/Applications/p4merge.app/Contents/MacOS/p4merge

# setup_project dummy
function setup_project {
    client='nschlegel_'
    client+=$1
    client+='_www'
    export P4CLIENT=$client
}
