" #########  Plugin Mnager ##########
if filereadable(expand('~/.vim/autoload/plug.vim'))

	" Plugins will be downloaded under the specified directory.
	call plug#begin('~/.vim/plugged')

	""""""""""""""""""""""""""""""""""""""""
	" Declare the list of plugins.
	Plug 'mattn/emmet-vim'
	Plug 'tpope/vim-surround'
	Plug 'preservim/nerdtree'

	" For java completion
	Plug 'artur-shaik/vim-javacomplete2'

	" For text alignment
	Plug 'junegunn/vim-easy-align'

	""""""""""""""""""""""""""""""""""""""""

	" List ends here. Plugins become visible to Vim after this call.
	call plug#end()
endif


"#########  set vim's env var  ##########

" Enable vim plugins and indent by file type
filetype plugin indent on

" netrwを使用するための設定
set nocompatible

" Settings about Chracter
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決

" Setting about tab
"set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=4 " 画面上でタブ文字が占める幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
"set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=4 " smartindentで増減する幅

" Settings about Search
set incsearch " Perform a search everytime you type a single character.
set ignorecase
set smartcase " Make the search pattern case-sensitive if it contains uppercase letters.
set hlsearch " Highlighting search results.

" Settings about Command Completion
set wildmenu " Completion in command mode.
set history=5000 " Number of command histories to save.

set laststatus=2 "最下ウィンドウにステータスを常に表示する
syntax on "構文ハイライトを有効にする
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number
set nowrap

if has("win64") || has("win32") || has("win16")
	set clipboard=unnamedplus
else
endif


"クリップボードからのペースト時の自動インデントのズレを調整する
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

"#########  KEY MAPS  ##########

" map leader
let mapleader = ","

