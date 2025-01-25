vim.keymap.set("n", "<leader>m", ":messages<CR>", { silent = false })
-- TODO move BlameToggle to the blame plugin loader
vim.keymap.set("n", "<leader>b", ":BlameToggle<CR>", { noremap = true })
