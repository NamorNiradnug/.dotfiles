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

" Just useful stuff
Plug 'pocco81/autosave.nvim'
Plug 'iamcco/markdown-preview.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'andweeb/presence.nvim'
Plug 'sbdchd/neoformat'
Plug 'alvan/vim-closetag'
Plug 'windwp/nvim-autopairs'

" Look and feel
Plug 'norcalli/nvim-colorizer.lua'
Plug 'navarasu/onedark.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'

call plug#end()

