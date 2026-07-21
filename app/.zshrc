# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

plugin_dirs=(
  ~/.local/share
  /usr/share
  /opt/homebrew/share
  /usr/share/zsh/plugins # For Arch Linux
)
function load_plugin {
  local dir
  for dir in $plugin_dirs; do if [[ -f $dir/$1 ]]; then
    source $dir/$1; break
  fi; done
}
load_plugin zsh-autosuggestions/zsh-autosuggestions.zsh
load_plugin zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
load_plugin powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias sudo='sudo '
alias ls='ls --color=auto'

export EDITOR=nvim
alias sudonvim=sudoedit

export PATH=~/.local/bin:$PATH

# Check whether a command exists in $PATH
# function cmd_exists { (( $+commands[$1] )) }

# eval $(/opt/homebrew/bin/brew shellenv)
# export PATH=$(brew --prefix rustup)/bin:$PATH
# export PATH=~/go/bin:$PATH
# export PATH=~/.cargo/bin:$PATH

# alias cc='claude --allow-dangerously-skip-permissions --permission-mode bypassPermissions'
# alias cx='codex --yolo'
