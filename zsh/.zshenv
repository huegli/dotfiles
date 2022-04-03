# For dotfiles
export XDG_CONFIG_HOME="$HOME/.config"

# For specific data
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"

# For cached files
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# favorite CLI editor
if [[ -f /usr/bin/nvim || -f /usr/local/bin/nvim || -f $HOME/.local/bin/nvim ]]; then
	export EDITOR="nvim"
	export VISUAL="nvim"
fi

# ZSH folder
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# History filepath
export HISTFILE="$ZDOTDIR/.zhistory"
# Maximum events for internal history
export HISTSIZE=10000
# Maximum events in history file
export SAVEHIST=10000

# Dotfile location
export DOTFILES="$HOME/dotfiles"

# Host-specific settings
if [[ "`hostname`" = "clockworkpi-a06" ]]; then
    export DOCKER_HOST=ssh://rpi3m-swarm-mgr1
    export PAN_MESA_DEBUG="gl3"
fi
 
# proper display of Unicode characters 
export LC_ALL=en_US.UTF-8

# this will add local bin if not already present
[[ :$PATH: == *:$HOME/.local/bin:* ]] || PATH=$HOME/.local/bin:$PATH
 

