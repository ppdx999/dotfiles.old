set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileformats=unix,dos,mac
set fileencodings=utf-8,sjis,ucs-boms,euc-jp,cp932

syntax enable
filetype on

set ambiwidth=double
set nobackup
set nowritebackup
set number
set nowrap
set nowrapscan
set showmatch
set autoindent
set expandtab
set whichwrap=h,l
set tabstop=2
set shiftwidth=2
set helplang=en
set hidden
set wildmenu
set history=2000
set incsearch
set hlsearch
set ignorecase
set smartcase
set clipboard=unnamedplus
set clipboard+=unnamed
set cmdheight=2
set vb t_vb=
set laststatus=2
set statusline=%f

let mapleader = ","
let maplocalleader = ";"

nnoremap <Space>w :<C-u>w<CR>
nnoremap <Space>q :<C-u>q<CR>

nnoremap k   gk
nnoremap j   gj
vnoremap k   gk
vnoremap j   gj
nnoremap gk  k
nnoremap gj  j
vnoremap gk  k
vnoremap gj  j

cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

nnoremap <Space>f :Ve<CR>

nnoremap <silent> tt  :<C-u>tabe<CR>
nnoremap ]t :tabn<CR>
nnoremap [t :tabp<CR>

nnoremap <c-h> <c-w><c-h>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>

nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>

nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

nnoremap <Space>/  *<C-o>
nnoremap g<Space>/ g*<C-o>

nnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
nnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'nzv'
vnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
vnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'nzv'

function! s:search_forward_p()
  return exists('v:searchforward') ? v:searchforward : 1
endfunction

nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

nnoremap gs  :<C-u>%s///g<Left><Left><Left>
vnoremap gs  :s///g<Left><Left><Left>

nnoremap <Space>o  :<C-u>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap <Space>O  :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q gq

call plug#begin('~/.vim/plugged')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tpope/vim-surround'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  Plug 'preservim/nerdtree'
  Plug 'tpope/vim-commentary'
  Plug 'yuttie/comfortable-motion.vim'
call plug#end()

runtime! plugins/*.vim
