# Deduplicate PATH entries (prevents accumulation in nested shells)
typeset -U path

# User-local binaries (e.g., pipx, manually installed tools)
export PATH=~/.local/bin:$PATH

# Check whether a command exists in $PATH
function cmd_exists { (( $+commands[$1] )) }

# Default editor for shell commands (git commit, sudoedit, etc.)
# Falls back to vim if nvim is not installed
if cmd_exists nvim; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

# Golang
export PATH=~/go/bin:$PATH
# Rust
export PATH=~/.cargo/bin:$PATH

# Source machine-local zshenv overrides if present
[[ -f ~/.zshenvl ]] && source ~/.zshenvl
