-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.6',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

 use { "catppuccin/nvim", as = "catppuccin" }
 use ({
	  'rose-pine/neovim',
	  as = 'rose-pine',
  })
  use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate', highlights = {enable = true, disable = {'go'}}})
  use ('nvim-treesitter/playground')
  use ('theprimeagen/harpoon')
  use ('mbbill/undotree')
  use ('tpope/vim-fugitive')

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  {'neovim/nvim-lspconfig'},
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'L3MON4D3/LuaSnip'},
	  }
  }
  use {
      "williamboman/mason.nvim"
  }
  use {
      "williamboman/mason-lspconfig.nvim"
  }
  use "lukas-reineke/indent-blankline.nvim"

  use({
      "Pocco81/auto-save.nvim",
      config = function()
          require("auto-save").setup {
              -- your config goes here
              -- or just leave it empty :)
          }
      end,
  })
use { "rcarriga/nvim-notify" }

use {
  "klen/nvim-test",
  config = function()
    require('nvim-test').setup()
  end
}
end)
