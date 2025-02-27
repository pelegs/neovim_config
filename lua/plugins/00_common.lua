return {
  "nvim-lua/plenary.nvim",
  "tpope/vim-sleuth",
  {
    "sunaku/tmux-navigate",
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
      })
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
      end

      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.cmd("autocmd! TermOpen term://*bash*toggleterm#* lua set_terminal_keymaps()")

      -- Create the user command :G to open a toggleterm floating window with lazygit opened in it
      local Terminal = require("toggleterm.terminal").Terminal

      -- Gitgui setup
      local gitui = Terminal:new({ cmd = "gitui", hidden = false })
      function _GITGUI_TOGGLE()
        gitui:toggle()
      end
      vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _GITGUI_TOGGLE()<CR>", { noremap = true, silent = true })

      -- lazygit setup
      -- local lazygit = Terminal:new({
      --   cmd = "lazygit",
      --   dir = "git_dir",
      --   direction = "float",
      --   float_opts = {
      --     border = "double",
      --   },
      --   -- function to run on opening the terminal
      --   on_open = function(term)
      --     vim.cmd("startinsert!")
      --     vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      --   end,
      --   -- function to run on closing the terminal
      --   on_close = function(term)
      --     vim.cmd("startinsert!")
      --   end,
      -- })
      -- function _LAZYGIT_TOGGLE()
      --   lazygit:toggle()
      -- end
      -- vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true })

      -- ipython terminal
      local python = Terminal:new({ cmd = "ipython3", direction = "float" })
      function _PYTHON_TOGGLE()
        python:toggle()
      end
      vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>lua _PYTHON_TOGGLE()<CR>", { noremap = true, silent = true })

      -- htop terminal setup
      local htop = Terminal:new({ cmd = "htop", direction = "float" })
      function _HTOP_TOGGLE()
        htop:toggle()
      end
      vim.api.nvim_set_keymap("n", "<leader>H", "<cmd>lua _HTOP_TOGGLE()<CR>", { noremap = true, silent = true })
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {},
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "stevearc/dressing.nvim",
    opts = {},
  },
  {
    "xvzc/chezmoi.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("chezmoi").setup({
        vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
          pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
          callback = function(ev)
            local bufnr = ev.buf
            local edit_watch = function()
              require("chezmoi.commands.__edit").watch(bufnr)
            end
            vim.schedule(edit_watch)
          end,
        }),
      })
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function()
      local wk = require("which-key")

      wk.add({ "<space>s", group = "Debugging (Steps)" })
      wk.add({ "<space>d", group = "Debugging (DAP)" })
      wk.add({ "<leader>f", group = "Search things" })
    end,
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show()
        end,
        desc = "Global Keymaps (which-key)",
      },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
}

-- local Terminal = require("toggleterm.terminal").Terminal
-- local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
-- local gitui = Terminal:new({ cmd = "gitui", hidden = true })
-- local gitgraph = Terminal:new({ cmd = "git-graph", hidden = true })
--
-- function _GITGRAPH_TOGGLE()
--   gitgraph:toggle()
-- end
--
-- function _LAZYGIT_TOGGLE()
--   lazygit:toggle()
-- end
--
-- function _GITUI_TOGGLE()
--   gitui:toggle()
-- end
--
-- local node = Terminal:new({ cmd = "node", hidden = true })
--
-- function _NODE_TOGGLE()
--   node:toggle()
-- end
--
-- local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
--
-- function _NCDU_TOGGLE()
--   ncdu:toggle()
-- end
--
-- local htop = Terminal:new({ cmd = "htop", hidden = true })
--
-- function _HTOP_TOGGLE()
--   htop:toggle()
-- end
--
-- local python = Terminal:new({ cmd = "ipython --TerminalInteractiveShell.editing_mode=emacs", hidden = true })
--
-- function _PYTHON_TOGGLE()
--   python:toggle()
-- end
