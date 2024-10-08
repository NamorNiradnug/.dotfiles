call plug#begin("~/.config/nvim/plugged/")

" LSP and related
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
"Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'ray-x/lsp_signature.nvim'
Plug 'p00f/clangd_extensions.nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
" Plug 'rafamadriz/friendly-snippets'

" Languages support
Plug 'q60/vim-brainfuck'
Plug 'alaviss/nim.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
" Plug 'hiphish/jinja.vim'
Plug 'fladson/vim-kitty'
Plug 'ron-rs/ron.vim'
" Plug 'godlygeek/tabular'
" Plug 'preservim/vim-markdown'
" Plug 'bfredl/nvim-ipy'
Plug 'kaarmu/typst.vim'
Plug 'simrat39/rust-tools.nvim'
Plug 'Shirk/vim-gas'

" Just useful stuff
Plug 'lervag/vimtex'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
Plug 'andweeb/presence.nvim'
Plug 'sbdchd/neoformat'
Plug 'alvan/vim-closetag'
Plug 'windwp/nvim-autopairs'
Plug 'jbyuki/venn.nvim'

" Look and feel
Plug 'norcalli/nvim-colorizer.lua'
Plug 'navarasu/onedark.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'
Plug 'andweeb/presence.nvim'
Plug 'SmiteshP/nvim-navic'

call plug#end()
