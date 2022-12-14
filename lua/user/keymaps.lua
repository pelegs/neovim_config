local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


------------
-- Normal --
------------
-- Better window navigation
keymap("n", "<c-Left>", "<C-w>h", opts)
keymap("n", "<c-Down>", "<C-w>j", opts)
keymap("n", "<c-Up>", "<C-w>k", opts)
keymap("n", "<c-Right>", "<C-w>l", opts)

keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- Resize with arrows
keymap("n", "<c-k>", ":resize -2<CR>", opts)
keymap("n", "<c-j>", ":resize +2<CR>", opts)
keymap("n", "<c-h>", ":vertical resize +2<CR>", opts)
keymap("n", "<c-l>", ":vertical resize -2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", opts)

------------
-- Insert --
------------

------------
-- Visual --
------------
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)


------------------
-- Visual Block --
------------------
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)


--------------
-- Terminal --
--------------
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)


---------
-- LSP --
---------
-- format
keymap("n", "<leader>f", ":lua vim.lsp.buf.format()<cr>", term_opts)


---------------
-- Nvim-tree --
---------------
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)


-------------
-- SnipRun --
-------------
keymap("v", "<C-s>", ":SnipRun<cr>", opts)
keymap("n", "<C-s>", ":SnipRun<cr>", opts)
keymap("n", "<C-d>", ":SnipClose<cr>", opts)
local sa = require('sniprun.api')
vim.keymap.set("n", "<leader>r", function()
  local deltaRow = vim.fn.input("Number of lines: ")
  local r,c = unpack(vim.api.nvim_win_get_cursor(0))
  sa.run_range(r, r+deltaRow)
end, { silent = true })


-------------
-- Toggles --
-------------
keymap("n", "<leader>t", ":ToggleTerm<cr>", opts)
keymap("n", "<leader>p", ":lua _PYTHON_TOGGLE()<cr>", opts)
keymap("n", "<leader>g", ":lua _GITUI_TOGGLE()<cr>", opts)
keymap("n", "<leader>h", ":lua _HTOP_TOGGLE()<cr>", opts)
keymap("n", "<leader>c", ":NoNeckPain<cr>", opts)
