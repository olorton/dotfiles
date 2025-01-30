vim.o.foldmethod = "syntax"
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
        if vim.fn.line("$") < 500 then
            vim.o.foldenable = false;
        else
            vim.o.foldenable = true;
        end
    end,
})
