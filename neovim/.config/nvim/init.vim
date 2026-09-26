" row number and cursorline
set number
set cursorline

" no annoying backup files
set nobackup
set nowritebackup
set noswapfile

" search
set ignorecase
set smartcase

" indent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set clipboard=unnamedplus

" russian layout, toggled with <C-^>
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=-1

let mapleader=" "
let maplocalleader = " "
nnoremap <SPACE> <Nop>

nnoremap <leader>tn :tabnew<Enter>
nnoremap <leader>tc :tabclose<Enter>
nnoremap <leader>tl :tabnext<Enter>
nnoremap <leader>th :tabprevious<Enter>

nnoremap <leader>r :source $MYVIMRC<Enter>

nnoremap <leader>ws :split<Enter>
nnoremap <leader>wv :vsplit<Enter>
nnoremap <leader>wh <C-w>h
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wl <C-w>l
nnoremap <leader>wc :q<Enter>

nnoremap <leader>e :e
nnoremap <leader>f :Lexplore<Enter>

" install vim-plug and missing plugins on first start
let s:plug = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(s:plug))
  silent execute '!curl -fLo ' . shellescape(s:plug) . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  execute 'source ' . fnameescape(s:plug)
endif
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
Plug 'joshdick/onedark.vim'
call plug#end()

silent! colorscheme onedark
