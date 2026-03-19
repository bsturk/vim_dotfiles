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
              ensure_installed = { "c", "lua", "vim", "vimdoc", "rust", "markdown", "markdown_inline" },
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
      build = ":MasonUpdate", -- Ensures Mason's registry is updated and installs new tools marked for installation
      config = function()
        require('mason').setup() -- Basic setup for Mason
      end,
    },

    -- Mason-lspconfig bridges Mason and nvim-lspconfig
    {
      'williamboman/mason-lspconfig.nvim',
      dependencies = {'williamboman/mason.nvim', 'neovim/nvim-lspconfig'},
      config = function()
        -- This setup function ensures that Mason installs the servers specified
        -- elsewhere (e.g., in your core/lsp.lua or a dedicated mason setup file)
        -- You can also list servers to ensure are installed directly here,
        -- but it's often cleaner to manage the list in your main LSP config.
        require('mason-lspconfig').setup({
           -- Example: List servers you *always* want installed here
           -- ensure_installed = { "lua_ls", "rust_analyzer", "pyright", "clangd" },

           -- Or, setup handlers to automatically use Mason installations
           -- with nvim-lspconfig. This is the more common approach combined
           -- with vim.lsp.enable() in your lsp setup file.
           handlers = {
               -- Default handler function
               function(server_name)
                   require("lspconfig")[server_name].setup({})
               end,
               -- Example custom handler for lua_ls if needed
               -- ["lua_ls"] = function ()
               --     require("lspconfig").lua_ls.setup { ...custom settings... }
               -- end,
           }
        })
      end,
    },

    'folke/which-key.nvim',         -- used in keymaps.lua

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
