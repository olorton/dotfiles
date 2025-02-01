-------------------------------------------------------------------------------
-- Python

-- Autocommands for requirements.txt files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*requirements.txt",
    callback = function()
        vim.bo.filetype = "text"
        vim.bo.spell = false
    end,
})

-- Autocommands for Python file type
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.bo.omnifunc = "pythoncomplete#Complete"
        vim.bo.define = "^\\s*\\(def\\|class\\)"
        vim.wo.foldmethod = "indent"
        vim.wo.foldnestmax = 2
    end,
})

-- Enable enhanced syntax highlighting for Python
vim.g.python_highlight_all = 1

-- -------------------------------------------------------------------------------
-- -- Golang

-- -- Hide tab chars when writing go files.
-- -- TODO `nolist` hides all list chars including non-breaking spaces and
-- -- trailing spaces, consider reworking this so that it only affects tab chars.
-- -- vim.opt.listchars = {
-- --     tab = '▸ ',
-- --     trail = '·',
-- --     eol = '↲',
-- --     space = '·'
-- -- }

-- -- vim.cmd [[
-- -- au FileType go setlocal nolist
-- -- ]]

-- -- vim.api.nvim_create_autocmd("FileType", {
-- --   pattern = "go",
-- --   callback = function()
-- --     vim.opt_local.listchars = {
-- --       tab = '▸ ',
-- --       trail = '·',
-- --       eol = '↲',
-- --       space = '·'
-- --     }
-- --     vim.opt_local.list = true
-- --   end
-- -- })

-- -------------------------------------------------------------------------------
-- -- PHP

-- -- Instruct vim-commentary plugin to use `//` to toggle comments
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "php" },
--     callback = function()
--         vim.bo.commentstring = "// %s"
--     end,
-- })
