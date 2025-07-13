# p10k prompt
source ~/.local/config/zsh/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.local/config/zsh/.p10k.zsh ]] || source ~/.local/config/zsh/.p10k.zsh
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# plugins
source $XDG_CONFIG_HOME/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# auto complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)	

# moving with ctrl+arrows
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Changing the zcompdump location
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

# aliases
alias free="free -h"
alias df="df -h"
alias ls="ls --color"

# changing the cursor style to beam
echo -ne '\e[6 q'

# starting the ssh agent with github access key
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/token
clear

fastfetch
