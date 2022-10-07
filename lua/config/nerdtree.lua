local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local M = {}
function M.setup()
	map('n', '<C-f>', '<cmd>NerdTreeFocus<CR>')
	map('n', '<C-n>', '<cmd>NERDTree<CR>')
	map('n', '<C-t>', '<cmd>NERDTreeToggle<CR>')
end

return M
