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

	-- python __init__ thingy
	local ls        = require"luasnip"
	local s         = ls.snippet
	local sn        = ls.snippet_node
	local t         = ls.text_node
	local i         = ls.insert_node
	local c         = ls.choice_node
	local d         = ls.dynamic_node
	local r         = ls.restore_node
	local fmt       = require("luasnip.extras.fmt").fmt

	-- see latex infinite list for the idea. Allows to keep adding arguments via choice nodes.
	local function py_init()
		return
		sn(nil, c(1, {
			t(""),
			sn(1, {
				t(", "),
				i(1),
				d(2, py_init)
			})
		}))
	end

	-- splits the string of the comma separated argument list into the arguments
	-- and returns the text-/insert- or restore-nodes
	local function to_init_assign(args)
		local tab = {}
		local a = args[1][1]
		if #(a) == 0 then
			table.insert(tab, t({"", "\tpass"}))
		else
			local cnt = 1
			for e in string.gmatch(a, " ?([^,]*) ?") do
				if #e > 0 then
					table.insert(tab, t({"","\tself."}))
					-- use a restore-node to be able to keep the possibly changed attribute name
					-- (otherwise this function would always restore the default, even if the user
					-- changed the name)
					table.insert(tab, r(cnt, tostring(cnt), i(nil,e)))
					table.insert(tab, t(" = "))
					table.insert(tab, t(e))
					cnt = cnt+1
				end
			end
		end
		return
		sn(nil, tab)
	end

	-- create the actual snippet
	s("pyinit", fmt(
	[[def __init__(self{}):{}]],
	{
		d(1, py_init),
		d(2, to_init_assign, {1})
	}))
end

return M
