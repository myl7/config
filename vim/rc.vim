" Save & restore {{{
"let g:pre_columns=80
"autocmd VimEnter * call Save()
"func Save()
"  let g:pre_columns=&columns
"  set columns=120
"endf
"autocmd VimLeavePre * call Restore()
"func Restore()
"  let &columns=g:pre_columns
"endf
" }}}

" set {{{
set runtimepath+=/etc/vim
set nocompatible
set shortmess+=I
set number relativenumber
set laststatus=2
set backspace=indent,eol,start
set hidden
set ignorecase smartcase incsearch
set noerrorbells visualbell t_vb=
set foldmethod=marker
set tabstop=2 shiftwidth=2 expandtab
set clipboard=unnamedplus
set colorcolumn=80,120
set list listchars=tab:>·,trail:␣
set splitbelow splitright
set undofile
" }}}

syntax on
nmap Q <Nop>
let mapleader=';'

let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark

" Python {{{
autocmd BufRead,BufNewFile *.py call Python()
func Python()
  setlocal tabstop=4 shiftwidth=4
endfunc
" }}}
