
local M = {}

function M.setup()
	require("sniprun").setup {
	}
	vim.api.nvim_set_keymap('v', '<C-s>', '<Plug>SnipRun', {silent = true})
	vim.api.nvim_set_keymap('n', '<C-s>', '<Plug>SnipRunOperator', {silent = true})
	vim.api.nvim_set_keymap('n', '<C-c>', '<Plug>SnipRun', {silent = true})
	vim.api.nvim_set_keymap('n', '<C-d>', '<Plug>SnipClose', {silent = true})
end

return M
