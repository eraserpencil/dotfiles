local editor = {}
local conf = require('modules.editor.config')

editor['junegunn/vim-easy-align'] = {opt = true, cmd = 'EasyAlign'}
-- for nvim 0.6
--editor['nvim-treesitter/nvim-treesitter'] = {
--    opt = true,
--    run = ':TSUpdate',
--    event = 'BufRead',
--    after = 'telescope.nvim',
--    config = conf.nvim_treesitter
--}
--editor['nvim-treesitter/nvim-treesitter-textobjects'] = {
--    opt = true,
--    after = 'nvim-treesitter'
--}
editor['sbdchd/neoformat'] = {
    opt = true,
    config = conf.neoformat
}
editor['easymotion/vim-easymotion'] = {opt = true, config = conf.easymotion}

return editor
