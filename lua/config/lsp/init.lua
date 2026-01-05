-- Holds the on_attach function and common LSP settings

local M = {}

-- This function will be called by Neovim when an LSP server attaches to a buffer
function M.on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O> (if you don't use a completion plugin)
  -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP for formatexpr if desired
  -- vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Configure key mappings for the buffer
  -- It's good practice to require here to avoid circular dependencies
  -- if your main config requires this file first.
  local keymap_status_ok, keymaps = pcall(require, "config.lsp.keymaps")
  if keymap_status_ok then
    keymaps.setup(client, bufnr)
  else
    vim.notify("Failed to load LSP keymaps", vim.log.levels.ERROR)
  end

  -- Optional: Add commands or autocommands specific to LSP attach
  -- Example: Highlight symbol under cursor on CursorHold
  -- vim.api.nvim_create_autocmd("CursorHold", {
  --   buffer = bufnr,
  --   callback = function()
  --     vim.lsp.buf.document_highlight()
  --   end,
  -- })
  -- vim.api.nvim_create_autocmd("CursorMoved", {
  --   buffer = bufnr,
  --   callback = function()
  --     vim.lsp.buf.clear_references()
  --   end,
  -- })

  vim.notify("LSP attached: " .. client.name .. " to buffer " .. bufnr, vim.log.levels.INFO, { title = "LSP" })
end

-- Common LSP client capabilities (if needed)
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities) -- If using nvim-cmp

-- Common flags for LSP servers
M.flags = {
  -- This debounce avoids excessive requests while typing
  debounce_text_changes = 150,
}

-- Store capabilities if you defined them
-- M.capabilities = capabilities

return M
