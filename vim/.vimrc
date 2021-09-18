set mouse=

nnoremap <leader>j :NERDTreeToggle<CR>
nnoremap <leader>l :Autoformat<CR>
nnoremap <leader>p :MarkdownPreviewToggle<CR>

let b:autoformat_columnlimit=120

let $local_vimrc=expand('~/.vimrcl')
if filereadable($local_vimrc)
  source $local_vimrc
endif
