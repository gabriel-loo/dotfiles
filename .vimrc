"------------------------------------------------------------------------------
" Vundle
"------------------------------------------------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'nanotech/jellybeans.vim'
Plugin 'nvie/vim-flake8'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/syntastic'
Plugin 'sunaku/vim-ruby-minitest'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'
Plugin 'vim-scripts/confluencewiki.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-ctrlspace/vim-ctrlspace'
Plugin 'leafgarland/typescript-vim'

" SQL plugins
Plugin 'vim-scripts/Align'
Plugin 'vim-scripts/SQLUtilities'

" Javascript plugins
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'marijnh/tern_for_vim'
Bundle 'mxw/vim-jsx'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"------------------------------------------------------------------------------
" Personal Settings/Tweaks
"------------------------------------------------------------------------------

" Set default directory
cd ~/dev

" Set backup directory
set backup
set backupdir=~/.vim/backup/
set directory=~/.vim/swp/

" Show line numbers
set number

" Set incremental search
set incsearch

" Highlight search result
set hlsearch

" Ignore case for searching
set ignorecase

" Case-sensitive searching if uppercase is included
set smartcase

" Allow buffer switching if buffer is not written
set hidden

" Set unnamed register to copy/paste to/from clipboard
set clipboard=unnamed

" Hide menus and toolbar
set guioptions-=m
set guioptions-=T

" Set to nicer font
set guifont=Monaco:h13

" Use unix file format instead of windows
set ff=unix

" Set tabstops
autocmd FileType ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype groovy setlocal ts=4 sts=4 sw=4
autocmd Filetype java setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype yaml setlocal ts=4 sts=4 sw=4
set expandtab
set autoindent

" Set visual bell-- no more beeps
set vb

" Turn syntax highlighting on
syntax on

" Make the command-line completion better
set wildmenu

" set mapleader to comma
let mapleader=","

" edit vimrc shortcut
:map <Leader>v :e $MYVIMRC<CR>

" Turn off search highlighting
nnoremap <leader>h :noh<CR>

" Window navigation shortcuts
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Format JSON
nmap =j :%!python -m json.tool<CR>
"
" Hide file types in netrw
let g:netrw_list_hide= '.*\.swp$,.*\.swo$,.*\.pyc$'

" Hide the tab list at the top
set showtabline=0


"------------------------------------------------------------------------------
" Plugins
"------------------------------------------------------------------------------

"---------------------------------------
" colorscheme
"---------------------------------------

syntax enable
colorscheme jellybeans

" Colour column 80
execute "set colorcolumn=" . join(range(121,335), ',')
highlight ColorColumn ctermbg=235 guibg=#545550

"---------------------------------------
" Tagbar
"---------------------------------------

" Tagbar support for groovy
let g:tagbar_type_groovy = {
    \ 'ctagstype' : 'java',
    \ 'kinds'     : [
        \ 'p:packages:1:1',
        \ 'f:fields:0:1',
        \ 'g:enum types:0:1',
        \ 'e:enum constants:0:1',
        \ 'i:interfaces:0:1',
        \ 'c:classes:0:1',
        \ 'm:methods:0:1',
        \ 't:variables:0:1'
    \ ],
    \ 'kind2scope' : {
        \ 'g' : 'enum',
        \ 'i' : 'interface',
        \ 'c' : 'class'
    \ },
    \ 'sro' : '.'
\ }

" toggle tagbar shortcut
:map <Leader>rt :TagbarToggle<CR>

"---------------------------------------
" CtrlP
"---------------------------------------

" toggle CtrlP shortcut ('f' for file or find)
let g:ctrlp_map = '<Leader>f'
let g:ctrlp_working_path_mode = ''

" buffer management
:map <Leader>b :CtrlPBuffer<CR>

" delete buffer
let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }

func! MyCtrlPMappings()
    nnoremap <buffer> <silent> <c-q> :call <sid>DeleteBuffer()<cr>
endfunc

func! s:DeleteBuffer()
    let line = getline('.')
    let bufid = line =~ '\[\d\+\*No Name\]$' ? str2nr(matchstr(line, '\d\+'))
        \ : fnamemodify(line[2:], ':p')
    exec "bd" bufid
    exec "norm \<F5>"
endfunc

"---------------------------------------
" vimwiki
"---------------------------------------

" set vimwiki syntax default to markdown
let g:vimwiki_list = [{'path': '~/vimwiki/','syntax': 'markdown', 'ext': '.md'}]

"---------------------------------------
" delimitMate
"---------------------------------------

" turn on <CR> expansion for delimitMate
let delimitMate_expand_cr = 1

"---------------------------------------
" Ack/Ag
"---------------------------------------

" set mapping for Ack
:map <C-S-F> :Ag<space>

"---------------------------------------
" Flake8
"---------------------------------------

" Ignore max line length errors
" let g:flake8_ignore="E501"

" Automatically run whenever writing to a Python file
" autocmd BufWritePost *.py call Flake8()

"---------------------------------------
" Syntastic
"---------------------------------------

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['tslint', 'tsc']
let g:syntastic_python_flake8_args="--max-line-length=120"

"---------------------------------------
" Syntastic
"---------------------------------------

let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

"---------------------------------------
" SQLUtilities
"---------------------------------------
vmap <silent>sf <Plug>SQLU_Formatter<CR>

"---------------------------------------
" CtrlSpace
"---------------------------------------
if has("gui_running")
    " Settings for MacVim and Inconsolata font
    let g:CtrlSpaceSymbols = { "File": "◯", "CTab": "▣", "Tabs": "▢" }
endif

if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
