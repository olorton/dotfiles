local function lualine_paste_mode()
    return vim.opt.paste:get() and "PASTE" or ""
end

local function lualine_simple_progress()
    local cur = vim.fn.line(".")
    local total = vim.fn.line("$")
    return string.format("%2d%%%%", math.floor(cur / total * 100))
end

local function is_buffer_empty()
    local lines = vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, -1, false)
    return #lines == 0 or (#lines == 1 and lines[1] == "")
end

local function lualine_char_code()
    if is_buffer_empty() then
        return "----"
    end
    if vim.api.nvim_buf_line_count(0) == 0 then
        return "----"
    end
    local line = vim.fn.getline(".")
    local col = vim.fn.col(".")
    local char = vim.fn.getline("."):sub(col, col) or ""
    local char_code = col - 1 < #line and vim.fn.char2nr(char)
        or vim.fn.char2nr(vim.o.fileformat == "unix" and "\n" or vim.bo.fileformat == "dos" and "\r\n" or "\r")
    return string.format("0x%02x", char_code)
end

return {
    "nvim-lualine/lualine.nvim",
    opts = {
        options = {
            icons_enabled = false,
            theme = "auto",
            component_separators = { left = "|", right = "|" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = {
                statusline = { "nerdtree", "Avante", "AvanteSelectedFiles", "AvanteInput" },
                winbar = { "Nerdtree", "Avante", "AvanteSelectedFiles", "AvanteInput" },
            },
            ignore_focus = {},
            always_divide_middle = true,
            always_show_tabline = true,
            globalstatus = false,
            refresh = {
                statusline = 100,
                tabline = 100,
                winbar = 100,
            },
        },
        sections = {
            lualine_a = { "mode", lualine_paste_mode },
            lualine_b = {
                {
                    "filename",
                    file_status = true, -- Displays file status (readonly status, modified status)
                    newfile_status = false, -- Display new file status (new file means no write after created)
                    -- 0: Just the filename
                    -- 1: Relative path
                    -- 2: Absolute path
                    -- 3: Absolute path, with tilde as the home directory
                    -- 4: Filename and parent dir, with tilde as the home directory
                    path = 1,
                    shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                    -- for other components. (terrible name, any suggestions?)
                    symbols = {
                        modified = "+", -- Text to show when the file is modified.
                        readonly = "[READ ONLY]", -- Text to show when the file is non-modifiable or readonly.
                        unnamed = "[No Name]", -- Text to show for unnamed buffers.
                        newfile = "[New]", -- Text to show for newly created file before first write
                    },
                },
                "branch",
                -- "diff",
            },
            lualine_c = {
                {
                    "diagnostics",

                    -- -- Table of diagnostic sources, available sources are:
                    -- --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
                    sources = {
                        "nvim_diagnostic",
                        "nvim_lsp",
                    },

                    -- -- Displays diagnostics for the defined severity types
                    sections = { "error", "warn", "info", "hint" },

                    diagnostics_color = {
                        -- Same values as the general color option can be used here.
                        error = "DiagnosticError", -- Changes diagnostics' error color.
                        warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
                        info = "DiagnosticInfo", -- Changes diagnostics' info color.
                        hint = "DiagnosticHint", -- Changes diagnostics' hint color.
                    },
                    symbols = { error = "Err:", warn = "War:", info = "Inf:", hint = "Hnt:" },
                    colored = true, -- Displays diagnostics status in color if set to true.
                    update_in_insert = true, -- Update diagnostics in insert mode.
                    always_visible = false, -- Show diagnostics even if there are none.
                },
            },

            lualine_x = { lualine_char_code, "encoding", "fileformat", "filetype" },
            lualine_y = { lualine_simple_progress },
            lualine_z = { "location" },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
    },
}
