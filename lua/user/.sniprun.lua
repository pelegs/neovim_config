local M = {}

function M.setup()
	require("sniprun").setup {
	}
	vim.api.nvim_set_keymap('v', '<leader>s', '<Plug>SnipRun', {silent = true})
	vim.api.nvim_set_keymap('n', '<c-s>', '<Plug>SnipRunOperator', {silent = true})
	vim.api.nvim_set_keymap('n', '<c-c>', '<Plug>SnipRun', {silent = true})
	vim.api.nvim_set_keymap('n', '<c-d>', '<Plug>SnipClose', {silent = true})
end

return M
