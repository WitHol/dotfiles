# my custom prompt
precmd() {
    previous_status=$?
    [ $previous_status != 0 ] && printf "\n\e[31mfail: $previous_status\n"
}
PROMPT=$(printf "\e[94m → \e[0m")

# auto complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)	

# syntax highlighting
source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# moving with ctrl+arrows
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Changing the zcompdump location
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

# aliases
alias free="free -h"
alias df="df -h"
alias ls="ls --color"
alias su="su -l"
alias sudo="sudo -E"

export MANPAGER="nvim +Man!"

clear

