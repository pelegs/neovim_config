local M = {}

function M.setup()
  local luasnip = require "luasnip"
  luasnip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
	}

	-- expansion key
	-- this will expand the current item or jump to the next item within the snippet.
	vim.keymap.set({ "i", "s" }, "<c-e>", function()
		if luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		end
	end, { silent = true })

	-- jump backwards
	-- this always moves to the previous item within the snippet
	vim.keymap.set({ "i", "s" }, "<c-j>", function()
		if luasnip.jumpable(-1) then
			luasnip.jump(-1)
		end
	end, { silent = true })

	-- selecting within a list of options.
	-- This is useful for choice nodes (introduced in the forthcoming episode 2)
	vim.keymap.set("i", "<c-l>", function()
		if luasnip.choice_active() then
			luasnip.change_choice(1)
		end
	end)

	-- vim.o.runtimepath = vim.o.runtimepath .. "," .. os.getenv("HOME") .. "/.config/nvim/nvim/snippets/friendly-snippets,"
	require("luasnip/loaders/from_vscode").lazy_load() -- load snippets of friendly/snippets
	require("luasnip/loaders/from_vscode").lazy_load({ paths = "./snippets" }) -- load your own snippets
end

return M
