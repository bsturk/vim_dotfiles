-- NOTE: LSP is slow so give things a chance to work before assuming things aren't working

-- Provide some indication that lsp is busy!
local lsp_status = require('lsp-status')
lsp_status.register_progress()

-- LSP completion

require('cmp').setup {
  sources = {
    { name = 'nvim_lsp' }
  }
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').rust_analyzer.setup {
    capabilities = capabilities,
}

----------------------- RUST --------------------------

-- use rust-tools

local rust_opts = {
  tools = {
    autoSetHints = true,
    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
      },
    },

  -- all the opts to send to nvim-lspconfig, overriding defaults
  -- https://rust-analyzer.github.io/manual.html#features
  server = {

    on_attach = lsp_status.on_attach,
    capabilities = lsp_status.capabilities,

    settings = {
      ["rust-analyzer"] = {
        assist = {
          importEnforceGranularity = true,
          importPrefix = "crate"
          },
        cargo = {
          allFeatures = true
          },
        checkOnSave = {
          -- default: `cargo check`
          command = "clippy"
          },
        },
        inlayHints = {
          lifetimeElisionHints = {
            enable = true,
            useParameterNames = true
          },
        },
      }
    },
}
require('rust-tools').setup(rust_opts)

----------------------- PYTHON --------------------------
----------------------- C/C++  --------------------------
----------------------- LISP  --------------------------
----------------------- SH  --------------------------