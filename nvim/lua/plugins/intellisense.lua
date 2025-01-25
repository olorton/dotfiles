return {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    { "neoclide/coc.nvim", branch = "release" },
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate", -- Update parsers on install
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "css",
                    "diff",
                    "dockerfile",
                    "git_config",
                    "gitignore",
                    "go",
                    "html",
                    "htmldjango",
                    "ini",
                    "javascript",
                    "jq",
                    "json",
                    "lua",
                    "make",
                    "php",
                    "python",
                    "rst",
                    "rust",
                    "sql",
                    "terraform",
                    "toml",
                    "toml",
                    "twig",
                    "typescript",
                    "vim",
                    "yaml",
                },
                indent = {
                    disable = { "python" },
                },
                highlight = {
                    enable = true, -- Enable highlighting
                },
            })
        end,
    },
}
