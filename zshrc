# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

function cmd_exist { (( $+commands[$1] )) }

alias sudo='sudo '
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'
alias ls='ls --color=auto'
alias ll='ls -lh'
alias rsync='rsync -P'
cmd_exist nvim && alias vim=nvim
alias sudovim=sudoedit

plugin_dirs=(
  /usr/share
  /usr/share/zsh/plugins
  ~/.local/share
)
function plugin_load {
  if [[ $1 =~ '^/.*' ]] && [[ -f $1 ]]; then
    source $1
    return
  fi
  for dir in $plugin_dirs; do
    if [[ -f "$dir/$1" ]]; then
      source "$dir/$1"
      break
    fi
  done
}

cmd_exist fasd && eval "$(fasd --init auto)"
plugin_load zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
plugin_load zsh-autosuggestions/zsh-autosuggestions.zsh
plugin_load powerlevel10k/powerlevel10k.zsh-theme
plugin_load ~/.p10k.zsh
plugin_load /etc/zsh_command_not_found

# zsh-newuser-install
HISTSIZE=100000
SAVEHIST=$HISTSIZE
HISTFILE=~/.histfile
bindkey -e
unsetopt beep
setopt histignorealldups
setopt sharehistory

# compinstall
zstyle :compinstall filename ~/.zshrc
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
WORDCHARS=${WORDCHARS/\/}
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

[[ -f ~/.zshrcl ]] && source ~/.zshrcl
