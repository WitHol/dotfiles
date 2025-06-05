# p10k prompt
source ~/.local/config/zsh/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.local/config/zsh/.p10k.zsh ]] || source ~/.local/config/zsh/.p10k.zsh
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# plugins and prompts
source $XDG_CONFIG_HOME/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# auto complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)	

# moving with ctrl+arrows
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# aliases
alias free="free -h"
alias df="df -h"
alias ls="ls --color"

# Changing the zcompdump location
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

# fastfetch
fastfetch

# no vi mode
bindkey -e
