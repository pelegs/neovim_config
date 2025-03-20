return {
  {
    "saghen/blink.cmp",
    lazy = false,
    version = "v0.*",

    dependencies = {
      { "rafamadriz/friendly-snippets" },
      { "L3MON4D3/LuaSnip", version = "v2.*" },
    },

    opts = {
      keymap = {
        preset = "default",
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      snippets = {
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      },

      signature = { enabled = true },
      completion = {
        menu = {
          -- auto_show = function(ctx)
          --   return ctx.mode ~= "cmdline"
          -- end,
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
            },
          },
        },
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        -- ghost_text = { enabled = true },
      },
    },
    opts_extend = { "sources.default" },
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
      require("nvim-autopairs").remove_rule("`")
    end,
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   event = "InsertEnter",
  --   cmd = "Copilot",
  --   opts = {},
  --   config = function()
  --     require("copilot").setup({
  --       filetypes = {
  --         yaml = true,
  --       },
  --       suggestion = {
  --         enabled = true,
  --         auto_trigger = true,
  --       },
  --       panel = {
  --         enabled = false,
  --       },
  --     })
  --
  --     require("copilot.command").disable()
  --   end,
  -- },
}
