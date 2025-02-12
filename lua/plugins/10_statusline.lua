return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      { "AndreM222/copilot-lualine", dependencies = { "zbirenbaum/copilot.lua" } },
    },
    config = function()
      require("lualine").setup({
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            "filename",
            function()
              if require("molten.status").initialized() == "" then
                return "no kernel initialized"
              else
                return "kernel: " .. require("molten.status").kernels()
              end
            end,
            function()
              return require("auto-session.lib").current_session_name(true)
            end,
          },
          lualine_x = { "copilot", "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
}
