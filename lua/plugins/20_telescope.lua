return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "L3MON4D3/LuaSnip", version = "v2.*" },
    "rafamadriz/friendly-snippets",
    "benfowler/telescope-luasnip.nvim",
  },
  init = function()
    local builtins = require("telescope.builtin")

    vim.keymap.set("n", "<leader>ff", builtins.find_files, { desc = "Search Files" })
    vim.keymap.set("n", "<leader>fg", builtins.live_grep, { desc = "Search with Live Grep" })
    vim.keymap.set("n", "<leader>fh", builtins.help_tags, { desc = "Search Help" })
    vim.keymap.set("n", "<leader>fj", builtins.jumplist, { desc = "Search Jumplist" })
    vim.keymap.set("n", "<leader>fr", builtins.registers, { desc = "Search Registers" })
    vim.keymap.set("n", "<leader>ft", builtins.treesitter, { desc = "Search Treesitter Objects" })
  end,
  config = function()
    local telescope = require("telescope")
    local telescopeConfig = require("telescope.config")

    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

    table.insert(vimgrep_arguments, "--hidden")
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    local previewers = require("telescope.previewers")

    local _bad = { ".*%.csv", ".*%.lua", ".*%.json" } -- Put all filetypes that slow you down in this array
    local bad_files = function(filepath)
      for _, v in ipairs(_bad) do
        if filepath:match(v) then
          return false
        end
      end

      return true
    end

    local new_maker = function(filepath, bufnr, opts)
      opts = opts or {}
      if opts.use_ft_detect == nil then
        opts.use_ft_detect = true
      end
      opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end

    telescope.setup({
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
        buffer_previewer_maker = new_maker,
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    })

    telescope.load_extension("luasnip")

    telescope.load_extension("chezmoi")
    vim.keymap.set("n", "<leader>cz", telescope.extensions.chezmoi.find_files, { desc = "Search chezmoi files" })
  end,
}
