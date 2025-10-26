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
                    "regex",
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
                -- TODO try enabling this?
                folding = {
                    enable = false, -- Enable Tree-sitter based folding
                    foldmethod = "expr",
                    foldexpr = "v:lua.vim.treesitter.foldexpr()",
                },
                indent = {
                    enable = true,
                },
            })
        end,
    },

    -- Autocompletion
    {
        "saghen/blink.cmp",
        -- optional: provides snippets for the snippet source

        -- use a release tag to download pre-built binaries
        version = "1.*",
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = "default" },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono",
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = false } },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { "lsp", "path", "buffer" },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            -- { "hrsh7th/cmp-nvim-lsp" },
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

            -- Add blink.cmp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            lsp_defaults.capabilities =
                vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("blink.cmp").get_lsp_capabilities())

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
                    vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
                    vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                    vim.keymap.set(
                        "n",
                        "<leader>E",
                        "<cmd>lua vim.diagnostic.open_float()<CR>",
                        { noremap = true, silent = true }
                    )
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
                    -- The default handler that applies to all servers
                    -- It sets the global root detection pattern
                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            root_dir = require("lspconfig").util.root_pattern(".git") or vim.loop.cwd(),
                        })
                    end,

                    -- A special handler for a specific server (e.g., ts_ls)
                    ["ts_ls"] = function()
                        require("lspconfig").ts_ls.setup({
                            -- The `root_dir` function should not return a table. We ensure a string is always returned.
                            root_dir = require("lspconfig.util").find_git_ancestor(vim.loop.cwd()) or require(
                                "lspconfig.util"
                            ).root_pattern("package.json", "tsconfig.json") or vim.loop.cwd(),
                        })
                    end,

                    -- A special handler for a specific server (e.g., lua_ls)
                    ["lua_ls"] = function()
                        require("lspconfig").lua_ls.setup({
                            -- Add custom settings for lua_ls here if needed
                        })
                    end,
                },
            })
        end,
    },

    -- Trouble diagnostic
    {
        "folke/trouble.nvim",
        opts = {
            use_diagnostic_signs = true,
            auto_close = true,
        },
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle focus=true<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
}
