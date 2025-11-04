local vim = vim

local prelude
if pcall(require, 'init_prelude') then
  prelude = require('init_prelude')
else
  prelude = {}
  prelude['plugs'] = {}
end

vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.foldmethod = 'marker'
vim.o.colorcolumn = '80,120'
vim.o.list = true
vim.o.listchars = 'tab:>·,trail:␣'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.undofile = true
vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.visualbell = true
vim.o.belloff = 'all'

local function set_indent(indent)
  if indent == 'tab' then
    vim.o.expandtab = false
    indent = 4
  end
  vim.o.tabstop = indent
  vim.o.shiftwidth = indent
end
set_indent(2)

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern={'*.md', '*.py', '*.rs'},
  callback=function() set_indent(4) end
})
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern={'*.go', '*.makefile', 'Makefile'},
  callback=function() set_indent('tab') end
})

vim.keymap.set('n', 'Q', '', {noremap=false})

local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('morhetz/gruvbox')
Plug('vim-airline/vim-airline')
Plug('vim-airline/vim-airline-themes')
for _,v in ipairs(prelude.plugs) do
  Plug(v)
end
vim.call('plug#end')

vim.g.gruvbox_italic = 1
vim.cmd 'colorscheme gruvbox'
vim.g.airline_theme = 'gruvbox'

pcall(require, "initl")
