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
                    "markdown",
                    "markdown_inline",
                    "php",
                    "python",
                    "query",
                    "rst",
                    "rust",
                    "sql",
                    "terraform",
                    "toml",
                    "toml",
                    "twig",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "yaml",
                },
                sync_install = false, -- Install parsers synchronously
                auto_install = true, -- Automatically install missing parsers
                ignore_install = {}, -- Parsers to ignore installing
                highlight = {
                    enable = true, -- Enable highlighting
                    disable = { "c", "rust" }, -- Disable highlighting for specific languages
                    additional_vim_regex_highlighting = false, -- Use Vim's regex highlighting alongside Tree-sitter
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn", -- Start incremental selection
                        node_incremental = "grn", -- Increment to the upper node
                        scope_incremental = "grc", -- Increment to the upper scope
                        node_decremental = "grm", -- Decrement to the previous node
                    },
                },
                folding = {
                    enable = false, -- Enable Tree-sitter based folding
                    foldmethod = "expr",
                    foldexpr = "v:lua.vim.treesitter.foldexpr()",
                },
                indent = {
                    enable = true,
                    disable = { "python" },
                },
            })
        end,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
        },
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                sources = {
                    { name = "path", keyword_length = 3 },
                    { name = "buffer", keyword_length = 3 },
                    { name = "nvim_lsp", keyword_length = 3 },
                    { name = "avante", keyword_length = 3 },
                    { name = "cmdline", keyword_length = 3 },
                },
                mapping = cmp.mapping.preset.insert({

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback() -- Use fallback to perform the default tab action
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),      -- Navigate to previous item
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm
                }),
                formatting = {
                    format = function(entry, vim_item)
                        -- Show the source of the completion item
                        vim_item.menu = ({
                            path = "[Pth]",
                            buffer = "[Buf]",
                            nvim_lsp = "[LSP]",
                            avante = "[Ai]",
                            cmdline = "[Cmd]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
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
                    vim.keymap.set('n', '<leader>E', '<cmd>lua vim.diagnostic.open_float()<CR>',
                        { noremap = true, silent = true })
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
