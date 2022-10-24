local M = {}

function M.setup()
	vim.opt.termguicolors = true
	vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
	vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
	vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
	vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
	vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
	vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

	vim.opt.list = true
	-- vim.opt.listchars:append "space:⋅"
	-- vim.opt.listchars:append "eol:↴"

	require("indent_blankline").setup {
			space_char_blankline = " ",
			show_current_context = true,
			show_current_context_start = true,
			char_highlight_list = {
					"IndentBlanklineIndent1",
					"IndentBlanklineIndent2",
					"IndentBlanklineIndent3",
					"IndentBlanklineIndent4",
					"IndentBlanklineIndent5",
					"IndentBlanklineIndent6",
			},
	}
end
--
-- function M.setup()
-- 	vim.cmd [[highlight IndentBlanklineIndent1 guifg=#30465d guibg=#14262b gui=nocombine]]
-- 	vim.cmd [[highlight IndentBlanklineIndent2 guifg=#30465d guibg=#09262e gui=nocombine]]
-- 	vim.cmd [[highlight IndentBlanklineIndent3 guifg=#30465d guibg=#161e37 gui=nocombine]]

-- 	require("indent_blankline").setup {
-- 		char = "▎",
-- 		char_highlight_list = {
-- 			"IndentBlanklineIndent1",
-- 			"IndentBlanklineIndent2",
-- 			"IndentBlanklineIndent3",
-- 		},
-- 		space_char_highlight_list = {
-- 			"IndentBlanklineIndent1",
-- 			"IndentBlanklineIndent2",
-- 			"IndentBlanklineIndent3",
-- 		},
-- 		show_trailing_blankline_indent = false,
-- 	}
-- end

-- vim.opt.termguicolors = true
-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#30465d guibg=#1a1a1a gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#30465d guibg=#282832 gui=nocombine]]

-- function M.setup()
-- require("indent_blankline").setup {
-- 		show_current_context = true,
-- 		show_current_context_start = true,
-- 		char = "",
--     char_highlight_list = {
--         "IndentBlanklineIndent1",
--         "IndentBlanklineIndent2",
--     },
--     space_char_highlight_list = {
--         "IndentBlanklineIndent1",
--         "IndentBlanklineIndent2",
--     },
--     show_trailing_blankline_indent = false,
-- }
-- end

return M
