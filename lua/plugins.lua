return {

    -- NVIM DEPENDENCIES --

    'nvim-lua/plenary.nvim',

    {
      "nvim-treesitter/nvim-treesitter",
      branch   = 'master',
      lazy     = false,
      priority = 1000,

      -- load if not on Windows
      cond = function()
      	return not (jit and jit.os and jit.os:find("Windows"))
      end,
      build = ":TSUpdate",
      config = function()
          local configs = require("nvim-treesitter.configs")

          configs.setup(
          {
              ensure_installed = { "c", "lua", "vim", "vimdoc", "rust", "python", "markdown", "markdown_inline" },
              sync_install     = false,
              highlight        = { enable = true },
              indent           = { enable = true }
          })
      end
    },

    -- LSP RELATED --

    'neovim/nvim-lspconfig',

    {
      'williamboman/mason.nvim',
      build = ":MasonUpdate",
      config = function()
        require('mason').setup()
      end,
    },

    {
      'williamboman/mason-lspconfig.nvim',
      dependencies = {'williamboman/mason.nvim', 'neovim/nvim-lspconfig'},
      config = function()
        require('mason-lspconfig').setup({
           ensure_installed = { "clangd", "rust_analyzer", "pylsp", "lua_ls" },
           handlers = {
               -- Default handler for all servers
               function(server_name)
                   require("lspconfig")[server_name].setup({
                       flags = { debounce_text_changes = 150 },
                   })
               end,
               -- lua_ls: skip default handler, configured below
               ["lua_ls"] = function() end,
           }
        })
      end,
    },

    'folke/which-key.nvim',         -- used in keymaps

    -- repl --

    'jalvesaq/vimcmdline',          -- all purpose REPL support in nvim's terminal, sends code to a repl
    'axvr/zepl.vim',
    -- 'Olical/conjure',               -- all purpose REPL support in nvim's terminal or stdio

    -- LANG/SYNTAX SUPPORT --

	-- Powershell

	{
		'PProvost/vim-ps1',
		ft = 'powershell',
        lazy = true
	},

	-- Hy

	{
		'hylang/vim-hy',
		ft = 'hy',
        lazy = true
	},


	-- Zig

	{
		'ziglang/zig.vim',
		ft = 'zig',
        lazy = true
	},

	-- Fennel

	{
		'bakpakin/fennel.vim',
		ft = 'fennel',
        lazy = true
	},

	-- Julia

	{
		'JuliaEditorSupport/julia-vim',

        -- Already lazy-loaded, gives error when using lazy plugin load
		-- ft = 'julia',
        -- lazy = true
	},

    -- Rust

	{
		'rust-lang/rust.vim',
		ft = 'rust',
        lazy = true,

		dependencies = {
			'BurntSushi/ripgrep'           -- dependency for rust-lang, a binary
		}
	},

    -- Pascal

	-- {
		-- 'mattia72/vim-delphi',          -- NOTE: disabled, this sets mouse=a, I have an autocmd to get around it and it doesn't work
		-- ft = { 'pascal', 'delphi' },
        -- lazy = true
	-- },

	-- C/C++

	{
		'derekwyatt/vim-fswitch',
		ft = { 'c', 'cpp' },
        lazy = true
	},

    -- vintage computer stuff --

	{
        'bakudankun/pico-8.vim',
		dependencies = {
            'markbahnman/vim-pico8-color',
        },
        ft = 'pico8',
        lazy = true
    },

	{
        'caglartoklu/qb64dev.vim',
        ft = 'basic',
        lazy = true
    },

    -- general dev --

    {
		'RaafatTurki/hex.nvim',
	    config = true,
        opts = { is_file_binary_post_read = function() return false end, }
    },

    -- AI related --

    -- 'github/copilot.vim',

    -- usability/enhancements --

    { 'tpope/vim-fugitive' },

    { 'vim-airline/vim-airline',
      config = function()
            vim.g['airline#extensions#whitespace#enabled'] = 0
            vim.g['airline#extensions#tagbar#enabled'] = 0
            vim.g['airline#extensions#gutentags#enabled'] = 0
        end,
    },

    -- misc --

    'christoomey/vim-tmux-navigator',
    'junegunn/vim-easy-align',
    'gyim/vim-boxdraw',

    -- this one is no longer updated, and I've made changes to it

    { dir = vim.fn.expand('$VIMHOME') .. '/plugins/image.vim' },
}
