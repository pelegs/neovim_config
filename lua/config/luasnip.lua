local M = {}

function M.setup()
  local luasnip = require "luasnip"
  luasnip.config.set_config {
    history = false,
    updateevents = "TextChanged,TextChangedI",
  }

	vim.o.runtimepath = vim.o.runtimepath .. "," .. os.getenv("HOME") .. "/.config/nvim/nvim/snippets/friendly-snippets,"
	require("luasnip/loaders/from_vscode").lazy_load() -- load snippets of friendly/snippets
	require("luasnip/loaders/from_vscode").lazy_load({ paths = "~/.config/nvim/nvim/snippets/friendly-snippets" }) -- load your own snippets
end

return M
