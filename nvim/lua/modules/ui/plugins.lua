local ui = {}
local conf = require('modules.ui.config')

ui['hoob3rt/lualine.nvim'] = {
    opt = true,
    event = "BufWinEnter",
    config = conf.lualine
}
ui['lukas-reineke/indent-blankline.nvim'] = {
    opt = false,
    event = 'BufRead',
    config = conf.indent_blankline
}

return ui
