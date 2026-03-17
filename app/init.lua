-- Optional per-machine prelude (extra plugins, etc.)
local prelude
if pcall(require, 'init_prelude') then
  prelude = require('init_prelude')
else
  prelude = {}
  prelude['plugs'] = {}
end

-- Options
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
vim.o.tabstop = 4
vim.o.shiftwidth = 4
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
  pattern = {'yaml', 'json'},
  callback = function() set_indent(2) end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'go', 'make'},
  callback = function() set_indent('tab') end,
})

-- Keymaps
vim.keymap.set('n', 'Q', '', {noremap = false})  -- disable Ex mode

-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
local plugins = {
  {
    'morhetz/gruvbox',
    priority = 1000,
    config = function()
      vim.g.gruvbox_italic = 1
      vim.cmd('colorscheme gruvbox')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = { theme = 'gruvbox' },
    },
  },
}
for _, v in ipairs(prelude.plugs) do
  table.insert(plugins, { v })
end

require('lazy').setup(plugins)

-- Optional per-machine local config (lua/init_local.lua)
pcall(require, 'init_local')
