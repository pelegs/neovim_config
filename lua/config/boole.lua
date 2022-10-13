local M = {}

function M.setup()
	require 'boole'.setup {
		mappings = {
			increment = '<C-a>',
			decrement = '<C-x>'
		}
	}
end

return M
