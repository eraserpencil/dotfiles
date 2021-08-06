local completion = {}
local conf = require('modules.completion.config')

completion['neovim/nvim-lspconfig'] = {
    opt = true,
    event = 'BufRead',
    config = conf.nvim_lsp
}
completion['kabouzeid/nvim-lspinstall'] = {
    opt = true,
    cmd = {'LspInstall', 'LspUninstall'}
}
completion['hrsh7th/nvim-compe'] = {
    opt = true,
    event = 'InsertEnter',
    after = 'nvim-lspconfig',
    config = conf.compe
}
completion['ray-x/lsp_signature.nvim'] = {
    opt = true,
    after = 'nvim-lspconfig',
    config = conf.nvim_signature
}
completion['windwp/nvim-autopairs'] = {
    opt = true,
    event = 'InsertCharPre',
    after = 'nvim-lspconfig',
    config = conf.autopairs
}
return completion
