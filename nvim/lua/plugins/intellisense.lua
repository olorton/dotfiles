return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        opts = {},
    },

    -- Treesitter
    {
        "romus204/tree-sitter-manager.nvim",
        dependencies = {
            -- Requires the official tree-sitter CLI to compile parsers on your system
            -- Ensure 'tree-sitter' is installed via Homebrew, APT, Pacman, etc.
        },
        config = function()
            require("tree-sitter-manager").setup({
                -- Default Options
                -- ensure_installed = {}, -- list of parsers to install at the start of a neovim session
                -- border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
                -- auto_install = false, -- if enabled, install missing parsers when editing a new file
                -- highlight = true, -- treesitter highlighting is enabled by default
                -- languages = {}, -- override or add new parser sources
                -- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
                -- query_dir = vim.fn.stdpath("data") .. "/site/queries",
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "css",
                    "diff",
                    "dockerfile",
                    "git_config",
                    "gitcommit",
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
                    "twig",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "yaml",
                },
                auto_install = true,
            })
        end
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
                    "basedpyright",
                    "ruff",
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

                    -- A special handler for basedpyright (Poetry environment detection & isolated subprojects)
                    ["basedpyright"] = function()
                        local lspconfig = require("lspconfig")
                        local util = require("lspconfig.util")

                        -- Find the nearest sub-project root containing pyproject.toml
                        local function find_subproject_root(fname)
                            return util.root_pattern("poetry.lock", "pyproject.toml")(fname)
                                or util.find_git_ancestor(fname)
                                or vim.loop.cwd()
                        end

                        -- Dynamically resolve the Poetry virtualenv Python path
                        local function get_poetry_python_path(root_dir)
                            local handle = io.popen("cd " .. vim.fn.shellescape(root_dir) .. " && poetry env info -p 2>/dev/null")
                            if not handle then return nil end
                            local result = handle:read("*a")
                            handle:close()

                            local env_path = vim.trim(result)
                            if env_path ~= "" then
                                if vim.fn.has("win32") == 1 then
                                    return env_path .. "\\Scripts\\python.exe"
                                else
                                    return env_path .. "/bin/python"
                                end
                            end
                            return nil
                        end

                        lspconfig.basedpyright.setup({
                            root_dir = find_subproject_root,
                            on_new_config = function(config, new_root_dir)
                                local python_path = get_poetry_python_path(new_root_dir)
                                if python_path then
                                    config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
                                        python = {
                                            pythonPath = python_path,
                                        },
                                    })
                                end
                            end,
                            on_attach = function(client, bufnr)
                                -- Disable BasedPyright's formatting to let Ruff handle it
                                client.server_capabilities.documentFormattingProvider = false
                                client.server_capabilities.documentRangeFormattingProvider = false
                            end,
                            settings = {
                                basedpyright = {
                                    analysis = {
                                        autoSearchPaths = true,
                                        useLibraryCodeForTypes = true,
                                        diagnosticMode = "openFilesOnly", -- Prevents running heavy background checks on the entire monorepo
                                        typeCheckingMode = "recommended",
                                    },
                                },
                            },
                        })
                    end,

                    -- A special handler for ruff
                    ["ruff"] = function()
                        local lspconfig = require("lspconfig")
                        local util = require("lspconfig.util")

                        local function find_subproject_root(fname)
                            return util.root_pattern("poetry.lock", "pyproject.toml")(fname)
                                or util.find_git_ancestor(fname)
                                or vim.loop.cwd()
                        end

                        lspconfig.ruff.setup({
                            root_dir = find_subproject_root,
                            on_attach = function(client, bufnr)
                                -- Disable hover so it doesn't conflict with BasedPyright's hover docstrings
                                client.server_capabilities.hoverProvider = false
                            end,
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
