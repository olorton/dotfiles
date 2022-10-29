local key_opts= { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", key_opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal ----------------------------
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", key_opts)
keymap("n", "<C-j>", "<C-w>j", key_opts)
keymap("n", "<C-k>", "<C-w>k", key_opts)
keymap("n", "<C-l>", "<C-w>l", key_opts)

-- File explorer
keymap("n", "<leader>e", ":Lex 30<cr>", key_opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", key_opts)
keymap("n", "<C-Down>", ":resize +2<CR>", key_opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", key_opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", key_opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", key_opts)
keymap("n", "<S-h>", ":bprevious<CR>", key_opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", key_opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", key_opts)

-- Insert --
-- Press jk fast to exit insert mode 
--keymap("i", "jk", "<ESC>", key_opts)
--keymap("i", "kj", "<ESC>", key_opts)

-- Visual ----------------------------
-- Stay in indent mode
keymap("v", "<", "<gv", key_opts)
keymap("v", ">", ">gv", key_opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", key_opts)
keymap("v", "<A-k>", ":m .-2<CR>==", key_opts)
keymap("v", "p", '"_dP', key_opts)

-- Visual Block ----------------------
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", key_opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", key_opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", key_opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", key_opts)
