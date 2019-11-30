""""""""""""""""""""""""""""""""""""""""""""""""""
"		Ryan Lee .vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""
"	Start Vundle Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'

" Document/Writing Support
Plug 'vim-latex/vim-latex'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" Core Vim customization
Plug 'itchyny/lightline.vim'
Plug 'easymotion/vim-easymotion'
"Plug 'SirVer/ultisnips'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'jeetsukumaran/vim-buffergator'

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
autocmd FileType cc set colorcolumn=120 tabstop=2 shiftwidth=2 softtabstop=2 listchars=tab:>-,trail:~ list
autocmd FileType h set colorcolumn=120 tabstop=2 shiftwidth=2 softtabstop=2 listchars=tab:>-,trail:~ list
autocmd FileType hpp set colorcolumn=120 tabstop=2 shiftwidth=2 softtabstop=2 listchars=tab:>-,trail:~ list
autocmd FileType c set colorcolumn=120 tabstop=2 shiftwidth=2 softtabstop=2 listchars=tab:>-,trail:~ list
autocmd FileType xml set tabstop=2 shiftwidth=2 listchars=tab:>-,trail:~ list
autocmd FileType yaml set tabstop=2 shiftwidth=2 listchars=tab:>-,trail:~ list

" Show linenumbers
set number
set relativenumber

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

" EasyMotion Config
nmap / <Plug>(easymotion-tn)
nmap <Leader>s <Plug>(easymotion-overwin-f2)

"""""""""""""""""""""""""""""
"   ALE configurations
"""""""""""""""""""""""""""""
let g:ale_cpp_gcc_options = '-std=c++11 -Wall'
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
    \   '*':['remove_trailing_lines','trim_whitespace'],
    \   'cpp': ['clang-format', 'clangtidy']
    \}
let g:ale_linters={
    \   'cpp' : ['clang', 'g++'],
    \   'python': ['flake8'],
    \   'sh' : ['language_server'],
    \   'cmake' : ['cmake_format', 'cmakelint'],
    \   'dockerfile' : ['hadolint'],
    \   'yaml' : ['yamllint']
    \}
function! UpdateROSIncludeDirs()
    let l:ros_package_path=split($ROS_PACKAGE_PATH, ':')
    let l:cmake_prefix_path=split($CMAKE_PREFIX_PATH, ':')
    let l:paths=l:ros_package_path+l:cmake_prefix_path
    for path in l:paths
        if len($CPATH)
            let $CPATH.=':'.path.'/include'
        else
            let $CPATH.=path.'/include'
        endif
    endfor
endfunction

call UpdateROSIncludeDirs()
" Move between errors with Ctrl+j and Ctrl+k
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

""""""""""""""""""""""""""""""""""""
"   Lightline/ALE configurations
""""""""""""""""""""""""""""""""""""
set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ }

" Lightline Ale
 let g:lightline.component_expand = {
       \  'linter_checking': 'lightline#ale#checking',
       \  'linter_warnings': 'lightline#ale#warnings',
       \  'linter_errors': 'lightline#ale#errors',
       \  'linter_ok': 'lightline#ale#ok',
       \ }

 let g:lightline.component_type = {
       \     'linter_checking': 'left',
       \     'linter_warnings': 'warning',
       \     'linter_errors': 'error',
       \     'linter_ok': 'left',
       \ }
 let g:lightline.active = { 'right': [['filetype'], ['percent', 'lineinfo'], ['linter_checking','linter_errors', 'linter_warnings', 'linter_ok']] }

let g:ycm_semantic_triggers = {
\   'roslaunch' : ['="', '$(', '/'],
\   'rosmsg,rossrv,rosaction' : ['re!^', '/'],
\ }

" vim-ros Config
let g:ros_build_system = "catkin-tools"

" -------------- CtrlP config
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_max_depth = 40
let g:ctrlp_working_path_mode = 'ra'

" ignore compiled files
set wildignore+=*.bin,*/bin/*,*.lib
set wildignore+=*.pyc " python
set wildignore+=*/build/*,*/devel/*,*/logs/* " catkin workspace
set wildignore+=*.o,*.so,*.a " cpp
set wildignore+=*.swp,*~ " swaps
set wildignore+=*.zip,*.deb
set wildignore+=*/.git/* " git
let g:ctrlp_max_depth = 40

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
