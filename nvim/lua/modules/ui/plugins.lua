local ui = {}
local conf = require('modules.ui.config')

ui['monsonjeremy/onedark.nvim'] = {
    opt = false,
    config = conf.onedark,
}
ui['hoob3rt/lualine.nvim'] = {opt = false, config = conf.lualine}
-- ui['lewis6991/gitsigns.nvim'] = {
--     opt = true,
--     event = {'BufRead', 'BufNewFile'},
--     config = conf.gitsigns,
-- --    requires = {'nvim-lua/plenary.nvim', opt = true}
-- }
 ui['lukas-reineke/indent-blankline.nvim'] = {
     opt = false,
     event = 'BufRead',
     config = conf.indent_blankline
 }
return ui
