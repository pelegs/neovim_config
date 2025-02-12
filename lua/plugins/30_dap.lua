return {
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- INFO: Trying to go with M-e to evaluate things on the fly for cleaner debugging output
      -- {
      --   "theHamsta/nvim-dap-virtual-text",
      --   config = function()
      --     require("nvim-dap-virtual-text").setup()
      --   end,
      -- },
      {
        "leoluz/nvim-dap-go",
        config = function()
          local dap, dapui = require("dap"), require("dapui")
          local dapgo = require("dap-go")
          dapui.setup()
          dapgo.setup({
            dap_configurations = {
              {
                type = "go",
                name = "Attach remote",
                mode = "remote",
                request = "attach",
                port = "4444",
                host = "127.0.0.1",
              },
            },
          })
          dap.listeners.before.attach.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.launch.dapui_config = function()
            dapui.open()
          end

          vim.keymap.set("n", "<F5>", function()
            require("dap").continue()
          end, { desc = "Continue debugging" })
          vim.keymap.set("n", "<space>c", function()
            require("dap").continue()
          end, { desc = "Continue debugging" })

          vim.keymap.set("n", "<space>l", function()
            require("dap").run_last()
          end, { desc = "Run last debug session" })

          vim.keymap.set("n", "<space>d", function()
            require("dap").terminate()
          end, { desc = "Terminate debugging" })

          vim.keymap.set("n", "<F10>", function()
            require("dap").step_over()
          end, { desc = "Step over" })
          vim.keymap.set("n", "<space>sn", function()
            require("dap").step_over()
          end, { desc = "Step over" })

          vim.keymap.set("n", "<space>si", function()
            require("dap").step_into()
          end, { desc = "Step into" })

          vim.keymap.set("n", "<space>so", function()
            require("dap").step_out()
          end, { desc = "Step out" })

          vim.keymap.set("n", "<space>db", function()
            require("dap").toggle_breakpoint()
          end, { desc = "Toggle breakpoint" })

          vim.keymap.set("n", "<Leader>lp", function()
            require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
          end, { desc = "Set log point" })

          vim.keymap.set("n", "<space>do", function()
            dapui.open()
          end, { desc = "Open DAP UI" })
          vim.keymap.set("n", "<space>dc", function()
            dapui.close()
          end, { desc = "Close DAP UI" })

          vim.keymap.set({"v", "n"}, "<M-e>", function()
            require('dapui').eval()
          end, {desc= "Evalutate expression in Debugging Session"})
        end,
      },
    },
  },
}
