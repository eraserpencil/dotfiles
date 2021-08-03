local ui = {}
local conf = require('modules.ui.config')

--ui['projekt0n/github-nvim-theme'] = {
--    opt = false,
--    config = conf.github,
--}
ui['monsonjeremy/onedark.nvim'] = {
    opt = false,
    config = conf.onedark,
}
ui['hoob3rt/lualine.nvim'] = {opt = false, config = conf.lualine}
--ui['glepnir/dashboard-nvim'] = {opt = false, config = conf.dashboard}
ui['kyazdani42/nvim-tree.lua'] = {
    opt = true,
    cmd = {'NvimTreeToggle', 'NvimTreeOpen'},
    config = conf.nvim_tree,
}
ui['lewis6991/gitsigns.nvim'] = {
    opt = true,
    event = {'BufRead', 'BufNewFile'},
    config = conf.gitsigns,
    requires = {'nvim-lua/plenary.nvim', opt = true}
}
ui['lukas-reineke/indent-blankline.nvim'] = {
    opt = true,
    event = 'BufRead',
    config = conf.indent_blankline
}
ui['akinsho/nvim-bufferline.lua'] = {
    opt = false,
    config = conf.nvim_bufferline,
}
ui['folke/zen-mode.nvim'] = {
    opt = true,
    cmd = 'ZenMode',
    config = conf.zen_mode
}

return ui
