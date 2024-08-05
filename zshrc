function find_prog { (( $+commands[$1] )) }

alias sudo='sudo '
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'
alias ls='ls --color=auto'
alias ll='ls -lh'
alias rsync='rsync -P'
alias sudovim=sudoedit
find_prog nvim && alias vim=nvim
find_prog micromamba && alias mamba=micromamba

plugin_dirs=(
  /usr/share/zsh/plugins
  /usr/share
  ~/.local/share/zsh/plugins
  ~/.local/share
)
function load_plugin {
  if [[ $1 =~ '^/.*' ]]; then
    [[ -f $1 ]] && source $1
    return
  fi
  for dir in $plugin_dirs; do
    if [[ -f "$dir/$1" ]]; then
      source "$dir/$1"
      break
    fi
  done
}

find_prog fasd && eval "$(fasd --init auto)"
load_plugin zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
load_plugin zsh-autosuggestions/zsh-autosuggestions.zsh
load_plugin powerlevel10k/powerlevel10k.zsh-theme
load_plugin /etc/zsh_command_not_found

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

[[ -f ~/.zshrcl ]] && source ~/.zshrcl
