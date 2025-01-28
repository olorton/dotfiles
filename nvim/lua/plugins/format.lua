return {
    { "darrikonn/vim-gofmt", build = ":GoUpdateBinaries" },
    {
        "sbdchd/neoformat",
        cmd = { "Neoformat" },
        keys = {
            { "<leader>l", ":Neoformat<cr>", { silent = true, desc = "Description of your command" } },
        },
        init = function()
            -- Global variables for Neoformat settings
            vim.g.neoformat_run_all_formatters = 1
            vim.g.neoformat_try_formatprg = 1

            -- Enable formatters for specific file types
            vim.g.neoformat_enabled_css = { "prettier" }
            vim.g.neoformat_enabled_javascript = { "prettier" }
            vim.g.neoformat_enabled_javascriptreact = { "prettier" }
            vim.g.neoformat_enabled_jsx = { "prettier" }
            vim.g.neoformat_enabled_python = { "black" }
            vim.g.neoformat_enabled_bzl = { "buildifier" }
            vim.g.neoformat_enabled_lua = { "stylua" }
        end,
    },
}
