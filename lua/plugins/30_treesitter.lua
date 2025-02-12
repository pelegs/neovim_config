return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
    },
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        auto_install = true,
        ensure_installed = {
          "bash",
          "c",
          "html",
          "lua",
          "markdown",
          "vim",
          "vimdoc",
          "go",
          "rust",
          "yaml",
          "json",
          "templ",
          "python",
          "lua",
          "markdown_inline",
        },
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_lines = 5000
            local line_count = vim.api.nvim_buf_line_count(buf)
            return line_count > max_lines
          end,
        },
        indent = {
          enable = true,
          disable = function(lang, buf)
            local max_lines = 5000
            local line_count = vim.api.nvim_buf_line_count(buf)
            return line_count > max_lines
          end,
        },
        textobjects = {
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              --- ... other keymaps
              ["<Down>"] = { query = "@code_cell.inner", desc = "next code block" },
            },
            goto_previous_start = {
              --- ... other keymaps
              ["<Up>"] = { query = "@code_cell.inner", desc = "previous code block" },
            },
          },
          select = {
            enable = true,
            lookahead = true, -- you can change this if you want
            keymaps = {
              --- ... other keymaps
              ["ib"] = { query = "@block.inner", desc = "in block" },
              ["ab"] = { query = "@block.outer", desc = "around block" },
            },
          },
        },
      })

      vim.treesitter.language.register("yaml", "sls")
    end,
  },
}
