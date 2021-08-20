local tools = {}
local conf = require('modules.tools.config')

--tools['nvim-telescope/telescope.nvim'] = {
--    opt = true,
--    cmd = 'Telescope',
--    config = conf.telescope,
--    requires = {
--        {'nvim-lua/plenary.nvim', opt = true}
--    }
--}
--
--tools['nvim-telescope/telescope-fzy-native.nvim'] = {
--    opt = true,
--    after = 'telescope.nvim'
--}

--tools['folke/trouble.nvim'] = {
--    opt = true,
--    cmd = {"Trouble", "TroubleToggle", "TroubleRefresh"},
--    config = conf.trouble
--}
return tools
