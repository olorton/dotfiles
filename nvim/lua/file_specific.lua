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
        vim.bo.foldnestmax = 1
    end,
})

-- Enable enhanced syntax highlighting for Python
vim.g.python_highlight_all = 1

-------------------------------------------------------------------------------
-- Golang
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.opt_local.list = false
    end,
})

-------------------------------------------------------------------------------
-- PHP

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "php" },
    callback = function()
        vim.bo.commentstring = "// %s"
    end,
})
