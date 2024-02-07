return {

    -- NVIM DEPENDENCIES --

    'nvim-lua/plenary.nvim',        -- async Lua using co-routines, needed for popup below
    'nvim-lua/popup.nvim',          -- port of popup API from vim to nvim

    'junegunn/vim-easy-align',
    'gyim/vim-boxdraw',

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

	{
		'mattia72/vim-delphi',          -- NOTE: this sets mouse=a, I have an autocmd to get around it
		ft = { 'pascal', 'delphi' },
        lazy = true
	},

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
	    config = true 
    },

    -- LSP related --

    'neovim/nvim-lspconfig',

    -- misc --
	
    'christoomey/vim-tmux-navigator',

    -- this one is no longer updated, and I've made changes to it
	
    { dir = '~/.vim/plugins/image.vim' },
}
