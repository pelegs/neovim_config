-- cf "The Ultimate LuaSnip Tutorial for Beginners | Neovim Lua Snippet Engine"

local ls = require("luasnip") --{{{
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

local d   = ls.dynamic_node
local c   = ls.choice_node
local f   = ls.function_node
local sn  = ls.snippet_node
local r   = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt --> format
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
-- Set filetype here
local file_pattern = "*.py"


-- Start Snippets

-- NOTE: logging module (import logging) boilerplate
local logging = s("_logging", fmt(
[[
    # syntax: logging.debug/info/error("your statement here")
    level = logging.DEBUG
    fmt = '[%(levelname)s] %(asctime)s - %(message)s'
    logging.basicConfig(level=level, format=fmt)
]], {}
))
table.insert(snippets, logging)


-- NOTE: set variable equal to input prompt, e.g. name = input("name: ")
local in_var = s("in_var", fmt(
  [[{} = input("{}: ")
  ]],
  {
    i(1, "var_name"),
    rep(1),
    -- t({1}),
  }))
table.insert(snippets, in_var)


-- NOTE: Class initialize with attributes equal to parameters
local function py_init()
  return sn(nil, c(1, {
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
    table.insert(tab, t({ "", "\tpass" }))
  else
    local cnt = 1
    for e in string.gmatch(a, " ?([^,]*): ?") do
      if #e > 0 then
        table.insert(tab, t({ "", "\t\tself.__" }))
        -- use a restore-node to be able to keep the possibly changed attribute name
        -- (otherwise this function would always restore the default, even if the user
        -- changed the name)
        -- table.insert(tab, r(cnt, tostring(cnt), i(nil, e)))
        table.insert(tab, t(e))
        table.insert(tab, t(" = "))
        table.insert(tab, t(e))
        cnt = cnt + 1
      end
    end
  end
  return sn(nil, tab)
end

-- create the actual snippet
local pyinit = s("classinit", fmt(
  [[class {}():
    def __init__(self{}):{}]],
  {
    i(1, "!className"),
    d(2, py_init),
    d(3, to_init_assign, { 2 }),
  }))
table.insert(snippets, pyinit)
-- End Snippets

return snippets, autosnippets
