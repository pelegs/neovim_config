-- General keymaps
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- c++ dap related
keymap("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", opts)
keymap("n", "<leader>dr", "<cmd> DapContinue <CR>", opts)

-- Neo-tree
keymap("n", "<leader>e", ":Neotree toggle <CR>", opts)

-- Better window navigation
keymap("n", "<c-Left>", "<C-w>h", opts)
keymap("n", "<c-Down>", "<C-w>j", opts)
keymap("n", "<c-Up>", "<C-w>k", opts)
keymap("n", "<c-Right>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<c-k>", ":resize -2<CR>", opts)
keymap("n", "<c-j>", ":resize +2<CR>", opts)
keymap("n", "<c-h>", ":vertical resize +2<CR>", opts)
keymap("n", "<c-l>", ":vertical resize -2<CR>", opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Toggles
keymap("n", "<leader>t", ":ToggleTerm<cr>", opts)
keymap("n", "<leader>p", ":lua _PYTHON_TOGGLE()<cr>", opts)
keymap("n", "<leader>g", ":lua _LAZYGIT_TOGGLE()<cr>", opts)
keymap("n", "<leader>F", ":lua _GITGRAPH_TOGGLE()<cr>", opts)
keymap("n", "<leader>h", ":lua _HTOP_TOGGLE()<cr>", opts)
keymap("n", "<leader>z", ":lua Snacks.zen()<cr>", opts)

-- SnipRun
keymap("n", "<leader>Sr", "<Plug>SnipRun", opts)
keymap("v", "<leader>Sr", "<Plug>SnipRun", opts)

-- Folds
-- fold toggle current fold by using tab in normal mode
keymap("n", "<Tab>", "za", opts)

-- Jump between last two buffers
keymap("n", "<C-b>", ":b#<CR>", { desc = "Jump between last two buffers" })

-- NOTE: the following are from Tim's config
-- set keybinds to leader v for vertical split and leader h for horizontal split
-- vim.keymap.set("n", "<leader>v", "<C-w>v")
-- vim.keymap.set("n", "<leader>h", "<C-w>s")
--
-- -- set keybinds to jk to exit insert mode
-- vim.keymap.set("i", "jk", "<Esc>")
--
-- -- Don't highlight searches anymore after esc
-- vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
--
-- -- some convenience quitters
-- vim.keymap.set("n", "Q", "<cmd>wqa<CR>")
-- vim.keymap.set("n", "<leader>w", "<cmd>w<CR>")
-- vim.keymap.set("n", "<leader>q", "<cmd>q<CR>")
--
-- -- source current lua file
-- vim.keymap.set({ "n", "i" }, "<C-q>", "<cmd>source %<CR>")
--
-- -- fold toggle current fold by using tab in normal mode
-- vim.keymap.set("n", "<Tab>", "za")
--
-- -- execute lua
-- vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
-- vim.keymap.set("n", "<space>x", ":.lua<CR>")
-- vim.keymap.set("v", "<space>x", ":lua<CR>")
--
-- -- jump between last two buffers
-- vim.keymap.set("n", "<C-b>", ":b#<CR>", { desc = "Jump between last two buffers" })
