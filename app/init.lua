vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.foldmethod = 'marker'
vim.o.colorcolumn = '80,100'
vim.o.list = true
vim.o.listchars = 'tab:>·,trail:␣'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.undofile = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.belloff = 'all'

-- Per-filetype indent (buffer-local). Pass 'tab' for noexpandtab.
local function set_indent(indent)
  if indent == 'tab' then
    vim.bo.expandtab = false
    indent = 4
  else
    vim.bo.expandtab = true
  end
  vim.bo.tabstop = indent
  vim.bo.shiftwidth = indent
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'python', 'rust'},
  callback = function() set_indent(4) end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'go', 'make'},
  callback = function() set_indent('tab') end,
})

vim.keymap.set('n', 'Q', '', {noremap = false})  -- disable Ex mode
vim.keymap.set('n', '<A-1>', ':Ex<CR>', {silent = true})

-- Optional per-machine config (lua/initl.lua)
pcall(require, 'initl')
