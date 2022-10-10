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

		use {
			"rcarriga/nvim-notify",
		}

		-- LSP
		use {
			"neovim/nvim-lspconfig",
			opt = true,
			event = "BufReadPre",
			wants = { "nvim-lsp-installer" },
			config = function()
				require("config.lsp").setup()
			end,
			requires = {
				"williamboman/nvim-lsp-installer",
			},
		}

		-- COQ
		use {
			"ms-jpq/coq_nvim",
			branch = "coq",
			event = "InsertEnter",
			opt = true,
			run = ":COQdeps",
			config = function()
				require("config.coq").setup()
			end,
			requires = {
				{ "ms-jpq/coq.artifacts", branch = "artifacts" },
				{ "ms-jpq/coq.thirdparty", branch = "3p", module = "coq_3p" },
			},
			disable = false,
		}

		-- Luasnip?
		use 'L3MON4D3/LuaSnip'
		use 'mendes-davi/coq_luasnip'
		use 'rafamadriz/friendly-snippets'

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

		-- Surrounding ysw)
		use 'tpope/vim-surround'

		-- Commenting gcc/gc
		use 'tpope/vim-commentary'

		-- Nerdtree navigation
		use {
			'preservim/nerdtree',
			config = function()
				require("config.nerdtree").setup()
			end,
		}

		-- Sniprun
		use {
			'michaelb/sniprun',
			run = "bash install.sh",
			config = function()
				require("config.sniprun").setup()
			end,
		}

		-- Visible marks
		use {
			'chentoast/marks.nvim',
			config = function()
				require("config.marks").setup()
			end,
		}

		-- Tagsbar
		use 'preservim/tagbar'

		-- Gutentags
		use 'ludovicchabant/vim-gutentags'

		-- Markdown preview
		use {
			'iamcco/markdown-preview.nvim',
		}

		-- BOOTSTRAP
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
