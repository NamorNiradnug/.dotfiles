call plug#begin()

" Languages support
Plug 'q60/vim-brainfuck'
Plug 'alaviss/nim.nvim'
Plug 'sheerun/vim-polyglot'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Just useful stuff
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'pocco81/autosave.nvim'
Plug 'iamcco/markdown-preview.nvim'
Plug 'kassio/neoterm'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'andweeb/presence.nvim'

" Look and feel
Plug 'norcalli/nvim-colorizer.lua'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

call plug#end()
