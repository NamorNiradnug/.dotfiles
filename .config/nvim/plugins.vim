call plug#begin("~/.config/nvim/plugged/")

" LSP and related
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'p00f/clangd_extensions.nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

" Languages support
Plug 'q60/vim-brainfuck'
Plug 'alaviss/nim.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hiphish/jinja.vim'
Plug 'fladson/vim-kitty'
Plug 'ron-rs/ron.vim'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

" Just useful stuff
Plug 'lervag/vimtex'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'andweeb/presence.nvim'
Plug 'sbdchd/neoformat'
Plug 'alvan/vim-closetag'
Plug 'windwp/nvim-autopairs'
Plug 'rhysd/open-pdf.vim'

" Look and feel
Plug 'norcalli/nvim-colorizer.lua'
Plug 'navarasu/onedark.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'
Plug 'andweeb/presence.nvim'

call plug#end()

