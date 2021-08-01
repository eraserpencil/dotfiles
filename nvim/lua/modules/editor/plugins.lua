local editor = {}
local conf = require('modules.editor.config')

editor['junegunn/vim-easy-align'] = {opt = true, cmd = 'EasyAlign'}
editor['itchyny/vim-cursorword'] = {
    opt = true,
    event = {'BufReadPre', 'BufNewFile'},
    config = conf.vim_cursorword
}
editor['nvim-treesitter/nvim-treesitter'] = {
    opt = true,
    run = ':TSUpdate',
    event = 'BufRead',
    after = 'telescope.nvim',
    config = conf.nvim_treesitter
}
editor['nvim-treesitter/nvim-treesitter-textobjects'] = {
    opt = true,
    after = 'nvim-treesitter'
}
editor['sbdchd/neoformat'] = {opt = true, cmd = 'Neoformat'}
editor['windwp/nvim-ts-autotag'] = {
    opt = true,
    ft = {'html', 'xml'},
    config = conf.autotag
}
editor['easymotion/vim-easymotion'] = {opt = true, config = conf.easymotion}
editor['norcalli/nvim-colorizer.lua'] = {
    opt = true,
    event = 'BufRead',
    config = conf.nvim_colorizer
}

return editor
