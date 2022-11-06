-- cf "The Ultimate LuaSnip Tutorial for Beginners | Neovim Lua Snippet Engine"

local ls = require("luasnip") --{{{
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
-- Set filetype here
local file_pattern = "*.lua"



-- Start Snippets

local keymap_var = s(
  ";map",
    { t("local map = vim.api.nvim_set_keymap") }
  )
table.insert(snippets, keymap_var)

local key_remap = s(
  ";remap",
  fmt(
    [[
    map("{}", "{}", "{}", {{ noremap = {} }})
    ]],
    {
      i(1, "!mode"),
      i(2, "!remap"),
      i(3, "!command"),
      c(4, { t("true"), t("false") })
    }
  )
)
table.insert(snippets, key_remap)

-- End Snippets

return snippets, autosnippets
