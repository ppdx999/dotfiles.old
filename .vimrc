" #########  Plugin Mnager ##########
if filereadable(expand('~/.vim/autoload/plug.vim')) && !has("gui_running")

	" Plugins will be downloaded under the specified directory.
	call plug#begin('~/.vim/plugged')

	""""""""""""""""""""""""""""""""""""""""
	" Declare the list of plugins.
	Plug 'mattn/emmet-vim'
	Plug 'tpope/vim-surround'
	Plug 'preservim/nerdtree'

	" For text alignment
	Plug 'junegunn/vim-easy-align'

	""""""""""""""""""""""""""""""""""""""""

	" List ends here. Plugins become visible to Vim after this call.
	call plug#end()
endif


"######### gvim Settings ##########
if has("gui_running")
	set guifont=Nsimsun:h12
	set backspace=indent,eol,start
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
set completeopt=menu


if has("win64") || has("win32") || has("win16")
	if has("gui_running")
		set clipboard=unnamed
	endif
elseif substitute(system("expr substr $(uname -s) 1 10"), "\n", "", "") ==# 'MINGW64_NT'
	set clipboard=unnamed
elseif substitute(system("expr substr $(uname -s) 1 5"), "\n", "", "") ==# 'Linux'
	set clipboard=unnamedplus
endif


" Align auto indent when paste from clipborad
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
	nnoremap <leader>wf :NERDTree<CR>
endif

" Move around faster
nnoremap <leader>w <C-w>w
nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>
nnoremap ]t :tabn<CR>
nnoremap [t :tabp<CR>

" Quickly remove highlishts
nnoremap  <leader>cc :<C-u>nohlsearch<cr><Esc>

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


" Easy to trigger Completion
inoremap <c-f> <c-x><c-o>
inoremap <c-d> <c-x><c-k>

" Align
vnoremap <leader>=\| :<c-u>call <SID>AlignBy(visualmode(), '\|')<CR>
vnoremap <leader>=& :<c-u>call <SID>AlignBy(visualmode(), '&')<CR>
vnoremap <leader>=, :<c-u>call <SID>AlignBy(visualmode(), ',')<CR>
vnoremap <leader>=# :<c-u>call <SID>AlignBy(visualmode(), '#')<CR>
vnoremap <leader>== :<c-u>call <SID>AlignBy(visualmode(), '=')<CR>
vnoremap <leader>=: :<c-u>call <SID>AlignBy(visualmode(), ':')<CR>
vnoremap <leader>=; :<c-u>call <SID>AlignBy(visualmode(), ';')<CR>
vnoremap <leader>=) :<c-u>call <SID>AlignBy(visualmode(), ')')<CR>
vnoremap <leader>=<Space> :<c-u>call <SID>AlignBy(visualmode(), ' ')<CR>
vnoremap <leader>=<Tab> :<c-u>call <SID>AlignBy(visualmode(), '\t')<CR>


