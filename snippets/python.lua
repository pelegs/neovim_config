local ls = require("luasnip") --{{{

local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
local file_pattern = "*.py"

local function cs(trigger, nodes, opts) --{{{
	local snippet = s(trigger, nodes)
	local target_table = snippets

	local pattern = file_pattern
	local keymaps = {}

	if opts ~= nil then
		-- check for custom pattern
		if opts.pattern then
			pattern = opts.pattern
		end

		-- if opts is a string
		if type(opts) == "string" then
			if opts == "auto" then
				target_table = autosnippets
			else
				table.insert(keymaps, { "i", opts })
			end
		end

		-- if opts is a table
		if opts ~= nil and type(opts) == "table" then
			for _, keymap in ipairs(opts) do
				if type(keymap) == "string" then
					table.insert(keymaps, { "i", keymap })
				else
					table.insert(keymaps, keymap)
				end
			end
		end

		-- set autocmd for each keymap
		if opts ~= "auto" then
			for _, keymap in ipairs(keymaps) do
				vim.api.nvim_create_autocmd("BufEnter", {
					pattern = pattern,
					group = group,
					callback = function()
						vim.keymap.set(keymap[1], keymap[2], function()
							ls.snip_expand(snippet)
						end, { noremap = true, silent = true, buffer = true })
					end,
				})
			end
		end
	end

	table.insert(target_table, snippet) -- insert snippet into appropriate table
end --}}}

local calculate_comment_string = require("Comment.ft").calculate
local utils = require("Comment.utils")

--- Get the comment string {beg,end} table
---@param ctype integer 1 for `line`-comment and 2 for `block`-comment
---@return table comment_strings {begcstring, endcstring}
local get_cstring = function(ctype)
	-- use the `Comments.nvim` API to fetch the comment string for the region (eq. '--%s' or '--[[%s]]' for `lua`)
	local cstring = calculate_comment_string({ ctype = ctype, range = utils.get_region() }) or vim.bo.commentstring
	-- as we want only the strings themselves and not strings ready for using `format` we want to split the left and right side
	local left, right = utils.unwrap_cstr(cstring)
	-- create a `{left, right}` table for it
	return { left, right }
end

-- Start Refactoring --

local function py_init()
	return sn(
		nil,
		c(1, {
			t(""),
			sn(1, {
				t(", "),
				i(1),
				d(2, py_init),
			}),
		})
	)
end

-- splits the string of the comma separated argument list into the arguments
-- and returns the text-/insert- or restore-nodes
local function to_init_assign(args)
	local tab = {}
	local a = args[1][1]
	if #a == 0 then
		table.insert(tab, t({ "", "\tpass" }))
	else
		local cnt = 1
		for e in string.gmatch(a, " ?([^,]*) ?") do
			if #e > 0 then
				table.insert(tab, t({ "", "\tself." }))
				-- use a restore-node to be able to keep the possibly changed attribute name
				-- (otherwise this function would always restore the default, even if the user
				-- changed the name)
				table.insert(tab, r(cnt, tostring(cnt), i(nil, e)))
				table.insert(tab, t(" = "))
				table.insert(tab, t(e))
				cnt = cnt + 1
			end
		end
	end
	return sn(nil, tab)
end

local pyinitSnippet = s(
	"pyinit",
	fmt([[def __init__(self{}):{}]], {
		d(1, py_init),
		d(2, to_init_assign, { 1 }),
	})
)
table.insert(snippets, pyinitSnippet)

local function create_box(opts)
	local pl = opts.padding_length or 4
	local function pick_comment_start_and_end()
		-- because lua block comment is unlike other language's,
		--  so handle lua ctype
		local ctype = 2
		if vim.opt.ft:get() == "lua" then
			ctype = 1
		end
		local cs = get_cstring(ctype)[1]
		local ce = get_cstring(ctype)[2]
		if ce == "" or ce == nil then
			ce = cs
		end
		return cs, ce
	end
	return {
		-- top line
		f(function(args)
			local cs, ce = pick_comment_start_and_end()
			return cs .. string.rep(string.sub(cs, #cs, #cs), string.len(args[1][1]) + 2 * pl) .. ce
		end, { 1 }),
		t({ "", "" }),
		f(function()
			local cs = pick_comment_start_and_end()
			return cs .. string.rep(" ", pl)
		end),
		i(1, "text"),
		f(function()
			local cs, ce = pick_comment_start_and_end()
			return string.rep(" ", pl) .. ce
		end),
		t({ "", "" }),
		-- bottom line
		f(function(args)
			local cs, ce = pick_comment_start_and_end()
			return cs .. string.rep(string.sub(ce, 1, 1), string.len(args[1][1]) + 2 * pl) .. ce
		end, { 1 }),
	}
end

local box = s("cbox", create_box({ padding_length = 8 }))
table.insert(snippets, box)

local multiLineStr = s("mlstr", {
	t({'"""', ""}),
	i(1, "text"),
	t({ "", '"""' }),
})
table.insert(snippets, multiLineStr)

-- End Refactoring --

return snippets, autosnippets
