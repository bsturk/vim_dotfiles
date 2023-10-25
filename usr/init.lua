-- bootstrap lazy plugin manager

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- plugins I use are listed in ~/.vim/lua/plugins.lua

require("lazy").setup("plugins")

-- my LSP settings in ~/.vim/lua/lsp.lua

-- print("win32: ", vim.fn.has("win32"))
-- print("win64: ", vim.fn.has("win64"))
-- print("WSL: ", vim.g.in_wsl)

if not vim.fn.has("win32") and not vim.fn.has("win64") and vim.g.in_wsl == 1 then
    require("lsp")
end
