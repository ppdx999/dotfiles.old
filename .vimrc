

" ファイルタイプ別のVimプラグイン/インデントを有効にする
filetype plugin indent on

" netrwを使用するための設定
set nocompatible
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"文字に関する設定
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決

"タブに関する設定
set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=4 " 画面上でタブ文字が占める幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=4 " smartindentで増減する幅

"文字列検索に関する設定
set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト

set clipboard=unnamedplus
set laststatus=2 "最下ウィンドウにステータスを常に表示する
:syntax on "構文ハイライトを有効にする

"カーソルに関する設定
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number " 行番号を表示

"ノーマルモードから改行を挿入できるように設定
nnoremap O :<C-u>call append(expand('.'), '')<Cr>j

"コマンド補完に関する設定
set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数

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

" ファイル拡張子別の設定
if has("autocmd")
    filetype plugin indent on
    autocmd FileType c           setlocal sw=2 sts=2 ts=2 noexpandtab
    autocmd FileType c           nnoremap <buffer> <C-i> <Home>i//<Esc>
    autocmd FileType c           nnoremap <buffer> <C-f> <Home>"_x"_x<Esc>
    autocmd FileType c           nnoremap <buffer> <C-b> :make
    autocmd FileType c           nnoremap <buffer> <C-e> :make run

    autocmd FileType cpp         setlocal sw=2 sts=2 ts=2 noexpandtab
    autocmd FileType cpp         nnoremap <buffer> <C-i> <Home>i//<Esc>
    autocmd FileType cpp         nnoremap <buffer> <C-f> <Home>"_x"_x<Esc>
    autocmd FileType cpp         nnoremap <buffer> <C-b> :make
    autocmd FileType cpp         nnoremap <buffer> <C-e> :make run

    autocmd FileType python      setlocal sw=2 sts=2 ts=2 noexpandtab
    autocmd FileType python      nnoremap <buffer> <C-i> <Home>i#<Esc>
    autocmd FileType python      nnoremap <buffer> <C-f> <Home>"_x<Esc>
    autocmd FileType python      nnoremap <buffer> <C-e> :terminal python3 %

    autocmd FileType html        setlocal sw=2 sts=2 ts=2 noexpandtab
    autocmd FileType html        nnoremap <buffer> <C-i> <End>a--><Esc><Home>i<!--<Esc>
    autocmd FileType html        nnoremap <buffer> <C-f> <End>xxx<Esc><Home>xxxx<Esc>

    autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 noexpandtab
    autocmd FileType js          setlocal sw=2 sts=2 ts=2 noexpandtab
    autocmd FileType javasctipt  nnoremap <buffer> <C-i> <Home>i//<Esc>
    autocmd FileType javasctipt  nnoremap <buffer> <C-f> <Home>xx<Esc>
    autocmd FileType zsh         setlocal sw=2 sts=2 ts=2 noexpandtab

    autocmd FileType scala       setlocal sw=2 sts=2 ts=2 noexpandtab
    autocmd FileType json        setlocal sw=2 sts=2 ts=2 noexpandtab

    autocmd FileType css         setlocal sw=2 sts=2 ts=2 noexpandtab
    autocmd FileType css         nnoremap <buffer> <C-i> <End>a*/<Esc><Home>i/*<Esc>
    autocmd FileType css         nnoremap <buffer> <C-f> <End>xx<Esc><Home>xx<Esc>

    autocmd FileType scss        setlocal sw=2 sts=2 ts=2 noexpandtab
    autocmd FileType sass        setlocal sw=2 sts=2 ts=2 noexpandtab

    autocmd FileType sh          nnoremap <buffer> <C-i> <Home>i#<Esc>
    autocmd FileType sh          nnoremap <buffer> <C-f> <Home>x<Esc>
endif
