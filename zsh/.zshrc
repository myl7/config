alias sudo='sudo '
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'
alias ls='ls --color=auto'
alias ll='ls -lh'
alias rsync='rsync -P'
(( ! $+commands[nvim] )) || alias vim=nvim
alias sudovim=sudoedit

(( ! $+commands[fasd] )) || eval "$(fasd --init auto)"
f=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ ! -f $f ]] || source $f
f=/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ ! -f $f ]] || source $f
f=/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f $f ]] || source $f
f=/usr/share/doc/pkgfile/command-not-found.zsh
[[ ! -f $f ]] || source $f
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zsh-newuser-install
HISTSIZE=100000000
SAVEHIST=$HISTSIZE
HISTFILE=~/.histfile
unsetopt beep
bindkey -e

# compinstall
zstyle :compinstall filename ~/.zshrc
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
WORDCHARS=${WORDCHARS/\/}
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
setopt -o sharehistory
tabs 4

[[ ! -f ~/.zshrcl ]] || source ~/.zshrcl
