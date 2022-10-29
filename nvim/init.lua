-- [[
-- Basic options -------------------------------------------------------------
-- ]]

vim.opt.backup = false
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
--vim.opt.cmdheight = 2
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.mouse = "" -- disable mouse
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.showmode = true
vim.opt.showtabline = 2 -- always show tabs
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion (4000ms default)
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- insert this many spaces for a tab
vim.opt.cursorline = true -- highlight the current line
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time -- TODO, delete this?
vim.opt.wrap = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.list = true
vim.opt.listchars = 'tab:>~'

-- File loading/saving
vim.opt.autowrite = true -- write to disk when navigating file
vim.opt.autoread = true -- read the file if it was changed externally
vim.api.nvim_command("au FocusGained,BufEnter * :silent! !") -- reload when entereing the buffer ore gaining focus
vim.api.nvim_command("au FocusLost,WinLeave,CursorHold * :silent! wall") -- save when exiting buffer or losing focus

-- TODO whats is all this?:
vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work (comment from yter)



-- [[
-- Keybindings ---------------------------------------------------------------
-- ]]

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
