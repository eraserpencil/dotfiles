local tools = {}
local conf = require('modules.tools.config')

--tools['nvim-telescope/telescope.nvim'] = {
--    opt = true,
--    cmd = 'Telescope',
--    config = conf.telescope,
--    requires = {
----        {'nvim-lua/popup.nvim', opt = true},
--        {'nvim-lua/plenary.nvim', opt = true}
--    }
--}
--tools['nvim-telescope/telescope-fzy-native.nvim'] = {
--    opt = true,
--    after = 'telescope.nvim'
--}
--
---- tools['nvim-telescope/telescope-project.nvim'] = {
----     opt = true,
----     after = 'telescope.nvim'
---- }
--tools['nvim-telescope/telescope-frecency.nvim'] = {
--    opt = false,
--    config = conf.telescope-frecency,
--    after = 'telescope.nvim'
--}

return tools
