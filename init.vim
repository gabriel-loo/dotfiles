"------------------------------------------------------------------------------
" Vim-Plug
"------------------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')
Plug 'j16180339887/XML-fast.vim'
Plug 'kassio/neoterm'
Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-liquid'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'justinmk/vim-dirvish'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'simeji/winresizer'
Plug 'Vimjas/vim-python-pep8-indent'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'derekwyatt/vim-scala'
call plug#end()

" Handle .swp files
set backupdir=~/.config/nvim/backup//
set directory=~/.config/nvim/swap//
set undodir=~/.config/nvim/undo//

" Show line numbers
set number

" Set incremental search
set incsearch

" Ignore case for searching set ignorecase
set ignorecase

" Case-sensitive searching if uppercase is included
set smartcase

" Allow buffer switching if buffer is not written
set hidden

" Set unnamed register to copy/paste to/from clipboard
set clipboard=unnamed

" Hide menus and toolbar
set guioptions-=m
set guioptions-=T " Set to nicer font
set guifont=Monaco:h13

" Use unix file format instead of windows
set ff=unix

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

" edit .zshrc shortcut
:map <Leader>zsh :e ~/.zshrc<CR>
" edit .zpreztorc
:map <Leader>zp :e ~/.zpreztorc<CR>

" Window navigation shortcuts
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
inoremap <C-h> <Esc><C-w>h
inoremap <C-j> <Esc><C-w>j
inoremap <C-k> <Esc><C-w>k
inoremap <C-l> <Esc><C-w>l

" Format JSON
nmap =j :%!python -m json.tool<CR>

" Hide the tab list at the top
set showtabline=0

" Enable mouse
set mouse=a

filetype plugin indent on

set autoindent

" On pressing tab, insert 4 spaces
set expandtab

" Paste multiple times
xnoremap p pgvy
xnoremap P Pgvy

" Delete buffer but do not close window
command! Bd bp | sp | bn | bd

" Remove all trailing whitespace on save for Python files
autocmd BufWritePre *.py :%s/\s\+$//e

" Source vimrc shortcut
nnoremap <Leader>sv :source $MYVIMRC<CR>

" Always do a vertical split for diffs
:set diffopt+=vertical

"Remove all trailing whitespace by pressing F5
nnoremap <Leader><Space> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Add semicolon at the end
inoremap ;; <C-o>A;

" Set status line
set statusline=
set statusline+=%#PmenuSel#
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

"------------------------------------------------------------------------------
" Plugins
"------------------------------------------------------------------------------

"---------------------------------------
" colorscheme
"---------------------------------------
set background=dark
syntax enable
colorscheme jellybeans

" Colour column 80
au FileType python execute "setlocal colorcolumn=" . join(range(121, 335), ',')
highlight ColorColumn ctermbg=240 guibg=#585858

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
" Syntastic
"---------------------------------------

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['tslint', 'tsc']
let g:syntastic_python_flake8_args="--max-line-length=120"
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

"---------------------------------------
" CtrlSpace
"---------------------------------------
let g:CtrlSpaceDefaultMappingKey = "<C-space> "
if has("gui_running")
    " Settings for MacVim and Inconsolata font
    let g:CtrlSpaceSymbols = { "File": "◯", "CTab": "▣", "Tabs": "▢" }
endif

if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif

"---------------------------------------
" NeoVim Terminal
"---------------------------------------
" Enable window navigation in terminal
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <silent> <C-Space> <C-\><C-n>:CtrlSpace<CR>
tnoremap <Esc><Esc> <C-\><C-n>

" Colour the cursor green when in terminal insert mode
highlight TermCursor ctermfg=green guifg=green

" Do not show line numbers in terminal
au TermOpen * setlocal nonumber norelativenumber

" Change default winresizer start key
let g:winresizer_start_key = '<C-w><C-w>'

" Shortcuts to start a new terminal
nnoremap <Leader>tj :sp <BAR> wincmd j <BAR> term<CR>
nnoremap <Leader>tk :sp <BAR> term<CR>
nnoremap <Leader>tl :vsp <BAR> wincmd l <BAR> term<CR>
nnoremap <Leader>th :vsp <BAR> term<CR>
nnoremap <Leader>tt :term<CR>

"---------------------------------------
" Netrw
"---------------------------------------
" Hide file types in netrw
let g:netrw_list_hide='.*\.swp$,.*\.swo$,.*\.pyc$'


"---------------------------------------
" Dirvish
"---------------------------------------
" Sort folders at the top and hide file types
let g:dirvish_mode = ':sort ,^.*[\/], | :silent keeppatterns g/\.swp$\|\.swo$\|\.pyc$/d _'

" Support using '-' in terminal mode to open CWD in Dirvish
nnoremap <expr> <silent> - &buftype ==# 'terminal' ? ':enew <BAR> Dirvish<CR>' : ':execute "normal \<Plug>(dirvish_up)"<CR>'


"---------------------------------------
" Ack
"---------------------------------------
if executable('ag')
    " Use the_silver_searcher (ag) insted of ack
    let g:ackprg = 'ag --vimgrep'
endif

"---------------------------------------
" FZF
"---------------------------------------
nnoremap <C-p> :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>i :History<CR>

"---------------------------------------
" coc.nvim
"---------------------------------------
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Show JSON comments
autocmd FileType json syntax match Comment +\/\/.\+$+

"---------------------------------------
" vim-scala
"---------------------------------------
au BufRead,BufNewFile *.sbt set filetype=scala
