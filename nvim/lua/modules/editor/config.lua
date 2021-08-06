local config = {}
local global = require('core.global')
local session_dir = global.data_dir .. '/session'

if vim.fn.isdirectory(session_dir) ~= 1 then
    os.execute('mkdir -p ' .. session_dir)
end

-- function config.nvim_treesitter()
--     if not packer_plugins['nvim-ts-rainbow'].loaded then
--         vim.cmd [[packadd nvim-ts-rainbow]]
--     end
-- 
--     vim.api.nvim_command('set foldmethod=expr')
--     vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
-- 
--     require'nvim-treesitter.configs'.setup {
--         ensure_installed = {
--             "c", "cpp", "go", "gomod", "rust", "bash", "lua", "toml", "yaml",
--             "json", "python", "javascript", "typescript"
--         },
--         ignore_install = {
--             "beancount", "bibtex", "c_sharp", "clojure", "comment",
--             "commonlisp", "cuda", "dart", "devicetree", "elixir", "erlang",
--             "fennel", "Godot", "glimmer", "graphql", "java", "jsdoc", "julia",
--             "kotlin", "ledger", "nix", "ocaml", "ocaml_interface", "php", "ql",
--             "query", "r", "rst", "ruby", "scss", "sparql", "supercollider",
--             "svelte", "teal", "tsx", "turtle", "verilog", "vue", "zig"
--         },
--         highlight = {enable = true, disable = {'vim'}},
--         textobjects = {
--             select = {
--                 enable = true,
--                 keymaps = {
--                     ["af"] = "@function.outer",
--                     ["if"] = "@function.inner",
--                     ["ac"] = "@class.outer",
--                     ["ic"] = "@class.inner"
--                 }
--             }
--         },
--         rainbow = {
--             enable = true,
--             extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
--             max_file_lines = 1000 -- Do not enable for files with more than 1000 lines, int
--         }
--     }
-- end

function config.neoformat()
    vim.g.neoformat_python_enabled_python = "black"

end

function config.easymotion()
    vim.g.EasyMotion_do_mapping = 1
    vim.g.EasyMotion_smartcase = 1
    vim.g.EasyMotion_use_smartsign_us = 1
end

return config
