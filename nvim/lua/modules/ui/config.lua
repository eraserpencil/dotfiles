local config = {}

function config.onedark()
    require("onedark").setup({
        -- execute `PackerSync` each time you change it
        commentStyle = "italic",
        functionStyle = "italic",
        keywordStyle = "bold",
        hideInactiveStatusline = true,
        transparent = false,
        darkSidebar = true,
        darkFloat = true,
        sidebars = {"qf", "vista_kind", "terminal", "packer", "NvimTree"}
    })
end

function config.lualine()
    local function lsp()
        local icon = [[ LSP: ]]
        local msg = 'No Active LSP'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then return icon .. msg end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return icon .. client.name
            end
        end
        return icon .. msg
    end

    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = 'onedark',
            section_seperators = {"|"},
            disabled_filetypes = {}
        },

        sections = {
            lualine_a = {'mode'},
            lualine_b = {
                {'branch'}, {
                    'diff',
                    symbols = {
                        added = '+',
                        modified = '*',
                        removed = '-'
                    }
                }
            },
            lualine_c = {'filename'},
            lualine_x = {{lsp}, {'encoding'}, {'fileformat'}},
            lualine_y = {'progress'},
            lualine_z = {'location'}
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        extensions = {}
    }
end

function config.gitsigns()
    --if not packer_plugins['plenary.nvim'].loaded then
    --    vim.cmd [[packadd plenary.nvim]]
    --end

    require('gitsigns').setup {
        signs = {
            add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
            change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
            delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
            topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
            changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        },
        numhl = false,
        linehl = false,
        keymaps = {
            -- Default keymap options
            noremap = true,

            ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
            ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

            ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
            ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
            ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
            ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
            ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
            ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
            ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
            ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

            -- Text objects
            ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
            ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
        },
        watch_index = {
            interval = 1000,
            follow_files = true
        },
        current_line_blame = false,
        current_line_blame_delay = 1000,
        current_line_blame_position = 'eol',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        word_diff = false,
        use_decoration_api = true,
        use_internal_diff = true,  -- If luajit is present
    }
end

function config.indent_blankline()
    require("indent_blankline").setup {
        indent_blankline_space_char = '',
        indent_blankline_show_first_indent_level = true,
        indent_blankline_filetype_exclude = {
            "startify", "dashboard", "dotooagenda", "log", "fugitive", "gitcommit",
            "packer", "vimwiki", "markdown", "json", "txt", "vista", "help",
            "todoist", "NvimTree", "peekaboo", "git", "TelescopePrompt", "undotree",
            "flutterToolsOutline", "" -- for all buffers without a file type
        },
        indent_blankline_buftype_exclude = {"terminal", "nofile"},
        indent_blankline_show_trailing_blankline_indent = false,
        indent_blankline_show_current_context = true,
        indent_blankline_context_patterns = {
            "class", "function", "method", "block", "list_literal", "selector",
            "^if", "^table", "if_statement", "while", "for"
        },
        -- because lazy load indent-blankline so need readd this autocmd
        vim.cmd('autocmd CursorMoved * IndentBlanklineRefresh')
    }
end

return config
