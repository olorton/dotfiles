return {
    "itchyny/lightline.vim",
    -- event = "VeryLazy",
    opts = {
        laststatus = 3,
        showmode = false,
    },
    config = function()
        vim.g.lightline = {
            colorscheme = "everforest",
            active = {
                left = {
                    { "mode", "paste" },
                    { "filename", "gitbranch", "readonly", "modified" },
                },
                right = {
                    { "lineinfo" },
                    { "percent" },
                    { "charvaluehex", "fileformat", "fileencoding", "filetype" },
                },
            },
            component = {
                helloworld = "Hello, world!",
            },
            component_function = {
                gitbranch = "FugitiveHead",
                charvaluehex = "LightlineCharcode",
            },
        }
    end,
}
