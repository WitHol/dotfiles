# plugins and prompts
source $XDG_CONFIG_HOME/zsh/powerlevel10k/.p10k.zsh
source $XDG_CONFIG_HOME/zsh/powerlevel10k/powerlevel10k.zsh-theme
source $XDG_CONFIG_HOME/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# auto complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)	

# vi mode in completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# vi mode
bindkey -v
export KEYTIMEOUT=1

# change cursor in vi mode
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
       [[ $1 == 'block' ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] || 
	 [[ ${KEYMAP} == viins ]] ||
	 [[ ${KEYMAP} = '' ]] ||
	 [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
}
zle-keymap-select
zle -N zle-keymap-select

# moving with ctrl+arrows
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# aliases
alias free="free -h"
alias df="df -h"
alias ls="ls --color"
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
