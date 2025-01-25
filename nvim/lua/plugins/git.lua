return {
    "airblade/vim-gitgutter",
    {
        "FabijanZulj/blame.nvim",
        lazy = false,
        keys = {},
        config = function()
            require("blame").setup({})
        end,
    },
}
