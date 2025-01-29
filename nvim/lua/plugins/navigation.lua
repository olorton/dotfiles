return {
    "christoomey/vim-tmux-navigator",
    "scrooloose/nerdtree",
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        pickers = {
            buffers = {
                initial_mode = "normal", -- Override for buffers picker
            },
        },
        keys = {
            { "<C-p>", "<cmd>Telescope find_files<CR>", mode = "n" },
            { "<C-g>", "<cmd>Telescope live_grep<CR>", mode = "n" },
            { ";", "<cmd>Telescop buffers<CR>", mode = "n" },
        },
    },
}
