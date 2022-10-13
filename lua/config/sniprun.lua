
local M = {}

function M.setup()
	require("sniprun").setup {
	}
	vim.api.nvim_set_keymap('v', 'fs', '<Plug>SnipRun', {silent = true})
	vim.api.nvim_set_keymap('n', 'fa', '<Plug>SnipRunOperator', {silent = true})
	vim.api.nvim_set_keymap('n', 'ff', '<Plug>SnipRun', {silent = true})
	vim.api.nvim_set_keymap('n', 'fd', '<Plug>SnipClose', {silent = true})
end

return M
