-- [[
-- Basic options ----------------------------------------------------------------------
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

-- TODO whats is all this?:
vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work (comment from yter)
