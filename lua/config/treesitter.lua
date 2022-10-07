local M = {}

function M.setup()
	require("nvim-treesitter").setup {
		modules = {
			highlight = {
				additional_vim_regex_highlighting = true,
				custom_captures = {},
				disable = {},
				enable = true,
				module_path = "nvim-treesitter.highlight"
			},
		}
	}
end

return M
