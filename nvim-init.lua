pcall(require, "initl")

-- @type {boolean|nil} Whether GUI is available
-- gui == nil
-- @type {string|nil} Select code completion impl. Currently only 'copilot' is available.
-- completion == nil

vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.foldmethod = 'marker'
if gui then
  vim.o.clipboard = 'unnamedplus'
end
vim.o.colorcolumn = '80,120'
vim.o.list = true
vim.o.listchars = 'tab:>·,trail:␣'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.undofile = true
vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.visualbell = true
vim.o.t_vb = ''

local function set_indent(indent)
  vim.o.tabstop = indent
  vim.o.shiftwidth = indent
end
set_indent(2)

vim.api.nvim_create_user_command('SetIndent', function(opts)
  local indent = not opts.args and 2 or tonumber(opts.args)
  if indent == nil then
    error 'indent is not an int'
  end
  set_indent(indent)
end, {
  nargs = '?',
  desc = 'Set indent len'
})

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = {'*.py', '*.rs'},
  callback = function()
    set_indent(4)
  end
})

vim.keymap.set('n', 'Q', '', {
  noremap = false
})

vim.fn['plug#begin']()
vim.cmd "Plug 'morhetz/gruvbox'"
vim.cmd "Plug 'preservim/nerdtree'"
vim.cmd "Plug 'vim-airline/vim-airline'"
vim.cmd "Plug 'vim-airline/vim-airline-themes'"
vim.cmd "Plug 'sbdchd/neoformat'"
if completion == 'copilot' then
  vim.cmd "Plug 'github/copilot.vim'"
end
vim.fn['plug#end']()

vim.g.gruvbox_italic = 1
vim.cmd 'colorscheme gruvbox'
vim.g.airline_theme = 'gruvbox'

vim.keymap.set('n', '<A-1>', function()
  vim.api.nvim_command 'NERDTreeToggle'
end)

vim.keymap.set({'n', 'i'}, '<C-A-L>', function()
  vim.api.nvim_command 'Neoformat'
end)

vim.g.neoformat_basic_format_retab = true
vim.g.neoformat_basic_format_trim = true
vim.g.neoformat_try_node_exe = true
