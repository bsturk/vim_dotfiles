return {

    -- dependencies

    'nvim-lua/plenary.nvim',        -- async Lua using co-routines, needed for popup below
    'nvim-lua/popup.nvim',          -- port of popup API from vim to nvim

    'junegunn/vim-easy-align',
    'gyim/vim-boxdraw',
    'christoomey/vim-tmux-navigator',

    -- repl

    'jalvesaq/vimcmdline',          -- all purpose REPL support in nvim's terminal

    -- lang/syntax support

    'PProvost/vim-ps1',
    'hylang/vim-hy',
    'ziglang/zig.vim',
    'bakpakin/fennel.vim',

    -- Rust

    'rust-lang/rust.vim',
    'BurntSushi/ripgrep',           -- dependency for rust-lang, a binary

    -- Pascal

    'mattia72/vim-delphi',

    -- vintage computer stuff

    'bakudankun/pico-8.vim',
    'markbahnman/vim-pico8-color',
    'spicyjack/atari8-tools.vim',
    'caglartoklu/qb64dev.vim',

    -- general dev

    { 'RaafatTurki/hex.nvim', config = true, },
    'derekwyatt/vim-fswitch',
    
    -- LSP related

    'neovim/nvim-lspconfig',

    -- this one is no longer updated, and I've made changes to it
    { dir = '~/.vim/plugins/image.vim' },
}
