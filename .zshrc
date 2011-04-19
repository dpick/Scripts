autoload -Uz promptinit compinit colors
promptinit
compinit
colors

bindkey -v
bindkey "^?" backward-delete-char
bindkey -M vicmd "^R" redo
bindkey -M vicmd "u" undo
bindkey -M vicmd "ga" what-cursor-position
bindkey -M viins '^p' history-beginning-search-backward
bindkey -M vicmd '^p' history-beginning-search-backward
bindkey -M viins '^n' history-beginning-search-forward
bindkey -M vicmd '^n' history-beginning-search-forward

fpath=(~/.zsh_functions $fpath)
autoload -U ~/.zsh_functions/*(:t)

typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions
 
# Append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.
PATH=/Applications/Shoes.app/Contents/MacOS:$PATH
PATH=~/.scripts:$PATH


zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' max-errors 1
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

HISTFILE=~/.zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt PROMPT_SUBST
setopt correct
setopt appendhistory sharehistory incappendhistory histsavenodups
setopt nobeep
setopt extendedglob
setopt autocd autopushd pushdignoredups

export LSCOLORS=dxfxcxdxbxegedabagacad
alias c="clear"
# alias ls="ls --color=auto -h"
alias ls="ls -G"
alias ll="ls -l"
alias sl="ls --color=auto -h"

PROMPT=$'%{${fg_bold[red]}%}\[%i\] %{${fg[green]}%}\[%{${fg[yellow]}%}%n% %{${fg[green]}%}@%{${fg[blue]}%}%B%~%b%{${fg[green]}%}\]$(prompt_git_info)%{${fg[green]}%} %% %{${fg[white]}%}'

# If I am using vi keys, I want to know what mode I'm currently using.
# # zle-keymap-select is executed every time KEYMAP changes.
# # From http://zshwiki.org/home/examples/zlewidgets
function zle-keymap-select {
   VIMODE="${${KEYMAP/vicmd/ M:command}/(main|viins)/}"
   zle reset-prompt
}

zle -N zle-keymap-select
