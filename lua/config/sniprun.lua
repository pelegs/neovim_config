
local M = {}

function M.setup()
	require 'sniprun'.setup {
	}
  vim.api.nvim_set_keymap("v", "<C-s>", "<cmd>'<,'>SnipRun<CR>", { noremap = true, silent = true })
end

return M
