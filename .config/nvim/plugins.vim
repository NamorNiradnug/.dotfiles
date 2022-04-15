call plug#begin("~/.config/nvim/plugged/")

" Languages support
Plug 'q60/vim-brainfuck'
Plug 'alaviss/nim.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hiphish/jinja.vim'

" Just useful stuff
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'pocco81/autosave.nvim'
Plug 'iamcco/markdown-preview.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'andweeb/presence.nvim'
Plug 'sbdchd/neoformat'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'

" Look and feel
Plug 'norcalli/nvim-colorizer.lua'
Plug 'navarasu/onedark.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'

call plug#end()

