set hidden
set number relativenumber
set ignorecase smartcase
set foldmethod=marker
set tabstop=2 shiftwidth=2 expandtab
set clipboard=unnamedplus
set colorcolumn=80,120
set list listchars=tab:>·,trail:␣
set splitbelow splitright
set undofile

nmap Q <nop>

let g:gruvbox_italic=1
colorscheme gruvbox

" Python {{{
autocmd BufRead,BufNewFile *.py call Python()
func Python()
  setlocal tabstop=4 shiftwidth=4
endfunc
" }}}

let $lua_rc='/etc/xdg/nvim/rc.lua'
if filereadable($lua_rc)
  source $lua_rc
endif
