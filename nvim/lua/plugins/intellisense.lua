return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        opts = {},
    },

    -- Treesitter
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

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                },
                mapping = cmp.mapping.preset.insert({

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback() -- Use fallback to perform the default tab action
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Navigate to previous item
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
            })
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            -- Adding folke/neodev.nvim helps prevent lsp errors for init.lua
            {
                "folke/neodev.nvim",
                config = function()
                    require("neodev").setup()
                end,
            },
        },
        init = function()
            -- Reserve a space in the gutter
            -- This will avoid an annoying layout shift in the screen
            vim.opt.signcolumn = "yes"
        end,
        config = function()
            local lsp_defaults = require("lspconfig").util.default_config

            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            lsp_defaults.capabilities =
                vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

            -- LspAttach is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
                    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                end,
            })

            require("mason-lspconfig").setup({
                -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/README.md#available-lsp-servers
                ensure_installed = {
                    "bashls",
                    -- "cssls",
                    "gopls",
                    "intelephense",
                    -- "jsonls",
                    "lua_ls",
                    "pyright",
                    "ts_ls",
                    "html", -- hrsh7th/vscode-langservers-extracted (Includes css & json)
                },
                automatic_installation = true,
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,
                },
            })
        end,
    },
}
