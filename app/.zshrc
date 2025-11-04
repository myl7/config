# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Highlight the currently selected item when cycling through completion options with Tab
zstyle ':completion:*' menu select

# Treat slashes as word separators so navigation and editing commands (e.g., Ctrl+W) stop at directory boundaries
WORDCHARS=${WORDCHARS/\/}

# Avoid saving duplicate commands in the history file to reduce its size
# This sacrifices the original command order but keeps unique entries
setopt histignorealldups

# Remove superfluous leading spaces in recorded commands to keep history compact and clean
setopt histreduceblanks

# Check whether a command exists in $PATH
function prog_exists { (( $+commands[$1] )) }

# Allow alias expansion even when the command is prefixed with `sudo`
alias sudo='sudo '

# Make file operations safer by asking for confirmation before overwriting
# `cp -i` → prompt before overwriting existing files
# `mv -i` → prompt before overwriting destination files
# `rm -I` → prompt once if more than three files are being removed
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'

# Enable colorized output for `ls`
alias ls='ls --color=auto'

# Define `ll` as a convenient listing command (long format, human-readable sizes)
# Similar to typical “ll” alias on many systems, but excludes hidden files
alias ll='ls -lh'

# Show transfer progress during rsync operations
alias rsync='rsync -P'

# Remove a space of `sudo vim` to run `sudoedit`, which edits files as root
# while preserving the current user's config
alias sudovim=sudoedit

# If Neovim is installed, make `vim` run `nvim` instead
prog_exists nvim && alias vim=nvim

plugin_dirs=(
  ~/.local/share
  /usr/share
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

source ~/.p10k.zsh

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

[[ -f ~/.zshrcl ]] && source ~/.zshrcl
