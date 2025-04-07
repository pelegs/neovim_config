return {
  {
    "jmbuhr/otter.nvim",
    dev = false,
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
    },
    opts = {
      buffers = {
        set_filetype = true,
        write_to_disk = false,
      },
      handle_leading_whitespace = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "saghen/blink.cmp",
      },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "luvit-meta/library", words = { "vim%.uv" } },
          },
        },
      },
      { "Bilal2453/luvit-meta", lazy = true },
      { "nvim-telescope/telescope.nvim" },
      { "b0o/schemastore.nvim" },
    },
    config = function()
      local util = require("lspconfig.util")

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local bufnr = event.buf

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          assert(client, "LSP client not found")

          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end

          local telescope_builtins = require("telescope.builtin")
          vim.keymap.set("n", "gd", telescope_builtins.lsp_definitions, { buffer = 0 })
          vim.keymap.set("n", "gr", telescope_builtins.lsp_references, { buffer = 0 })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set("n", "ti", function()
            if vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }) then
              vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
            else
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end
          end, { buffer = 0 })

          ---@diagnostic disable-next-line: inject-field
          client.server_capabilities.document_formatting = true
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      if capabilities.workspace == nil then
        capabilities.workspace = {}
        capabilities.workspace.didChangeWatchedFiles = {}
      end

      local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      }

      vim.filetype.add({ extension = { templ = "templ" } })
      vim.filetype.add({ extension = { sls = "sls.yaml" } })
      vim.filetype.add({ extension = { actiondef = "json" } })

      local lspconfig = require("lspconfig")
      lspconfig.gdscript.setup({})

      require("mason").setup()
      local mason_registry = require("mason-registry")
      local ts_plugin_path = mason_registry.get_package("vue-language-server"):get_install_path()
        .. "/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"

      local servers = {
        salt_ls = {
          filetypes = { "sls", "sls.yaml" },
        },
        rust_analyzer = {},
        -- basedpyright = {
        --   capabilities = {
        --     workspace = {
        --       didChangeWatchedFiles = {
        --         dynamicRegistration = false,
        --       },
        --     },
        --   },
        --   settings = {
        --     python = {
        --       analysis = {
        --         autoSearchPaths = true,
        --         useLibraryCodeForTypes = true,
        --         diagnosticMode = "workspace",
        --       },
        --     },
        --   },
        --   root_dir = function(fname)
        --     return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(fname)
        --       or vim.fs.dirname(fname)
        --   end,
        -- },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                disable = { "missing-fields" },
              },
              hint = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              workspace = {
                checkThirdParty = false,
                telemetry = { enable = false },
                library = {
                  "${3rd}/love2d/library",
                },
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        html = {
          filetypes = { "html", "templ" },
        },
        htmx = {
          filetypes = { "html", "templ" },
        },
        tailwindcss = {
          filetypes = { "templ", "html", "javascript", "typescript", "react", "vue" },
          init_options = { userLanguages = { templ = "html" } },
        },
        gopls = {
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
        volar = {},
        sqlls = {
          filetypes = { "sql" },
        },
        templ = {},
        marksman = {
          root_dir = util.root_pattern(".git", ".marksman.toml", "_quarto.yml"),
        },
        clangd = {},
        arduino_language_server = {},
        phpactor = {},
        ts_ls = {
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = ts_plugin_path,
                -- If .vue file cannot be recognized in either js or ts file try to add `typescript` and `javascript` in languages table.
                languages = { "vue" },
              },
            },
          },
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "vue",
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        },
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- python
        "black",
        "jupytext",
        "flake8",
        "pylint",
        -- lua
        "stylua",
        -- shell
        "shfmt",
        "shellcheck",
        -- salt
        "salt-lint",
        -- go
        "delve",
        "golangci-lint",
        -- misc
        "tree-sitter-cli",
      })
      require("mason-tool-installer").setup({
        ensure_installed = ensure_installed,
      })

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}

            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            server.capabilities = require("blink.cmp").get_lsp_capabilities(server.capabilities)
            server.lsp_flags = vim.tbl_deep_extend("force", {}, lsp_flags, server.lsp_flags or {})

            lspconfig[server_name].setup(server)
          end,
        },
      })
    end,
  },
  {
    "aznhe21/actions-preview.nvim",
    config = function()
      vim.keymap.set(
        { "v", "n" },
        "<leader>ca",
        require("actions-preview").code_actions,
        { desc = "Preview Code-Actions" }
      )
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        lsp_inlay_hints = {
          enable = false,
        },
      })

      vim.keymap.set("n", "<space>gtf", ":GoTestFunc -n 1 -v<CR>", {})
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "maxandron/goplements.nvim",
    ft = "go",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle focus=true<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false win.size=0.2<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right win.size=0.2<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
    },
  },
}