"Quickly move cursor in insert mode.
"if 0
"	inoremap <C-h> <left>
"	inoremap <C-j> <down>
"	inoremap <C-k> <up>
"	inoremap <C-l> <right>
"	inoremap <C-u> <home>
"	inoremap <C-m> <end>
"endif

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


	autocmd FileType c,cpp,python,java,ruby,javascript,sh,markdown,text,plantuml    let maplocalleader = ";"


    autocmd FileType c           setlocal sw=4 sts=4 ts=4 noexpandtab
    autocmd FileType c           nnoremap <buffer> <C-i> <Home>i//<Esc>
    autocmd FileType c           nnoremap <buffer> <C-f> <Home>"_x"_x<Esc>
    autocmd FileType c           nnoremap <buffer> <C-b> :make
    autocmd FileType c           nnoremap <buffer> <C-e> :make run

    autocmd FileType cpp         setlocal sw=4 sts=4 ts=4 noexpandtab
    autocmd FileType cpp         nnoremap <buffer> <C-b> :make
    autocmd FileType cpp         nnoremap <buffer> <C-e> :make run
    autocmd FileType cpp         inoremap <buffer> <C-i> <c-o>:call InsertFor("i","N")<Left><Left><Left><Left><Left><Left><Left>
	
    autocmd FileType python      setlocal sw=4 sts=4 ts=4 expandtab
    autocmd FileType python      nnoremap <buffer> <C-i> <Home>i#<Esc>
    autocmd FileType python      nnoremap <buffer> <C-f> <Home>"_x<Esc>
    autocmd FileType python      nnoremap <buffer> <C-e> :terminal python4 %

    autocmd FileType java         setlocal sw=4 sts=4 ts=4 noexpandtab
    autocmd FileType java         nnoremap <buffer> <C-i> <Home>i//<Esc>
    autocmd FileType java         nnoremap <buffer> <C-f> <Home>"_x"_x<Esc>
    autocmd FileType java         set dictionary=~/.vim/dict/j2se14.dict

    autocmd FileType html        setlocal sw=4 sts=4 ts=4 noexpandtab
    autocmd FileType html        nnoremap <buffer> <C-i> <End>a--><Esc><Home>i<!--<Esc>
    autocmd FileType html        nnoremap <buffer> <C-f> <End>xxx<Esc><Home>xxxx<Esc>
    autocmd Filetype html        inoremap <buffer> </ </<C-x><C-o><ESC>F<i

    autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 noexpandtab

    autocmd FileType js          setlocal sw=4 sts=4 ts=4 noexpandtab

    autocmd FileType javasctipt  nnoremap <buffer> <C-i> <Home>i//<Esc>
    autocmd FileType javasctipt  nnoremap <buffer> <C-f> <Home>xx<Esc>

    autocmd FileType scala       setlocal sw=4 sts=4 ts=4 noexpandtab

    autocmd FileType json        setlocal sw=4 sts=4 ts=4 noexpandtab

    autocmd FileType css         setlocal sw=4 sts=4 ts=4 noexpandtab
    autocmd FileType css         set omnifunc=csscomplete#CompleteCSS
    autocmd FileType css         nnoremap <buffer> <C-i> <End>a*/<Esc><Home>i/*<Esc>
    autocmd FileType css         nnoremap <buffer> <C-f> <End>xx<Esc><Home>xx<Esc>

    autocmd FileType scss        setlocal sw=4 sts=4 ts=4 noexpandtab
    autocmd FileType sass        setlocal sw=4 sts=4 ts=4 noexpandtab

    autocmd FileType sh          setlocal sw=2 sts=2 ts=2 expandtab
    autocmd FileType sh          nnoremap <buffer> <localleader>= :<c-u>call <SID>shFormamt('n')<CR>
    autocmd FileType sh          vnoremap <buffer> <localleader>= :<c-u>call <SID>shFormamt(visualmode())<CR>
    autocmd FileType zsh         setlocal sw=4 sts=4 ts=4 expandtab

    autocmd FileType vim         setlocal foldmethod=marker 

	"autocmd FileType markdown,text    setlocal spell spelllang=en_us

	" Make selected text Bold
    autocmd FileType markdown,text    vnoremap <buffer> <localleader>b :<c-u>call <SID>InsTxtAroundSelection( 'inline', '**' , '**')<CR>
    autocmd FileType markdown,text    nnoremap <buffer> <localleader>ub F*hvldf*vld
	" Make selected text inline code
    autocmd FileType markdown,text    vnoremap <buffer> <localleader>i :<c-u>call <SID>InsTxtAroundSelection( 'inline', '`', '`')<CR>
    autocmd FileType markdown,text    nnoremap <buffer> <localleader>ui F`xf`x
	" Make selected text color Blue/Red
    autocmd FileType markdown,text    vnoremap <buffer> <localleader>tb :<c-u>call <SID>InsTxtAroundSelection( 'inline', '<span style="color: blue;">', '</span>')<CR>
    autocmd FileType markdown,text    vnoremap <buffer> <localleader>tr :<c-u>call <SID>InsTxtAroundSelection( 'inline', '<span style="color: red;">', '</span>')<CR>
	" Delete color
    autocmd FileType markdown,text    nnoremap <buffer> <localleader>uf vityvatp
	" Append CR
    autocmd FileType markdown,text    nnoremap <buffer> <localleader>r m`A<br><ESC>``
    autocmd FileType markdown,text    nnoremap <buffer> <localleader>ur :s/<br>$//<CR> 
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

	" Write format
	if filereadable(expand('~/format/fmt.sh'))
		autocmd FileType sh          nnoremap <buffer> <localleader>zz :r !cat ~/format/fmt.sh<CR>
	endif
	if filereadable(expand('~/format/fmt.md'))
		autocmd FileType markdown    nnoremap <buffer> <localleader>zz :r !cat ~/format/fmt.md<CR>
	endif
	if filereadable(expand('~/format/fmt.cpp'))
		autocmd FileType cpp         nnoremap <buffer> <localleader>zz :r !cat ~/format/fmt.cpp<CR>
	endif
	if filereadable(expand('~/format/fmt.pu'))
		autocmd FileType plantuml         nnoremap <buffer> <localleader>zz :r !cat ~/format/fmt.pu<CR>
	endif
 
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

"#########  MyVIMscript ##########
function! InsertFor(itr, N)
	let my_filetype = &filetype
	if my_filetype ==# "cpp"
		execute "normal! ifor(int " . a:itr . "=0; " . a:itr . "<" . a:N . "; " . a:itr . "++)"
	endif
endfunction

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

" 日本語は2バイトとしてカウントする。
function! s:strlenX(text)
	let total_byte = strlen(a:text)
	let n_total = strlen(substitute(a:text, '.', 'x','g'))
	if (total_byte == n_total)
		return n_total
	else
		let n_multi_byte = (total_byte - n_total) / 2
		let n_single_byte = total_byte - (n_multi_byte * 3)
		return n_single_byte + (n_multi_byte * 2)
	endif
endfunction

function! s:AlignBy(mode, char)
	if a:mode !=# 'V'
		echo 'This function should be called in V mode'
		return
	endif

	" Get Selected Text and assign it into a variable
    let lineStart = getpos("'<")[1]
    let lineEnd = getpos("'>")[1]
    let lines = getline(lineStart, lineEnd)
	let nLines = len(lines)

	" Prepare a list to store the maximum length of the string in each column.
	let cellLengths = []
	let nCellLengths = 0
	let i = 0
	while i < nLines
		if matchstr(lines[i], a:char) ==# ""
			let i += 1
			continue
		endif
		let thisCellLength = len(split(lines[i], a:char, 1))
		if thisCellLength > nCellLengths
			let nCellLengths = thisCellLength
		endif
		let i += 1
	endwhile
	let i = 0
	while i < nCellLengths
		let cellLengths = add(cellLengths, 0)
		let i += 1
	endwhile

	let i = 0
	while i < nLines
		if matchstr(lines[i], a:char) ==# ""
			let i += 1
			continue
		endif
		let strList = split(lines[i], a:char , 1)
		let nStrList = len(split(lines[i], a:char , 1)) 
		let j = 0
		while j < nStrList
			let nStr = s:strlenX(strList[j])
			if nStr > cellLengths[j]
				let cellLengths[j] = nStr
			endif
			let j += 1
		endwhile
		let i += 1
	endwhile

	" Adds whitespace based on the 'cellLength' value. And write it to buffer. 
	let i = 0
	while i < nLines
		if matchstr(lines[i], a:char) ==# ""
			let i += 1
			continue
		endif
		let strList = split(lines[i], a:char , 1)
		let nStrList = len(split(lines[i], a:char , 1)) 
		let j = 0
		while j < nStrList
			let nAddSpace = cellLengths[j] - s:strlenX(strList[j]) 
			let k = 0
			while k < nAddSpace
				let strList[j] .= ' '
				let k += 1
			endwhile
			let j += 1
		endwhile
		let lines[i] = join(strList, a:char)
		let lines[i] = substitute(lines[i], '\\t', '\t', 'g')
		call setline(lineStart + i, lines[i])
		let i += 1
	endwhile
endfunction


function! s:shFormamt(mode)
	" Decide format range
	if a:mode ==? 'V'
		let lineStart = getpos("'<")[1]
		let lineEnd = getpos("'>")[1]
	else
		let lineStart = 1 
		let lineEnd = line('$') 
	endif
	let lines = getline(lineStart, lineEnd)
	let nLines = len(lines)


	" Process line by line
	let i = 0
	while i < nLines

		" Skip here document
		if(matchstr(lines[i],'\S') !=# '#' && matchstr(lines[i],'<<-\?') !=# '')
			let EOF = matchstr(lines[i], '<<-\?\s*\zs\S\S*\ze\s*')	
			while i < nLines
				let i += 1
				if matchstr(lines[i], '^' . EOF . '\s*$') !=# ''
					let i += 1
					break
				endif
			endwhile
		endif

		" Skip blank line
		if(lines[i] == '')
			let i += 1
			continue
		endif

		let n_width = 69

		" Comment
		if(matchstr(lines[i],'\S') ==# '#' && (lines[i] =~# '[-=]\s*$' || lines[i] =~# '#####\s*$'))
			let line = substitute(lines[i], '\s*$', '', 'g')
			let lineLen = s:strlenX(line)
			let fillChar = line[-1:]
			if lineLen > n_width
				call setline(lineStart + i, line[0:n_width])
			else
				let j = lineLen
				let newLine = line 
				while j <= n_width
					let newLine .= fillChar 
					let j += 1
				endwhile
				call setline(lineStart + i, newLine)
			endif
		" Not comment 
		elseif(matchstr(lines[i],'\S') !=# '#')
			let n_width -= 1
			let line = substitute(lines[i], '\s*$', '', 'g')
			let lastChar = line[-1:]
			if lastChar =~# '[|\#]'
				let line = substitute(line, '\s*[|\#]$', '', 'g')
			elseif lastChar ==# '&'
				let line = substitute(line, '\s*&&$', '', 'g')
				let lastChar = '&&'
				let n_width -= 1 
			else
				let lastChar = '#'
			endif
			let lineLen = s:strlenX(line)
			if lineLen > n_width
				let i += 1
				continue
			endif
			let j = lineLen
			let newLine = line 
			while j <= n_width
				let newLine .= ' ' 
				let j += 1
			endwhile
			let newLine .= lastChar
			call setline(lineStart + i, newLine)
		endif
		let i += 1
	endwhile
endfunction

function! s:get_visual_selection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    "return join(lines, "\n")
	return lines
endfunction
