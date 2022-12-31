local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- General plugins
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  --[[ use "windwp/nvim-autopairs" -- Close brackets etc. ]]
  use "m4xshen/autoclose.nvim"
  use "numToStr/Comment.nvim" -- Comment support
  use "lukas-reineke/indent-blankline.nvim"
  use "chentoast/marks.nvim"
  use "lervag/vimtex"
  use "norcalli/nvim-colorizer.lua"
  use "tpope/vim-surround"
  --[[ use "sagarrakshe/toggle-bool" ]]
  use "nat-418/boole.nvim"
  use "xorid/swap-split.nvim"
  use "anuvyklack/pretty-fold.nvim" -- pretty folding
  use "folke/zen-mode.nvim"
  use {"shortcuts/no-neck-pain.nvim", tag = "*" }

  -- Colorschemes
  use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "lunarvim/darkplus.nvim"
  use "rebelot/kanagawa.nvim"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp" -- 

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- the LSP engine itself
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"

  -- Null-ls
  use "jose-elias-alvarez/null-ls.nvim"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/Telescope-media-files.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "p00f/nvim-ts-rainbow"
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- git
  use "lewis6991/gitsigns.nvim"

  -- Nvimtree
  -- nvim-web-devicons is installed via require in lualine
  use "kyazdani42/nvim-tree.lua"

  -- Bufferline
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"

  -- Terminal
  use "akinsho/toggleterm.nvim"

  -- SnipRun
  use {
    "michaelb/sniprun",
    run = "bash install.sh"
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
