# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Highlight the hovered item during tab-select
zstyle ':completion:*' menu select
# See slashes as splitters
WORDCHARS=${WORDCHARS/\/}
# Do not save duplicated commands in the history to reduce its size.
# You lose the order of entered commands in the history file but keep the commands themselves.
setopt histignorealldups
# Do not save superfluous spaces in the history to reduce its size
setopt histreduceblanks

# Alias
function prog_exists { (( $+commands[$1] )) }
# Apply alias expansion to commands prefixed with `sudo`
alias sudo='sudo '
# Prompt for possible file overwriting.
# For `rm`, prompt less.
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'
# Add colors for `ls`
alias ls='ls --color=auto'
# Like `ll` command on other distros but without `-a`
alias ll='ls -lh'
# Add progress to rsync
alias rsync='rsync -P'
# Remove a space to run vim as root but with the current user's config
alias sudovim=sudoedit
# Use neovim as vim
prog_exists nvim && alias vim=nvim

# Plugins
plugin_dirs=(
  ~/.local/share /usr/share
  /usr/share/zsh/plugins # For Arch Linux
)
function load_plugin {
  for dir in $plugin_dirs; do if [[ -f $dir/$1 ]]; then
    source $dir/$1; break
  fi; done
}
load_plugin zsh-autosuggestions/zsh-autosuggestions.zsh
load_plugin zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
load_plugin zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Load command-not-found, which is put largely differently among distros
cmd_not_found=/etc/zsh_command_not_found
[[ -f $cmd_not_found ]] && source $cmd_not_found
cmd_not_found=/usr/share/doc/pkgfile/command-not-found.zsh # For Arch Linux
[[ -f $cmd_not_found ]] && source $cmd_not_found

# Theme powerlevel10k config
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt extendedglob
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/myl/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Machine-specific config
[[ -f ~/.zshrcl ]] && source ~/.zshrcl
