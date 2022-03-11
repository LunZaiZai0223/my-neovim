language en_US

" enables syntax highlighting
syntax on

" Better colors
set termguicolors

" number of spaces in a <Tab>
set tabstop=2
set softtabstop=2
set expandtab

" enable autoindents
set smartindent

" number of spaces used for autoindents
set shiftwidth=2

" adds line numbers
set number

" columns used for the line number
set numberwidth=4

" highlights the matched text pattern when searching
set incsearch

" open splits intuitively
set splitbelow
set splitright

" navigate buffers without losing unsaved work
set hidden

" start scrolling when 8 lines from top or bottom
set scrolloff=10

" Save undo history
set undofile

" Enable mouse support
set mouse=a

" case insensitive search unless capital letters are used
set ignorecase
set smartcase

" do not show mode
set noshowmode

" use system clipboard
set clipboard=unnamed

" no swap file
set noswapfile
set nobackup

" add cursorline
set cursorline

set fileencoding=utf-8

" cursor blinking
set guicursor=a:blinkon100
" set signcolumn=number

call plug#begin('~/.config/nvim/plugged')

" plugins will go here
Plug 'EdenEast/nightfox.nvim'

" Telescope requires plenary to function
Plug 'nvim-lua/plenary.nvim'
" The main Telescope plugin
Plug 'nvim-telescope/telescope.nvim'
" An optional plugin recommended by Telescope docs
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make' }

" vim-fugitive
Plug 'tpope/vim-fugitive'

" gitsigns
Plug 'lewis6991/gitsigns.nvim'

" lualine
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'

" lsp
Plug 'neovim/nvim-lspconfig'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'onsails/lspkind-nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'windwp/nvim-ts-autotag'

" Buffer
Plug 'akinsho/bufferline.nvim'

" File explorer
Plug 'kyazdani42/nvim-tree.lua'

" Auto pair
Plug 'windwp/nvim-autopairs'

" Indent
Plug 'lukas-reineke/indent-blankline.nvim'

" Quickly comment
Plug 'numToStr/Comment.nvim'

" Rainbow parentheses
Plug 'p00f/nvim-ts-rainbow'

" Shade screen 
Plug 'sunjon/shade.nvim'

" Color preview
Plug 'norcalli/nvim-colorizer.lua'

" LSP Colors
Plug 'folke/lsp-colors.nvim'

" Surround
Plug 'tpope/vim-surround'

" Null-ls
Plug 'jose-elias-alvarez/null-ls.nvim'

" Check Spelling
Plug 'kamykn/spelunker.vim'

" Trouble
Plug 'folke/trouble.nvim'

call plug#end()

lua require('lun')
" lua require('lun/lightline')

" remaps
let mapleader = ' '
nnoremap <C-p> :Telescope find_files<Cr>
nnoremap <leader>l :wincmd l<Cr>
nnoremap <leader>h :wincmd h<Cr>
nnoremap <silent><leader>[ :BufferLineCyclePrev<Cr>
nnoremap <silent><leader>] :BufferLineCycleNext<Cr>
nnoremap <silent><leader>q :bdelete<Cr>
" toggle hlsearch
nnoremap <leader>n :set hlsearch!<CR>
" toggle trouble in current file
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>

" To always use the snazzy color scheme 
colorscheme Nordfox

