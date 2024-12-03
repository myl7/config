# Use neovim as the default editor, e.g., for git commit msg
export EDITOR=nvim
export PATH=~/.local/bin:$PATH

# Golang
export PATH=~/.go/bin:$PATH
export GOPATH=~/.local/lib/go
# Rust
export PATH=~/.cargo/bin:$PATH

# Machine-specific config
[[ -f ~/.zshenvl ]] && source ~/.zshenvl
