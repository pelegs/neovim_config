return {
  {
    "rmagatti/auto-session",
    dependencies = {
      "nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
      "nvim-neo-tree/neo-tree.nvim",
    },
    config = function()
      require("auto-session").setup({
        auto_session_suppress_dirs = { "~/Projects", "~/", "~/dev", "~/Downloads", "/", "~/work" },
        post_restore_cmds = {
          function()
            require("neo-tree.command").execute({ action = "show" })
          end,
        },
        pre_cwd_changed_cmds = {
          "tabdo Neotree close",
        },
        pre_save_cmds = {
          "tabdo Neotree close",
        },
        session_lens = {
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = true,
        },
        --auto_session_enable_last_session = vim.loop.cwd() == vim.loop.os_homedir(),
      })

      vim.keymap.set("n", "<C-s>", require("auto-session.session-lens").search_session, {
        noremap = true,
        desc = "Search sessions",
      })
    end,
  },
}
