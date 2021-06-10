" #########  Plugin Mnager ##########
if filereadable(expand('~/.vim/autoload/plug.vim')) && !has("gui_running")

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


"######### gvim Settings ##########
if has("gui_running")
	set guifont=Nsimsun:h12
endif

"#########  set vim's env var  ##########

if v:version >= 600
  filetype plugin on
  filetype indent on
else
  filetype on
endif

set nocompatible

set textwidth=0 " Disable automatic line break feature.

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
	set clipboard=unnamed
else
	set clipboard=unnamedplus
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

" completion of parentheses
inoremap {<Enter> {}<Left><CR><ESC><S-o>
"inoremap ( ()<Left>
"inoremap [ []<Left>

if isdirectory(expand('~/.vim/plugged/nerdtree'))
	" Quickly Open NERDTree
	nnoremap <C-x><C-f> :NERDTree<CR>
endif

" Quickly move another window
nnoremap <C-l> <C-w>w

" Quickly remove highlishts
nnoremap  <C-c><C-c> :<C-u>nohlsearch<cr><Esc>

" Quickly Open ~/.vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>

" Quickly Reload ~/.vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" Surround selected text with ( ,' or " and cancel it.
vnoremap s( :<c-u>call <SID>InsTxtAroundSelection( 'inline', '(', ')')<CR>
vnoremap s' :<c-u>call <SID>InsTxtAroundSelection( 'inline', "'", "'")<CR>
vnoremap s" :<c-u>call <SID>InsTxtAroundSelection( 'inline', '"', '"')<CR>
nnoremap <leader>u( vi(yva(p
nnoremap <leader>u' vi'yva'p
nnoremap <leader>u" vi"yva"p

"Quickly move cursor in insert mode.
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>


" Automatically execute ctags
"autocmd BufWritePost * call system("ctags -R")
"nnoremap <C-]> g<C-]>

" Completion using a syntax file
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
          \	if &omnifunc == "" |
          \		setlocal omnifunc=syntaxcomplete#Complete |
          \	endif
endif

if has("autocmd")

	"#########  ftdetect  ##########
	autocmd BufNewFile,BufRead *.md	set filetype=markdown
	autocmd BufNewFile,BufRead *.txt set filetype=text
	autocmd BufRead,BufNewFile * if !did_filetype() && getline(1) =~# '@startuml\>'| setfiletype plantuml | endif
	autocmd BufRead,BufNewFile *.pu,*.uml,*.plantuml,*.puml,*.iuml set filetype=plantuml

	" Change the background color of columns 80 and beyond.
	autocmd FileType c,cpp,python,java,ruby,javascript,sh let &colorcolumn=join(range(81,999),",")
	autocmd FileType c,cpp,python,java,ruby,javascript,sh hi ColorColumn ctermbg=235 guibg=#2c2d27 


	autocmd FileType sh,markdown,text,plantuml    let maplocalleader = ";"

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
	if filereadable(expand('~/format/fmt.sh'))
		autocmd FileType sh          nnoremap <buffer> <localleader>zz gg:r !cat ~/format/fmt.sh<CR>ggdd
	endif

    autocmd FileType vim         setlocal foldmethod=marker 

	" Make selected text Bold
    autocmd FileType markdown,text    vnoremap <buffer> <localleader>b :<c-u>call <SID>InsTxtAroundSelection( 'inline', '**' , '**')<CR>
    autocmd FileType markdown,text    nnoremap <buffer> <localleader>ub F*hvldf*vld
	" Make selected text inline code
    autocmd FileType markdown,text    vnoremap <buffer> <localleader>i :<c-u>call <SID>InsTxtAroundSelection( 'inline', '`', '`')<CR>
    autocmd FileType markdown,text    nnoremap <buffer> <localleader>ui F`xf`x
	" Make selected text color Blue
    autocmd FileType markdown,text    vnoremap <buffer> <localleader>fb :<c-u>call <SID>InsTxtAroundSelection( 'inline', '<span style="color: blue;">', '</span>')<CR>
	" Make selected text color Red
    autocmd FileType markdown,text    vnoremap <buffer> <localleader>fr :<c-u>call <SID>InsTxtAroundSelection( 'inline', '<span style="color: red;">', '</span>')<CR>
	" Delete color
    autocmd FileType markdown,text    nnoremap <buffer> <localleader>uf vityvatp
	" Make selected text Code Block
    autocmd FileType markdown,text    vnoremap <buffer> <localleader>c :<c-u>call <SID>InsTxtAroundSelection( 'block', '<pre><code class="prettyprint linenums">', '</code></pre>')<CR>
    autocmd FileType markdown,text    nnoremap <buffer> <localleader>uc vityvatpvityvatpmm`]dd`mdd
	" Make selected text List
    autocmd FileType markdown,text    vnoremap <buffer> <localleader>l :<c-u>call <SID>MarkdownFormatList()<CR>:nohlsearch<CR>
	autocmd FileType markdown,text    vnoremap <buffer> <localleader>ul :s/\(\t*\)[*+-] /\1/<CR>:nohlsearch<CR>
	" Make selected text List with numbers
    autocmd FileType markdown,text    vnoremap <buffer> <localleader>n :s/\(^[^\d][^.]\)/1. \1/<CR>:nohlsearch<CR>
	autocmd FileType markdown,text    vnoremap <buffer> <localleader>un :s/^\d. //<CR>:nohlsearch<CR>
	" Make selected or current line's text quote
    autocmd FileType markdown,text    nnoremap <buffer> <localleader>q :s/\(^[^>]\)/> \1/<CR>:nohlsearch<CR>
    autocmd FileType markdown,text    vnoremap <buffer> <localleader>q :s/\(^[^>]\)/> \1/<CR>:nohlsearch<CR>
    autocmd FileType markdown,text    nnoremap <buffer> <localleader>uq :s/^> //<CR>:nohlsearch<CR>
    autocmd FileType markdown,text    vnoremap <buffer> <localleader>uq :s/^> //<CR>:nohlsearch<CR>
	" Open Plantuml File under cursor
    autocmd FileType markdown,text    nnoremap <buffer> <localleader>pwe vi(:<c-u>call <SID>OpenPlantumlUnderCursor("e")<CR>
    autocmd FileType markdown,text    nnoremap <buffer> <localleader>pwv vi(:<c-u>call <SID>OpenPlantumlUnderCursor("vsplit")<CR>
	" Mapping for PlantUml Swap Left to Right
    autocmd FileType markdown,text,plantuml    nnoremap <buffer> <localleader>ps :s/\([^-<>:]*\)\s\s*\([ox<*\|//]*--*[ox>*\|\\]*\)\s\s*\([^-<>:]*\)\s*/\3 \2 \1 /<CR>:nohlsearch<CR>

 
endif


"#########  matten/emmet-vim  ##########
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

"#########  MyVIMscript Test ##########

function! s:InsTxtAroundSelection(type, leftText, rightText)
	let saved_unnamed_register = @@
	
	if a:type ==# 'inline'
		normal! `<v`>d
		if @@ =~# '\n$'
			execute "normal! i" . a:leftText . substitute(@@, "\n", "", "") . a:rightText . "\n"
		else
			execute "normal! i" . a:leftText . @@ . a:rightText
		endif
	elseif a:type ==# 'block'
		execute "normal! `<O" . a:leftText
		execute "normal! `>o" . a:rightText
	endif

	let @@ = saved_unnamed_register
endfunction

function! s:OpenPlantumlUnderCursor(command)
	let saved_unnamed_register = @@

	normal! `<v`>y
	let l:filepath = substitute(@@, ".png", ".pu", "")
	let l:filepath = substitute(l:filepath, ".svg", ".pu", "")
	execute a:command . " " . l:filepath

	let @@ = saved_unnamed_register
endfunction

function! s:MarkdownFormatList()
	normal! `<v`>
	execute "normal! :s/^\\t\\t\\([^-\\s\\t]\\)/\\t\\t- \\1/\<CR>"
	normal! `<v`>
	execute "normal! :s/^\\t\\([^-+\\s\\t]\\)/\\t+ \\1/\<CR>"
	normal! `<v`>
	execute "normal! :s/^\\([^-**\\s\\t]\\)/* \\1/\<CR>"
endfunction
