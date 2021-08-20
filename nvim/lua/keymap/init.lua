local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_args = bind.map_args
require('keymap.config')

local plug_map = {
    -- Complete
    ["i|<C-e>"] = map_cmd([[compe#close('<C-e>')]]):with_expr():with_silent(),
    ["i|<C-f>"] = map_cmd([[compe#scroll({ 'delta': +4 })]]):with_expr()
        :with_silent(),
    ["i|<C-d>"] = map_cmd([[compe#scroll({ 'delta': -4 })]]):with_expr()
        :with_silent(),
    ["i|<C-Space>"] = map_cmd([[compe#complete()]]):with_expr():with_silent(),
    ["i|<Tab>"] = map_cmd("v:lua.tab_complete()"):with_expr():with_silent(),
    ["s|<Tab>"] = map_cmd("v:lua.tab_complete()"):with_expr():with_silent(),
    ["i|<S-Tab>"] = map_cmd("v:lua.s_tab_complete()"):with_expr():with_silent(),
    ["s|<S-Tab>"] = map_cmd("v:lua.s_tab_complete()"):with_expr():with_silent(),
    -- Bufferline
    ["n|gb"] = map_cr("BufferLinePick"):with_noremap():with_silent(),
    ["n|<A-j>"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent(),
    ["n|<A-k>"] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent(),
    ["n|<A-S-j>"] = map_cr("BufferLineMoveNext"):with_noremap():with_silent(),
    ["n|<A-S-k>"] = map_cr("BufferLineMovePrev"):with_noremap():with_silent(),
    ["n|<leader>be"] = map_cr("BufferLineSortByExtension"):with_noremap(),
    ["n|<leader>bd"] = map_cr("BufferLineSortByDirectory"):with_noremap(),
    -- Packer
    ["n|<leader>ps"] = map_cr("PackerSync"):with_silent():with_noremap()
        :with_nowait(),
    ["n|<leader>pu"] = map_cr("PackerUpdate"):with_silent():with_noremap()
        :with_nowait(),
    ["n|<leader>pi"] = map_cr("PackerInstall"):with_silent():with_noremap()
        :with_nowait(),
    ["n|<leader>pc"] = map_cr("PackerCompile"):with_silent():with_noremap()
        :with_nowait(),
    -- Lsp mapp work when insertenter and lsp start
    ["n|<leader>li"] = map_cr("LspInfo"):with_noremap():with_silent()
        :with_nowait(),
    ["n|<leader>lr"] = map_cr("LspRestart"):with_noremap():with_silent()
        :with_nowait(),
    ["n|gD"] = map_cmd("<cmd>lua vim.lsp.buf.implementation()<CR>"):with_noremap()
        :with_silent(),
    ["n|gt"] = map_cmd("<cmd>lua vim.lsp.buf.type_definition()<CR>"):with_noremap()
        :with_silent(),
    ["n|<Leader>cw"] = map_cmd("<cmd>lua vim.lsp.buf.workspace_symbol()<CR>"):with_noremap()
        :with_silent(),
    -- Plugin nvim-tree
    ["n|<C-n>"] = map_cr('NvimTreeToggle'):with_noremap():with_silent(),
    ["n|<Leader>nf"] = map_cr('NvimTreeFindFile'):with_noremap():with_silent(),
    ["n|<Leader>nr"] = map_cr('NvimTreeRefresh'):with_noremap():with_silent(),
    -- Plugin Easymotion
    ["n|;"] = map_cmd("v:lua.enhance_ft_move(';')"):with_expr(),
    ["n|;"] = map_cmd("v:lua.enhance_ft_move(';')"):with_expr(),
    ["n|<leader>j"] = map_cmd("v:lua.enhance_move('lnj')"):with_expr(),
    ["n|<leader>k"] = map_cmd("v:lua.enhance_move('lnk')"):with_expr(),
    ["n|<leader>f"] = map_cmd("v:lua.enhance_move('lnf')"):with_expr(),
    ["n|<leader>w"] = map_cmd("v:lua.enhance_move('lnw')"):with_expr(),
    ["|<leader>f"] = map_cmd("v:lua.enhance_move('lf')"):with_expr(),
    ["|<leader>w"] = map_cmd("v:lua.enhance_move('lw')"):with_expr(),
    -- Plugin EasyAlign
    ["n|ga"] = map_cmd("v:lua.enhance_align('nga')"):with_expr(),
    ["x|ga"] = map_cmd("v:lua.enhance_align('xga')"):with_expr(),
};

bind.nvim_load_mapping(plug_map)
