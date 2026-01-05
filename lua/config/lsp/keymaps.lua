local M = {}

-- Ensure which-key is loaded if you haven't done it elsewhere
local wk_status_ok, whichkey = pcall(require, "which-key")
if not wk_status_ok then
  vim.notify("which-key not found, LSP key hints may not register", vim.log.levels.WARN)
  whichkey = nil -- prevent errors later
end

local function keymappings(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Standard LSP Mappings (consider if Neovim 0.11 defaults are sufficient)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- Default is gd, gD for declaration
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- Default is gri
  vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts) -- Default is gO for document symbols, gt for type def? Check :h lsp-buf-type-definition
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- Default is grr
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Default is grn, use <leader>rn if preferred
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- Default is gra
  vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts) -- Formatting (ensure client supports it)
  vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- Diagnostics

  -- Default diagnostic navigation is [d, ]d, [e, ]e etc. You can keep these if you prefer
  -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true })
  -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true })
  -- vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, { noremap = true, silent = true })
  -- vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, { noremap = true, silent = true })

  -- Whichkey integration
  if whichkey then
    local keymap_l = {
      l = {
        name = "+LSP",
        r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" }, -- Redundant if using <leader>rn or grn
        a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" }, -- Redundant if using <leader>ca or gra
        d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" }, -- Redundant if using <leader>d
        f = { "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", "Format Document" }, -- Redundant if using <leader>f
        i = { "<cmd>LspInfo<CR>", "Lsp Info" },
        s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" }, -- Default is CTRL-S in Insert
        -- Add other actions as needed
      },
    }
    -- Only register format if the client supports it
    if not client.supports_method("textDocument/formatting") then
       keymap_l.l.f = nil
    end

    local keymap_g = {
      g = {
        name = "+Goto",
        d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
        D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
        i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
        t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
        -- Consider adding gO for document symbols
        o = { "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "Document Symbols" },
      },
    }
    whichkey.register(keymap_l, { buffer = bufnr, prefix = "<leader>" })
    whichkey.register(keymap_g, { buffer = bufnr, prefix = "g" })
  end

  -- Optional: Enable built-in LSP completion (opt-in)
  -- if client.supports_method('textDocument/completion') then
  --   vim.lsp.completion.enable(true, { client_id = client.id, bufnr = bufnr, autotrigger = true })
  --   vim.notify("LSP auto-completion enabled for buffer " .. bufnr, vim.log.levels.INFO)
  -- end
end

function M.setup(client, bufnr)
  keymappings(client, bufnr)
end

return M