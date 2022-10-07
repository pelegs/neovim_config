local M = {}

function M.setup()
	-- Indicate first time installation
	local packer_bootstrap = false

	-- packer.nvim configuration
	local conf = {
		profile = {
			enable = true,
			threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
		},
		display = {
			open_fn = function()
				return require("packer.util").float { border = "rounded" }
			end,
		},
	}

	-- Check if packer.nvim is installed
	-- Run PackerCompile if there are changes in this file
	local function packer_init()
		local fn = vim.fn
		local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
		if fn.empty(fn.glob(install_path)) > 0 then
			packer_bootstrap = fn.system {
				"git",
				"clone",
				"--depth",
				"1",
				"https://github.com/wbthomason/packer.nvim",
				install_path,
			}
			vim.cmd [[packadd packer.nvim]]
		end
		vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
	end

	-- Plugins
	local function plugins(use)
		use { "wbthomason/packer.nvim" }

		-- Colorschemes
		use {
			"rebelot/kanagawa.nvim",
			config = function()
				vim.cmd "colorscheme kanagawa"
			end,
		}

		--[[
		use {
		"sainnhe/everforest",
		config = function()
		vim.cmd "colorscheme everforest"
		end,
		}

		use {
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
		vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
		require("catppuccin").setup()
		vim.api.nvim_command "colorscheme catppuccin"
		end
		}

		use {
		"sainnhe/edge",
		config = function()
		vim.cmd "colorscheme edge"
		end,
		}

		use {
		"sainnhe/sonokai",
		config = function()
		vim.cmd "colorscheme sonokai"
		end,
		}
		--]]

		-- Startup screen
		use {
			"goolord/alpha-nvim",
			config = function()
				require("config.alpha").setup()
			end,
		}

		-- Git
		use {
			"TimUntersberger/neogit",
			cmd = "Neogit",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("config.neogit").setup()
			end,
		}

		-- Treesitter
		use {
			"nvim-treesitter/nvim-treesitter",
			config = function()
				require("config.treesitter").setup()
			end,
		}

		-- WhichKey
		use {
			"folke/which-key.nvim",
			config = function()
				require("config.whichkey").setup()
			end,
		}

		-- IndentLine
		use {
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("config.indentblankline").setup()
			end,
		}

		-- Lualine
		use {
			'nvim-lualine/lualine.nvim',
			requires = { 'kyazdani42/nvim-web-devicons', opt = true },
			config = function()
				require("config.lualine").setup()
			end,
		}

		if packer_bootstrap then
			print "Restart Neovim required after installation!"
			require("packer").sync()
		end
	end

	packer_init()

	local packer = require "packer"
	packer.init(conf)
	packer.startup(plugins)
end

return M
