-- run :PackerCompile whenever plugins.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- default value (4s) may lead to noticeable delay and poor plugin experience
vim.o.updatetime = 450

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- lua library for neovim
  use 'nvim-lua/plenary.nvim'

  -- fuzzy finder
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x' }

  -- gruvbox color scheme
  use 'sainnhe/gruvbox-material'

  -- lines/bars
  use 'nvim-lualine/lualine.nvim'

  -- some fancy icons support
  use 'nvim-tree/nvim-web-devicons'

  -- use terminal in neovim
  use { 'akinsho/toggleterm.nvim', tag = '*' }

  -- file explorer
  use 'nvim-tree/nvim-tree.lua'

  -- highlight same words in buffer
  use 'RRethy/vim-illuminate'

  -- lsp manager
  use 'williamboman/mason.nvim'
  -- mason extension to handle intergration with nvim-lspconfig
  use 'williamboman/mason-lspconfig.nvim'
  -- lsp configuration sets
  use 'neovim/nvim-lspconfig'
  -- extend lsp features
  use 'jose-elias-alvarez/null-ls.nvim'

  -- tree-sitter abstraction layer
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- diagnostics
  use 'folke/trouble.nvim'

  -- snippet
  use { 'L3MON4D3/LuaSnip', tag = 'v1.*' }
  use 'rafamadriz/friendly-snippets'

  -- completion
  use 'onsails/lspkind.nvim'
  use 'windwp/nvim-autopairs'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  -- css color highlight
  use 'NvChad/nvim-colorizer.lua'
end)
