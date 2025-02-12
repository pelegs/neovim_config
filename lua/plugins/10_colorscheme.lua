return {
  {
    "zaldih/themery.nvim",
    dependencies = {
      {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
      },
      { "ellisonleao/gruvbox.nvim", priority = 1000 },
      { "EdenEast/nightfox.nvim", priority = 1000 },
      { "rebelot/kanagawa.nvim", priority = 1000 },
    },
    config = function()
      require("themery").setup({
        themes = {
          "catppuccin-mocha",
          "catppuccin-frappe",
          "catppuccin-macchiato",
          "nightfox",
          "duskfox",
          "kanagawa-wave",
          "kanagawa-dragon",
          {
            name = "Gruvbox dark",
            colorscheme = "gruvbox",
            before = [[ vim.opt.background = "dark" ]],
          },
          "catppuccin-latte",
          "kanagawa-lotus",
          "dayfox",
          "dawnfox",
          {
            name = "Gruvbox light",
            colorscheme = "gruvbox",
            before = [[ vim.opt.background = "light" ]],
          },
        }, -- Your list of installed colorschemes.
        livePreview = true, -- Apply theme while picking. Default to true.
      })
    end,
  },
}
