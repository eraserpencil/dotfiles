local config = {}

function config.nvim_lsp() require('modules.completion.lspconfig') end

function config.compe()
    require('compe').setup {
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = 'enable',
        throttle_time = 80,
        source_timeout = 200,
        resolve_timeout = 800,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        documentation = {
          border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
          winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
          max_width = 120,
          min_width = 60,
          max_height = math.floor(vim.o.lines * 0.3),
          min_height = 1,
        };

        source = {
            path = true,
            buffer = true,
            calc = false,
            spell = true,
            tags = true,
            nvim_lsp = true,
            nvim_lua = true,
            treesitter = false, --Loggy
        }
    }
end

function config.autopairs()
    require('nvim-autopairs').setup({
        disable_filetype = {"TelescopePrompt"},
        ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
        enable_moveright = true,
        -- add bracket pairs after quote
        enable_afterquote = true,
        -- check bracket in same line
        enable_check_bracket_line = true,
        check_ts = true
    })

    if not packer_plugins['nvim-compe'].loaded then
        vim.cmd [[packadd nvim-compe]]
    end

    require("nvim-autopairs.completion.compe").setup({
        map_cr = true,
        map_complete = true
    })
end

--function config.nvim_signature()
--    require("lsp_signature").setup({
--
--    })
--end

return config
