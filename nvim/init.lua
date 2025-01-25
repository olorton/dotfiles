-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.cmd('source ~/.vimrc_basic')

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    'sainnhe/everforest',
    'tpope/vim-fugitive',
    'airblade/vim-gitgutter',
    'christoomey/vim-tmux-navigator',
    'itchyny/lightline.vim',
    'scrooloose/nerdtree',
    'bling/vim-bufferline',
    { "junegunn/fzf", build = "./install --all" },
    'junegunn/fzf.vim',
    'tpope/vim-commentary',
    'tpope/vim-surround',
    'famiu/bufdelete.nvim',
    'ekalinin/Dockerfile.vim',
    'mboughaba/i3config.vim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'sbdchd/neoformat',
    'martinda/jenkinsfile-vim-syntax',
    { "neoclide/coc.nvim", branch = "release" },
    'wfxr/protobuf.vim',
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'hashivim/vim-terraform',
    { 'fatih/vim-go', build = ':GoUpdateBinaries' },
    'b4b4r07/vim-hcl',
    { 'darrikonn/vim-gofmt', build = ':GoUpdateBinaries' },
    'sudar/vim-arduino-syntax',
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "everforest" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

vim.cmd[[colorscheme everforest]]
vim.cmd('source ~/dev/dotfiles/nvim/todo_migrate_this_old_config_to_lua.vim')
