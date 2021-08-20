local editor = {}
local conf = require('modules.editor.config')

-- Easy align tabs and spaces
editor['junegunn/vim-easy-align'] = {opt = true, cmd = 'EasyAlign'}

-- Underlines all instances of word in current buffer
editor['itchyny/vim-cursorword'] = {
    opt = true,
    event = {'BufReadPre', 'BufNewFile'},
    config = conf.vim_cursorwod
}

editor['sbdchd/neoformat'] = {
    opt = true,
    cmd = 'Neoformat',
    config = conf.neoformat
}

editor['norcalli/nvim-colorizer.lua'] = {
    opt = true,
    event = 'BufRead',
    config = conf.nvim_colorizer
}

-- Disables Search HL after search
editor['romainl/vim-cool'] = {
    opt = true,
    event = {'CursorMoved', 'InsertEnter'}
}

editor['easymotion/vim-easymotion'] = {opt = true, config = conf.easymotion}

-- Close html,tsx,vue,svelte,php tags
editor['windwp/nvim-ts-autotag'] = {
    opt = true,
    ft = {'html', 'xml'},
    config = conf.autotag
}

-- for nvim 0.6
--editor['nvim-treesitter/nvim-treesitter'] = {
--    opt = true,
--    run = ':TSUpdate',
--    event = 'BufRead',
--    after = 'telescope.nvim',
--    config = conf.nvim_treesitter
--}

return editor
