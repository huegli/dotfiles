# Dracula Pro prompt
PROMPT="%B%F{green}> %F{blue}%2~%F{white}%b "

# Right side prompt
RPROMPT='%F{cyan}%*'

# useful for checking on supported zsh features by version
autoload is-at-least

# change directories w/o cd
setopt AUTO_CD AUTO_PUSHD

# allow corrections
setopt CORRECT

# case sensivite globbing
setopt CASE_GLOB

# history related stuff
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=20000                          # lines remembered per session
SAVEHIST=50000                          # lines stored in history file
setopt EXTENDED_HISTORY                 # detailed history
# setopt SHARE_HISTORY                    # share across sessions
setopt HIST_EXPIRE_DUPS_FIRST           # expire duplicates first
setopt HIST_IGNORE_DUPS                 # do not store duplicates
setopt HIST_FIND_NO_DUPS                # ignore duplicates when searching
setopt HIST_REDUCE_BLANKS               # remove blank lines from history
setopt HIST_VERIFY                      # allow corrections before execution

# ZSH completions
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/nikolai/.zshrc'

autoload -Uz compinit
compinit
autoload -U bashcompinit
bashcompinit

# proper display of Unicode characters 
export LC_ALL=en_US.UTF-8

# Disable Ctrl-S
stty -ixon

# this will add local bin if not already present
[[ :$PATH: == *:$HOME/.local/bin:* ]] || PATH=$HOME/.local/bin:$PATH
 
# source aliases
[ -f $HOME/dotfiles/zsh_alias.sh ] && source $HOME/dotfiles/zsh_alias.sh

# source LS_COLORS
[ -f $HOME/dotfiles/lscolors.sh ] && source $HOME/dotfiles/lscolors.sh

# favorite CLI editor
if [[ -f /usr/bin/kak || -f /usr/local/bin/kak || -f $HOME/.local/bin/kak ]]; then
  export EDITOR=kak
fi

# # source FZF, but make sure both fzf and fd are available
path_to_fzf=$(whence -p fzf)
path_to_fd=$(whence -p fd)
if [[ -x $path_to_fzf && -x $path_to_fd ]]; then

    [ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

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
    eval "$(pipenv --completion)"
fi

# PipX
if [[ -x /usr/bin/register-python-argcomplete3 ]]; then
    eval "$(register-python-argcomplete3 pipx)"
else
    eval "$(register-python-argcomplete pipx)"
fi

# Golang
if [[ -x /usr/local/go ]]; then
    [[ :$PATH: == *:/usr/local/go/bin:* ]] || PATH=$PATH:/usr/local/go/bin
fi

# iTerm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Secure ShellFish Integration
test -e "$HOME/.shellfishrc" && source "$HOME/.shellfishrc"
