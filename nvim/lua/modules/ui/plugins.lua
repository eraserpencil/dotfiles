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
ui['kyazdani42/nvim-tree.lua'] = {
    opt = false,
--    cmd = {'NvimTreeToggle', 'NvimTreeOpen'},
    config = conf.nvim_tree
}
ui['akinsho/nvim-bufferline.lua'] = {
  opt = false, 
  config = conf.nvim_bufferline
}  
ui['kyazdani42/nvim-web-devicons'] = {
  opt = false
}

return ui