" カッコの補完
inoremap {<Enter> {}<Left><CR><ESC><S-o>
"inoremap ( ()<Left>
"inoremap [ []<Left>

" NERDTREEを簡易的に開く
nnoremap <C-x><C-f> :NERDTree<CR>

" 分割ウィンドウの移動を楽にする
nnoremap <C-l> <C-w>w

" 検索後のハイライトを効率的に削除
nnoremap  <C-c><C-c> :<C-u>nohlsearch<cr><Esc>

" Quickly Open ~/.vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>

" Quickly Reload ~/.vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" ファイル拡張子別の設定
if has("autocmd")
    filetype plugin indent on

	" 80行目以降の色を変える
	autocmd FileType c,cpp,python,java,ruby,javascript,sh let &colorcolumn=join(range(81,999),",")
	autocmd FileType c,cpp,python,java,ruby,javascript,sh hi ColorColumn ctermbg=235 guibg=#2c2d27 

    autocmd FileType c           setlocal sw=4 sts=4 ts=4 noexpandtab
    autocmd FileType c           nnoremap <buffer> <C-i> <Home>i//<Esc>
    autocmd FileType c           nnoremap <buffer> <C-f> <Home>"_x"_x<Esc>
    autocmd FileType c           nnoremap <buffer> <C-b> :make
    autocmd FileType c           nnoremap <buffer> <C-e> :make run

    autocmd FileType cpp         setlocal sw=4 sts=4 ts=4 noexpandtab
    autocmd FileType cpp         nnoremap <buffer> <C-i> <Home>i//<Esc>
    autocmd FileType cpp         nnoremap <buffer> <C-f> <Home>"_x"_x<Esc>
    autocmd FileType cpp         nnoremap <buffer> <C-b> :make
    autocmd FileType cpp         nnoremap <buffer> <C-e> :make run
    autocmd FileType cpp         inoremap <buffer> <C-f> <c-o>:r !ins_for.sh cpp
	
    autocmd FileType python      setlocal sw=4 sts=4 ts=4 noexpandtab
    autocmd FileType python      nnoremap <buffer> <C-i> <Home>i#<Esc>
    autocmd FileType python      nnoremap <buffer> <C-f> <Home>"_x<Esc>
    autocmd FileType python      nnoremap <buffer> <C-e> :terminal python3 %

	autocmd FileType java		setlocal omnifunc=javacomplete#Complete
	autocmd FileType java		let g:JavaComplete_SourcesPath = "~/javafx-sdk-16/src/"
	""autocmd FileType java		let g:JavaComplete_LibsPath = "~/javafx-sdk-16/lib/"
	autocmd FileType java		map <F4> <Plug>(JavaComplete-Imports-AddSmart)
	autocmd FileType java		map <F4> <Plug>(JavaComplete-Imports-AddSmart)
	autocmd FileType java		map <F5> <Plug>(JavaComplete-Imports-Add)
	autocmd FileType java		map <F5> <Plug>(JavaComplete-Imports-Add)
	autocmd FileType java		map <F6> <Plug>(JavaComplete-Imports-AddMissing)
	autocmd FileType java		map <F6> <Plug>(JavaComplete-Imports-AddMissing)
	autocmd FileType java		map <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
	autocmd FileType java		map <F7> <Plug>(JavaComplete-Imports-RemoveUnused)

    autocmd FileType html        setlocal sw=4 sts=4 ts=4 noexpandtab
    autocmd FileType html        nnoremap <buffer> <C-i> <End>a--><Esc><Home>i<!--<Esc>
    autocmd FileType html        nnoremap <buffer> <C-f> <End>xxx<Esc><Home>xxxx<Esc>
    autocmd Filetype html        inoremap <buffer> </ </<C-x><C-o><ESC>F<i

    autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 noexpandtab

    autocmd FileType js          setlocal sw=4 sts=4 ts=4 noexpandtab

    autocmd FileType javasctipt  nnoremap <buffer> <C-i> <Home>i//<Esc>
    autocmd FileType javasctipt  nnoremap <buffer> <C-f> <Home>xx<Esc>

    autocmd FileType zsh         setlocal sw=4 sts=4 ts=4 noexpandtab

    autocmd FileType scala       setlocal sw=4 sts=4 ts=4 noexpandtab

    autocmd FileType json        setlocal sw=4 sts=4 ts=4 noexpandtab

    autocmd FileType css         setlocal sw=4 sts=4 ts=4 noexpandtab
    autocmd FileType css         set omnifunc=csscomplete#CompleteCSS
    autocmd FileType css         nnoremap <buffer> <C-i> <End>a*/<Esc><Home>i/*<Esc>
    autocmd FileType css         nnoremap <buffer> <C-f> <End>xx<Esc><Home>xx<Esc>

    autocmd FileType scss        setlocal sw=4 sts=4 ts=4 noexpandtab
    autocmd FileType sass        setlocal sw=4 sts=4 ts=4 noexpandtab

    autocmd FileType sh          nnoremap <buffer> <C-i> <Home>i#<Esc>
    autocmd FileType sh          nnoremap <buffer> <C-f> <Home>x<Esc>
    autocmd FileType sh          setlocal sw=2 sts=2 ts=2 noexpandtab


    autocmd FileType vim         setlocal foldmethod=marker 

    "autocmd FileType text        colorscheme shine
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" 'mattn/emmet-vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:user_emmet_mode = 'iv'
  let g:user_emmet_leader_key = '<C-Y>'
  let g:use_emmet_complete_tag = 1
  let g:user_emmet_settings = {
        \ 'lang' : 'ja',
        \ 'html' : {
        \   'filters' : 'html',
        \ },
        \ 'css' : {
        \   'filters' : 'fc',
        \ },
        \ 'php' : {
        \   'extends' : 'html',
        \   'filters' : 'html',
        \ },
        \}
  augroup EmmitVim
    autocmd!
    autocmd FileType * let g:user_emmet_settings.indentation = '               '[:&tabstop]
  augroup END

