require 'lspconfig'.pyright.setup{}
require 'lspconfig'.clangd.setup{}
require 'lspconfig'.cmake.setup{}

function fexist(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end
