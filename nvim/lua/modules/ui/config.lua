local config = {}

function config.lualine()
    local function lsp()
        local icon = "LSP: "
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
            theme = 'dracula',
            disabled_filetypes = {}
        },

        sections = {
            lualine_a = {'mode'},
            lualine_b = {{'branch'}, {'diff'}},
            lualine_c = {
                {'filename'}, {
                    'diagnostics',
                    sources = {'nvim_lsp'},
                    color_error = "red",
                    color_warn = "yellow",
                    color_info = "white",
                    color_hint = "blue",
                    symbols = {error = 'E', warn = 'W', info = 'I'}
                }
            },
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

-- Adds lines to show indents
function config.indent_blankline()
    vim.cmd [[highlight IndentOdd guifg=#44475a guibg=NONE gui=nocombine]]
    require("indent_blankline").setup {
        char = "|",
        space_char = ".",
        char_highlight_list = {"IndentOdd"},
        space_char_highlight_list = {"IndentOdd"},
        filetype_exclude = {
            "startify", "dashboard", "dotooagenda", "log", "fugitive",
            "gitcommit", "packer", "vimwiki", "markdown", "json", "txt",
            "vista", "help", "todoist", "NvimTree", "peekaboo", "git",
            "TelescopePrompt", "undotree", "flutterToolsOutline", "" -- for all buffers without a file type
        },
        buftype_exclude = {"terminal", "nofile"},
        context_patterns = {
            "class", "function", "method", "block", "list_literal", "selector",
            "^if", "^table", "if_statement", "while", "for", "type", "var",
            "import"
        }
    }
    -- because lazy load indent-blankline so need readd this autocmd
    vim.cmd('autocmd CursorMoved * IndentBlanklineRefresh')
end

function config.nvim_tree()
    vim.g.nvim_tree_width = 30
    vim.g.nvim_tree_follow = 1
    vim.g.nvim_tree_gitignore = 1
    vim.g.nvim_tree_auto_close = 1
    vim.g.nvim_tree_indent_markers = 1
    vim.g.nvim_tree_git_hl = 1
    vim.g.add_trailing = 1
    vim.g.nvim_tree_highlight_opened_files = 1
    vim.g.nvim_tree_tab_open = 1
    vim.g.nvim_tree_lsp_diagnostics = 1
    vim.g.nvim_tree_indent_markers = 1
    vim.g.nvim_tree_ignore = {
      '.git',
      'node_modules',
      '.cache'
    }
    vim.g.nvim_tree_icons = {
        default = '',
        symlink = '',
        git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "-",
            ignored = "#"
        }
    }
    local tree_cb = require'nvim-tree.config'.nvim_tree_callback
--    -- default mappings
--    vim.g.nvim_tree_bindings = {
--        { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
--        { key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
--        { key = "<C-v>",                        cb = tree_cb("vsplit") },
--        { key = "<C-x>",                        cb = tree_cb("split") },
--        { key = "<C-t>",                        cb = tree_cb("tabnew") },
--        { key = "<",                            cb = tree_cb("prev_sibling") },
--        { key = ">",                            cb = tree_cb("next_sibling") },
--        { key = "P",                            cb = tree_cb("parent_node") },
--        { key = "<BS>",                         cb = tree_cb("close_node") },
--        { key = "<S-CR>",                       cb = tree_cb("close_node") },
--        { key = "<Tab>",                        cb = tree_cb("preview") },
--        { key = "K",                            cb = tree_cb("first_sibling") },
--        { key = "J",                            cb = tree_cb("last_sibling") },
--        { key = "I",                            cb = tree_cb("toggle_ignored") },
--        { key = "H",                            cb = tree_cb("toggle_dotfiles") },
--        { key = "R",                            cb = tree_cb("refresh") },
--        { key = "a",                            cb = tree_cb("create") },
--        { key = "d",                            cb = tree_cb("remove") },
--        { key = "r",                            cb = tree_cb("rename") },
--        { key = "<C-r>",                        cb = tree_cb("full_rename") },
--        { key = "x",                            cb = tree_cb("cut") },
--        { key = "c",                            cb = tree_cb("copy") },
--        { key = "p",                            cb = tree_cb("paste") },
--        { key = "y",                            cb = tree_cb("copy_name") },
--        { key = "Y",                            cb = tree_cb("copy_path") },
--        { key = "gy",                           cb = tree_cb("copy_absolute_path") },
--        { key = "[c",                           cb = tree_cb("prev_git_item") },
--        { key = "]c",                           cb = tree_cb("next_git_item") },
--        { key = "-",                            cb = tree_cb("dir_up") },
--        { key = "s",                            cb = tree_cb("system_open") },
--        { key = "q",                            cb = tree_cb("close") },
--        { key = "g?",                           cb = tree_cb("toggle_help") },
--    }
end

function config.nvim_bufferline()
    require('bufferline').setup {
        options = {
            number = "both",
            number_style = "superscript",
            modified_icon = '✥',
            indicator_icon = "",
            buffer_close_icon = "",
            mappings = true,
            right_mouse_command = "",
            left_trunc_marker = "",
            right_trunc_marker = "",
            show_buffer_close_icons = true,
            show_buffer_icons = false,
            show_tab_indicators = false,
            show_close_icons = false,
            enforce_regular_tabs = true,
            separator_style = "",
            diagnostics = "nvim_lsp",
            always_show_bufferline = false,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center",
                    padding = 1
                }
            }
        }
    }
end


return config
