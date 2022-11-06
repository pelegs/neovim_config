local M = {}

function M.setup()
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
      for e in string.gmatch(a, " ?([^,]*) ?") do
        if #e > 0 then
          table.insert(tab, t({ "", "\t\tself." }))
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
  local pyinit = s("pyinit", fmt(
    [[class {}():
      def __init__(self{}):{}]],
    {
      i(1, "!className"),
      d(2, py_init),
      d(3, to_init_assign, { 2 }),
    }))
  table.insert(snippets, pyinit)
end
