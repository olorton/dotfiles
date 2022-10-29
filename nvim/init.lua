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



-- [[
-- Plugins -------------------------------------------------------------------
-- ]]

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  use { "wbthomason/packer.nvim", commit = "6afb67460283f0e990d35d229fd38fdc04063e0a" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" } -- Useful lua functions used by lots of plugins
  --use { "windwp/nvim-autopairs", commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347" } -- Autopairs, integrates with both cmp and treesitter
  --use { "numToStr/Comment.nvim", commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67" }
  --use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "4d3a68c41a53add8804f471fcc49bb398fe8de08" }
  --use { "kyazdani42/nvim-web-devicons", commit = "563f3635c2d8a7be7933b9e547f7c178ba0d4352" }
  --use { "kyazdani42/nvim-tree.lua", commit = "7282f7de8aedf861fe0162a559fc2b214383c51c" }
  --use { "akinsho/bufferline.nvim", commit = "83bf4dc7bff642e145c8b4547aa596803a8b4dc4" }
  --use { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" }
  --use { "nvim-lualine/lualine.nvim", commit = "a52f078026b27694d2290e34efa61a6e4a690621" }
  --use { "akinsho/toggleterm.nvim", commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda" }
  --use { "ahmedkhalf/project.nvim", commit = "628de7e433dd503e782831fe150bb750e56e55d6" }
  --use { "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" }
  --use { "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" }
  --use { "goolord/alpha-nvim", commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31" }
  --use {"folke/which-key.nvim"}

  -- Colorschemes
  --use { "folke/tokyonight.nvim", commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764" }
  --use { "lunarvim/darkplus.nvim", commit = "13ef9daad28d3cf6c5e793acfc16ddbf456e1c83" }

  -- Cmp 
  --use { "hrsh7th/nvim-cmp", commit = "b0dff0ec4f2748626aae13f011d1a47071fe9abc" } -- The completion plugin
  --use { "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" } -- buffer completions
  --use { "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" } -- path completions
  --use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" } -- snippet completions
  --use { "hrsh7th/cmp-nvim-lsp", commit = "3cf38d9c957e95c397b66f91967758b31be4abe6" }
  --use { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" }

  -- Snippets
  --use { "L3MON4D3/LuaSnip", commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" } --snippet engine
  --use { "rafamadriz/friendly-snippets", commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1" } -- a bunch of snippets to use

  -- LSP
  --use { "neovim/nvim-lspconfig", commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda" } -- enable LSP
  --use { "williamboman/mason.nvim", commit = "c2002d7a6b5a72ba02388548cfaf420b864fbc12"} -- simple to use language server installer
  --use { "williamboman/mason-lspconfig.nvim", commit = "0051870dd728f4988110a1b2d47f4a4510213e31" }
  --use { "jose-elias-alvarez/null-ls.nvim", commit = "c0c19f32b614b3921e17886c541c13a72748d450" } -- for formatters and linters
  --use { "RRethy/vim-illuminate", commit = "a2e8476af3f3e993bb0d6477438aad3096512e42" }

  -- Telescope
  --use { "nvim-telescope/telescope.nvim", commit = "76ea9a898d3307244dce3573392dcf2cc38f340f" }

  -- Treesitter
  --use {"nvim-treesitter/nvim-treesitter", commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac"}

  -- Git
  --use { "lewis6991/gitsigns.nvim", commit = "2c6f96dda47e55fa07052ce2e2141e8367cbaaf2" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
