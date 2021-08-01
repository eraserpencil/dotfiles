local completion = {}
local conf = require('modules.completion.config')

--completion['neovim/nvim-lspconfig'] = {
--    opt = true,
--    event = 'BufRead',
--    config = conf.nvim_lsp
--}
--completion['kabouzeid/nvim-lspinstall'] = {
--    opt = true,
--    cmd = {'LspInstall', 'LspUninstall'}
--}
--completion['glepnir/lspsaga.nvim'] = {
--    opt = true,
--    cmd = 'Lspsaga',
--    config = conf.saga
--}
--completion['hrsh7th/nvim-compe'] = {
--    opt = true,
--    event = 'InsertEnter',
--    after = 'nvim-lspconfig',
--    config = conf.compe
--}
--completion['ray-x/lsp_signature.nvim'] = {opt = true, after = 'nvim-lspconfig'}
--completion['tzachar/compe-tabnine'] = {
--    opt = true,
--    after = 'nvim-compe',
--    run = './install.sh'
--}
--completion['windwp/nvim-autopairs'] = {
--    opt = true,
--    event = 'InsertCharPre',
--    config = conf.autopairs
--}
completion['neoclide/coc.nvim'] = {
    opt = true,
}
return completion
