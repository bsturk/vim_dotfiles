-- print(vim.api.nvim_get_option('runtimepath'))

vim.g.mapleader      = "\\"
vim.g.maplocalleader = "\\"

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

require("lazy").setup({
  spec = "plugins"      -- look in plugins file for all plugins I'm using
})

-- require("cscope_maps").setup()

-- my LSP settings in ~/.vim/lua/lsp.lua

-- print("win32: ", vim.fn.has("win32"))
-- print("win64: ", vim.fn.has("win64"))
-- print("WSL: ", vim.g.in_wsl)

------------------------------------------------------------------------
-- LSP server config
------------------------------------------------------------------------

vim.lsp.config("lua_ls", {
    flags = { debounce_text_changes = 150 },
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
})

------------------------------------------------------------------------
-- LSP: diagnostics, keymaps, completion (via LspAttach autocmd)
------------------------------------------------------------------------

vim.diagnostic.config({
    virtual_text     = { spacing = 4, prefix = "●" },
    signs            = true,
    underline        = true,
    update_in_insert = false,
    float            = { border = "rounded", source = true },
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf
        if not client then return end

        -- keymaps (buffer-local)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>f",  function() vim.lsp.buf.format { async = true } end, opts)
        vim.keymap.set("n", "<leader>d",  vim.diagnostic.open_float, opts)

        -- which-key v3 hints
        local wk_ok, wk = pcall(require, "which-key")
        if wk_ok then
            local leader = {
                { "<leader>l",  group = "LSP" },
                { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>",         desc = "Rename" },
                { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>",    desc = "Code Action" },
                { "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>",  desc = "Line Diagnostics" },
                { "<leader>li", "<cmd>LspInfo<CR>",                          desc = "Lsp Info" },
                { "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "Signature Help" },
            }
            if client.supports_method("textDocument/formatting") then
                table.insert(leader, { "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", desc = "Format Document" })
            end
            wk.add(leader)
            wk.add({
                { "g",  group = "Goto" },
                { "gd", desc = "Definition" },
                { "gD", desc = "Declaration" },
                { "gi", desc = "Implementation" },
                { "go", desc = "Type Definition" },
                { "gO", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", desc = "Document Symbols" },
            })
        end

        -- completion (nvim 0.11+)
        if client.supports_method("textDocument/completion") then
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
            vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
        end

        -- highlight symbol under cursor
        if client.supports_method("textDocument/documentHighlight") then
            vim.api.nvim_create_autocmd("CursorHold", {
                buffer = bufnr,
                callback = function() vim.lsp.buf.document_highlight() end,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                buffer = bufnr,
                callback = function() vim.lsp.buf.clear_references() end,
            })
        end
    end,
})
