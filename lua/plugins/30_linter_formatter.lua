return {
  {
    "stevearc/conform.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")
      conform.setup({
        notify_on_error = false,
        format_after_save = function(bufnr)
          -- INFO: Off for now due to testing auto save
          return

          -- Disable with a global or buffer-local variable
          -- if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          --   return
          -- end
          -- return { timeout_ms = 2000, async = true, lsp_format = "fallback" }
        end,
        formatters_by_ft = {
          lua = { "mystylua" },
          python = { "isort", "black", "docformatter" },
          html = { "prettier" },
          js = { "prettier" },
          php = { "prettier" },
          go = { "gofmt", "goimports" },
          templ = { "templ" },
          sql = { "sqlfmt" },
          json = { "prettier" },
        },
        formatters = {
          mystylua = {
            command = "stylua",
            args = { "--indent-type", "Spaces", "--indent-width", "2", "-" },
          },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout = 500,
        },
      })

      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })

      vim.keymap.set("n", "<leader>tf", function()
        if not vim.b.disable_autoformat then
          vim.b.disable_autoformat = true
        else
          vim.b.disable_autoformat = not vim.b.disable_autoformat
        end
      end, { desc = "Toggle Autoformat for buffer" })

      require("conform").formatters.injected = {
        options = {
          ignore_errors = false,

          lang_to_ext = {
            bash = "sh",
            c_sharp = "cs",
            elixir = "exs",
            javascript = "js",
            julia = "jl",
            latex = "tex",
            markdown = "md",
            python = "py",
            ruby = "rb",
            rust = "rs",
            teal = "tl",
            r = "r",
            typescript = "ts",
          },

          lang_to_formatters = {},
        },
      }

      vim.keymap.set("n", "<space>f", function()
        require("conform").format({ timeout_ms = 2000, async = true, lsp_format = "fallback" })
      end, { desc = "Format buffer with conform" })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "flake8" },
        sls = { "saltlint" },
        sh = { "shellcheck" },
        go = { "golangcilint" },
      }
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
      vim.keymap.set({ "n" }, "<leader>ml", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
  -- {
  --   "mfussenegger/nvim-lint",
  --   config = function()
  --     require("lint").linters_by_ft = {
  --       -- python = { "flake8", "pylint" },
  --       sls = { "saltlint" },
  --       sh = { "shellcheck" },
  --       go = { "golangcilint" },
  --     }
  --
  --     vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
  --       callback = function()
  --         require("lint").try_lint()
  --       end,
  --     })
  --   end,
  -- },
}
