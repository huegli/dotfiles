# VI mode
bindkey -v
export KEYTIMEOUT=40

# For VI mode 
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Exit Insert mode with 'jk'
bindkey -M viins 'jk' vi-cmd-mode 

# NeoVim for command line edit
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Dracula Pro prompt
if [[ -z $SSH_CONNECTION ]]; then
    PROMPT="%B%F{green}> %F{blue}%2~%F{white}%b "
else
    if [[ `hostname -s` == "static" ]]; then
        PROMPT="%B%F{magenta}remote-macmini%F{green}> %F{blue}%2~%F{white}%b "
    else
        PROMPT="%B%F{magenta}%m%F{green}> %F{blue}%2~%F{white}%b "
    fi
fi

# Right side prompt
RPROMPT='%F{cyan}%*'

# useful for checking on supported zsh features by version
autoload is-at-least

# change directories w/o cd
setopt AUTO_CD AUTO_PUSHD
# Do not store duplicate directories in the stack
setopt PUSHD_IGNORE_DUPS
# Do not print the directory stack after using pushd or popd
setopt PUSHD_SILENT

# insert slash after directory
setopt AUTO_PARAM_SLASH

# allow corrections
setopt CORRECT

# case sensivite globbing
setopt CASE_GLOB

setopt EXTENDED_HISTORY                 # detailed history
setopt HIST_EXPIRE_DUPS_FIRST           # expire duplicates first
setopt HIST_IGNORE_DUPS                 # do not store duplicates
setopt HIST_FIND_NO_DUPS                # ignore duplicates when searching
setopt HIST_REDUCE_BLANKS               # remove blank lines from history
setopt HIST_VERIFY                      # allow corrections before execution

# ZSH completions
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/nikolai/.zshrc'

# additional ZSH completions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

# completion (both zsh and bash)
autoload -Uz compinit
compinit
autoload -U bashcompinit
bashcompinit

# Autocomplete hidden files
_comp_options+=(globdots)

# source extra completion from presto
source ~/dotfiles/zsh/external/completion.zsh
# bd command
source ~/dotfiles/zsh/external/bd.zsh

# for autoloading everything in external directory
fpath=($ZDOTDIR/external $fpath)

# Disable Ctrl-S
stty -ixon

# Changing Cursor
autoload -Uz cursor_mode && cursor_mode

# source aliases
[ -f $XDG_CONFIG_HOME/zsh/aliases ] && source $XDG_CONFIG_HOME/zsh/aliases

# source LS_COLORS
[ -f $HOME/dotfiles/lscolors.sh ] && source $HOME/dotfiles/lscolors.sh

# # source FZF, but make sure both fzf and fd are available
path_to_fzf=$(whence -p fzf)
path_to_fd=$(whence -p fd)
if [[ -x $path_to_fzf && -x $path_to_fd ]]; then

    [ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

    # mutually exclusive to the above
    [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
    [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

    # mutually exclusive to the above
    [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
    [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh

    # mutually exclusive to the above
    [ -f /usr/local/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/local/share/doc/fzf/examples/key-bindings.zsh
    [ -f /usr/local/share/doc/fzf/examples/completion.zsh ] && source /usr/local/share/doc/fzf/examples/completion.zsh

    export FZF_ALT_C_COMMAND='fd -d 4 -t d -L'
    export FZF_ALT_C_OPTS="--preview 'tree -L 2 -C {} | head -200'"
    export FZF_TMUX=1

fi
 
# zoxide
if command -v zoxide > /dev/null; then
    eval "$(zoxide init zsh)"
fi
 
# PipEnv
if command -v pipenv > /dev/null; then
    export WORKON_HOME=$HOME/.virtualenvs
    # Need to revisit this
    # eval "$(pipenv --completion)"
fi

# PipX
#if [[ -x /usr/bin/register-python-argcomplete3 ]]; then
#    eval "$(register-python-argcomplete3 pipx)"
#else
#    eval "$(register-python-argcomplete pipx)"
#fi

# Golang
if [[ -x /usr/local/go ]]; then
    [[ :$PATH: == *:/usr/local/go/bin:* ]] || PATH=$PATH:/usr/local/go/bin
fi

# iTerm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Secure ShellFish Integration
test -e "$HOME/.shellfishrc" && source "$HOME/.shellfishrc"

# ZSH syntax highlighting
test -e "/usr/local/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" &&
    source "/usr/local/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
test -e "/usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"  &&
    source "/usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
