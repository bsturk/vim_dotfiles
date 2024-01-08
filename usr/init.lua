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

-- !! This attempts to have a common place for all the plugins
--    but it is SUPER slow launching on Windows
--    The easiest thing to do is just to continually copy over the plugins
--    to the AppData\Local\nvim-data\lazy directory

-- local plugin_path

-- if vim.fn.has("gui_running") and vim.fn.has("win32") then
    -- plugin_path = "G:/.local/share/nvim/lazy"
-- else
    -- plugin_path = vim.fn.stdpath("data") .. "/lazy"
-- end

require("lazy").setup( {
	-- root = plugin_path,      -- only enable this if the above, commented out logic is being used
	spec = "plugins" } )

-- my LSP settings in ~/.vim/lua/lsp.lua

-- print("win32: ", vim.fn.has("win32"))
-- print("win64: ", vim.fn.has("win64"))
-- print("WSL: ", vim.g.in_wsl)

if not vim.fn.has("win32") and not vim.fn.has("win64") and vim.g.in_wsl == 1 then
    require("lsp")
end
