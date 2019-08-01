""""""""""""""""""""""""""""""""""""""""""""""""""
"		Ryan Lee .vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""
"	Start Vundle Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
""""""""""""""""""""""""""""""""""""""""""""""""""

set t_Co=256                         " Enable 256 colors

if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://sunaku.github.io/vim-256color-bce.html
    set t_ut=
endif

call plug#begin()
set nocompatible            " be iMproved, required

" Programming Support
Plug 'w0rp/ale'
Plug 'Valloric/YouCompleteMe'
Plug 'taketwo/vim-ros'
Plug 'maximbaz/lightline-ale'

" Document/Writing Support
Plug 'vim-latex/vim-latex'
" Plug 'SidOfc/mkdx'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'gabrielelana/vim-markdown'

" Core Vim customization
Plug 'itchyny/lightline.vim'
Plug 'easymotion/vim-easymotion'
Plug 'SirVer/ultisnips'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'bronson/vim-trailing-whitespace'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'danro/rename.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""
"	Vimrc Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = "`"
set background=dark
set encoding=utf8
set backspace=indent,eol,start

" Set Proper Tabs
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set autoindent                " indents according to tabstop and shiftwidth
set formatoptions=coql

highlight ColorColumn ctermbg=darkgrey
autocmd FileType python set colorcolumn=80 listchars=tab:>-,trail:~ list
autocmd FileType cpp set colorcolumn=120 tabstop=2 shiftwidth=2 softtabstop=2 listchars=tab:>-,trail:~ list
autocmd FileType c set colorcolumn=80 tabstop=2 shiftwidth=2 softtabstop=2 listchars=tab:>-,trail:~ list
autocmd FileType xml set tabstop=2 shiftwidth=2 listchars=tab:>-,trail:~ list
autocmd FileType yaml set tabstop=2 shiftwidth=2 listchars=tab:>-,trail:~ list

" Show linenumbers
set number
set relativenumber

" Set change word to WORD
vnoremap <leader>" di""<esc>hp
vnoremap <leader>' di''<esc>hp
vnoremap <leader>< di<><esc>hp
vnoremap <leader>{ di{}<esc>hp
vnoremap <leader>[ di[]<esc>hp

" Split navigations
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>
nnoremap j gj
nnoremap k gk

" Navigation edit
nnoremap <C-O> O<Esc>
nnoremap <C-o> o<Esc>
nnoremap H 0
nnoremap L $

" Using system's primary/clipboard selections
noremap <Leader>Y "*y
noremap <Leader>P "*p
noremap <Leader>y "+y
noremap <Leader>p "+p
set pastetoggle=<F3>

" Enable highlighting of the current line
set wrap                      " wraps lines
set linebreak                 " prevents wrapping midword
set nolist                    " prevents linebreak from not working
set cursorline
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')           " lin- jumps around line wrapping
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')           " line jumps around line wrapping


" Vim-markdown config
let g:markdown_include_jekyll_support = 0

"" MKDX config
"let g:mkdx#settings = { 'fold': { 'components': ['toc'] } }
"let g:mkdx#settings = { 'fold': { 'enable': 1 } }
"let g:mkdx#settings = { 'links': { 'external': { 'user_agent': 'Mozilla/5.0 (X11; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0' } } }
"let g:mkdx#settings = { 'tokens': { 'fence': '`' } }
"let g:mkdx#settings = { 'tokens': { 'italic': '~' } }
"let g:mkdx#settings = { 'tokens': { 'strike': '_' } }
"let g:mkdx#settings = { 'image_extension_pattern': 'a\?png\|jpg\?g\|gif' }
"let g:mkdx#settings = { 'checkbox': { 'toggles': [' ', 'x'] } }
"let g:mkdx#settings = { 'toc': { 'save_on_write': 1 } }
"let g:mkdx#settings = { 'toc': { 'position': 1 } }


" EasyMotion Config
nmap / <Plug>(easymotion-tn)
nmap <Leader>s <Plug>(easymotion-overwin-f2)

" ALE configurations
let g:ale_sign_column_always = 1
let g:ale_list_window_size = 3
let g:ale_fix_on_save = 1
let g:ale_cpp_clang_options = "-std=c++11 -Wall"
let g:ale_c_build_dir = "/home/ryan/mov/catkin_ws/src"
let g:ale_c_parse_makefule = 1

" Lightline Config
set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ }

" -------------- Airline status bar config
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'angr'
let g:bufferline_echo = 0
let g:airline#extensions#tabline#enabled = 1
set ttimeoutlen=50 " Make airline mode update faster

" " Lightline Ale
" let g:lightline.component_expand = {
"       \  'linter_checking': 'lightline#ale#checking',
"       \  'linter_warnings': 'lightline#ale#warnings',
"       \  'linter_errors': 'lightline#ale#errors',
"       \  'linter_ok': 'lightline#ale#ok',
"       \ }
"
" let g:lightline.component_type = {
"       \     'linter_checking': 'left',
"       \     'linter_warnings': 'warning',
"       \     'linter_errors': 'error',
"       \     'linter_ok': 'left',
"       \ }
"
" let g:lightline.active = { 'right': [['filetype'], ['lineinfo'], ['linter_checking','linter_errors', 'linter_warnings', 'linter_ok']] }

" Buffergator config
" let g:buffergator_suppress_mru_switch_into_splits_keymaps = 1


" Default fzf layout
let g:fzf_layout = { 'down': '30%' }

" Completer config
let g:completer_python_binary = '/home/ryan/.local/lib/python2.7/site-packages'

" SuperTab config
let g:SuperTabDefaultCompletionType = "<c-n>"

" ros-vim Config
let g:ros_build_system = "catkin-tools"

" -------------- CtrlP config
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_max_depth = 40
let g:ctrlp_working_path_mode = 'ra'

" -------------- Running python/bash scripts from vim
nnoremap <Leader>rp2 :echo system('python2 "' . expand('%') . '"')<cr>
nnoremap <Leader>rp3 :echo system('python3 "' . expand('%') . '"')<cr>
nnoremap <Leader>rb :echo system('bash "' . expand('%') . '"')<cr>

autocmd FileType c,cpp,python,roslaunch,vim autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd VimResized * wincmd =

" --------------  NERD Commenter config
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" -------------- Git gutter config
set updatetime=100 " Reduce vim update time to make the diff gutter apear/update faster

" -------------- Filetype matching
autocmd BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp
autocmd BufNewFile,BufReadPost *.urdf,*.world,*.sdf set filetype=xml
autocmd BufNewFile,BufReadPost *.launch set filetype=roslaunch

" map the keys 'jk' to the Escape key to improve  efficiency.
imap jk <Esc>
" File diff mappings
nnoremap <Leader>dt :windo diffthis<cr>
nnoremap <Leader>do :windo diffoff<cr>

" Buffer navigation mappings
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-X> :bdelete<CR>

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
