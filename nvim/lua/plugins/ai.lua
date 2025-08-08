local opts, model

opts = nil
if os.getenv("GEMINI_API_KEY") then
    opts = nil
elseif os.getenv("OPENAI_API_KEY") then
    model = os.getenv("OPENAI_MODEL") or "gpt-4o-mini"
    print("Avante using OpenAI model: " .. model)
    opts = {
        provider = "openai",
        auto_suggestions_provider = "openai",
        openai = {
            model = model,
            max_tokens = 4096,
        },
        behavior = {
            auto_set_highlight_group = true,
        },
        windows = {
            ---@type "right" | "left" | "top" | "bottom"
            position = "right", -- the position of the sidebar
            wrap = true, -- similar to vim.o.wrap
            width = 30, -- default % based on available width
            sidebar_header = {
                enabled = true, -- true, false to enable/disable the header
                align = "right", -- left, center, right for title
                rounded = false,
            },
            input = {
                prefix = "> ",
                height = 8, -- Height of the input window in vertical layout
            },
            edit = {
                border = "none",
                start_insert = true, -- Start insert mode when opening the edit window
            },
            ask = {
                floating = false, -- Open the 'AvanteAsk' prompt in a floating window
                start_insert = true, -- Start insert mode when opening the ask window
                border = "none",
                ---@type "ours" | "theirs"
                focus_on_apply = "ours", -- which diff to focus after applying
            },
        },
        highlights = {
            diff = {
                current = "DiffDelete",
                incoming = "DiffAdd",
            },
        },
    }
end

if opts == nil then
    return {}
end

local dir = nil
local branch = main
local dev_dir = "~/dev/avante.nvim/"
local use_local_dev_version = true
if use_local_dev_version and tonumber(vim.fn.system("ls -l ~/dev/avante.nvim 2>/dev/null | wc -l")) > 0 then
    dir = dev_dir
    branch = vim.fn.system("cd " .. dev_dir .. " && git branch --show-current")
end

return {
    "yetone/avante.nvim",
    dir = dir,
    branch = branch,
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = opts,
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "echasnovski/mini.pick", -- for file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        "ibhagwan/fzf-lua", -- for file_selector provider fzf
        -- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        -- "zbirenbaum/copilot.lua", -- for providers='copilot'
        -- {
        --     -- support for image pasting
        --     "HakonHarnes/img-clip.nvim",
        --     event = "VeryLazy",
        --     opts = {
        --         -- recommended settings
        --         default = {
        --             embed_image_as_base64 = false,
        --             prompt_for_file_name = false,
        --             drag_and_drop = {
        --                 insert_mode = true,
        --             },
        --             -- required for Windows users
        --             use_absolute_path = true,
        --         },
        --     },
        -- },
        {
            -- -- Make sure to set this up properly if you have lazy=true
            -- "MeanderingProgrammer/render-markdown.nvim",
            -- opts = {
            --     file_types = { "markdown", "Avante" },
            -- },
            -- ft = { "markdown", "Avante" },
            -- },
        },
    },
}
