" editor {{{

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
set cmdheight=2
set vb t_vb=


" }}}
" mapping {{{

" leader key mapping {{{
let mapleader = ","
let maplocalleader = ";"
" }}}
" Cursor {{{
nnoremap k   gk
nnoremap j   gj
vnoremap k   gk
vnoremap j   gj
nnoremap gk  k
nnoremap gj  j
vnoremap gk  k
vnoremap gj  j
" Command line mode
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
" }}}
" Open & Close {{{
nnoremap <Space>w  :<C-u>w<CR>
nnoremap <Space>q  :<C-u>q<CR>
nnoremap <Space>Q  :<C-u>q!<CR>

" nnoremap <Space>f :NERDTree<CR>
nnoremap <Space>f :Ve<CR>

nnoremap <silent> tt  :<C-u>tabe<CR>
nnoremap <C-p>  gT
nnoremap <C-n>  gt
nnoremap <leader>w <C-w>w<CR>
nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>
nnoremap ]t :tabn<CR>
nnoremap [t :tabp<CR>

nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Quickly open a file under cursor as vsplit
nnoremap gb :vertical wincmd f<CR>


" }}}
" Search & Substitution {{{
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
" }}}
" Append Blank line in normal mode {{{
nnoremap <Space>o  :<C-u>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap <Space>O  :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>
" }}}
" Disable dangerous mapping {{{
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q gq
" }}}
" Coding Assistants {{{
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap ({<Enter> ({});<Left><Left><Left><CR><ESC><S-o>
" Append a char {{{
nnoremap <leader>a, A,<ESC>
nnoremap <leader>a. A.<ESC>
nnoremap <leader>a; A;<ESC>
nnoremap <leader>a: A:<ESC>
nnoremap <leader>a/ A/<ESC>
nnoremap <leader>a\ A\<ESC>
nnoremap <leader>a\| A\|<ESC>
nnoremap <leader>a' A'<ESC>
nnoremap <leader>a" A"<ESC>
nnoremap <leader>a` A`<ESC>
"}}}
" }}}
" Copy clipboard in Cygwin {{{
if has('win32unix')
	function! s:Putclip(type, ...) range
	  let sel_save = &selection
	  let &selection = "inclusive"
	  let reg_save = @@
	  if a:type == 'n'
		silent exe a:firstline . "," . a:lastline . "y"
	  elseif a:type == 'c'
		silent exe a:1 . "," . a:2 . "y"
	  else
		silent exe "normal! `<" . a:type . "`>y"
	  endif
	  call writefile(split(@@,"\n"), '/dev/clipboard')
	  let &selection = sel_save
	  let @@ = reg_save
	endfunction

	vnoremap <silent> <leader>y :call <SID>Putclip(visualmode(), 1)<CR>
	nnoremap <silent> <leader>y :call <SID>Putclip('n', 1)<CR>
endif
" }}}

" }}}
" functions {{{1

" function! s:strlenX(text)  {{{
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
" }}}
" function! s:Get_visual_selection()  {{{
function! s:Get_visual_selection()
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
" }}}
" function! s:padcutTextWith(text,padChar,maxLen)  {{{
function! s:padcutTextWith(text,padChar,maxLen)
	let lineLen = s:strlenX(a:text)
	let rval = a:text
	if lineLen > a:maxLen
		let rval = substitute(rval, '^\(.\{0,' . a:maxLen .'\}\).*$', '\1', '')
	else
		for i in range(lineLen, a:maxLen)
			let rval .= a:padChar 
		endfor
	endif
	return rval
endfunction
" }}}
" function! s:commentOut(commentChar)  {{{
function! s:commentOut(commentChar)
    let [lineStart, columnStart] = getpos("'<")[1:2]
    let [lineEnd, columnEnd] = getpos("'>")[1:2]

	let mode = 'uncomment'
	for lineNum in range(lineStart, lineEnd)
		let oldLine = getline(lineNum)
		if(matchstr(oldLine, '\S\S*') !~# a:commentChar . '\S*') 
			let mode = 'comment'
		endif
	endfor

	if mode ==# 'comment'
		for lineNum in range(lineStart, lineEnd)
			let oldLine = getline(lineNum)
			if(matchstr(oldLine, '\S\S*') !~# a:commentChar . '\S*') 
				let newLine = a:commentChar . ' ' . oldLine
				call setline(lineNum, newLine)
			endif
		endfor
	elseif mode ==# 'uncomment'
		for lineNum in range(lineStart, lineEnd)
			let oldLine = getline(lineNum)
			let newLine = substitute(oldLine, '^' . a:commentChar . '\s\{0,1\}', '', '')
			call setline(lineNum, newLine)
		endfor
	endif
endfunction
" }}}
" function! s:formatComment(commentChar)  {{{
function! s:formatComment(commentChar)
    let [lineStart, columnStart] = getpos("'<")[1:2]
    let [lineEnd, columnEnd] = getpos("'>")[1:2]

	for lineNum in range(lineStart, lineEnd)
		let oldLine = getline(lineNum)

		if(matchstr(oldLine, '\S\S*') !~# a:commentChar . '\S*') | continue | endif

		let lastChar = oldLine[-1:]
		if     lastChar ==# '#' | let length = 79
		elseif lastChar ==# '=' | let length = 70
		elseif lastChar ==# '-' | let length = 60
		else                    | continue       | endif

		let newLine = s:padcutTextWith(oldLine, lastChar, length)
		call setline(lineNum, newLine)
	endfor
endfunction
" }}}
" function! s:insertTextAtCurrentCursor(text)  {{{
function! s:insertTextAtCurrentCursor(text)
    let lineNum = line('.')
    let colNum = col('.')
    let oldLine = getline('.')
    let newLine =
        \ strpart(oldLine, 0, colNum - 1)
        \ . a:text
        \ . strpart(oldLine, colNum - 1)
    " Replace the current line with the modified line.
    call setline(lineNum, newLine)
    " Place cursor on the last character of the inserted text.
    call cursor(lineNum, colNum + strlen(a:text))
endfunction
" }}}
" function! s:substrX(text, s, e)  {{{
function! s:substrX(text, s, e)
	return join(split(a:text, '\zs')[a:s:a:e], '')
endfunction
" }}}
" function! s:insTxtAroundSelection(leftText, rightText)  {{{
function! s:insTxtAroundSelection(leftText, rightText)

    let [lineStart, columnStart] = getpos("'<")[1:2]
    let [lineEnd, columnEnd] = getpos("'>")[1:2]

	if lineStart ==# lineEnd
		let line = getline(lineStart)
		let newLine = (columnStart==#1 ? '' : line[0:columnStart-2]) . a:leftText . line[columnStart-1:columnEnd-(&selection == 'inclusive' ? 1 : 2)] . a:rightText . line[columnEnd-(&selection == 'inclusive' ? 0 : 1):]
		call setline(lineStart, newLine)
	else
		call append(lineStart-1, a:leftText)
		call append(lineEnd+1, a:rightText)
	endif

endfunction
" }}}
" function! s:En2JpDate(text)  {{{
function! s:En2JpDate(text)
	let rval = a:text
	let rval = substitute(rval, "[Mm][Oo][Nn]", "月", "")
	let rval = substitute(rval, "[Tt][Uu][Ee]", "火", "")
	let rval = substitute(rval, "[Ww][Ee][Dd]", "水", "")
	let rval = substitute(rval, "[Tt][Hh][Uu]", "木", "")
	let rval = substitute(rval, "[Ff][Rr][Ii]", "金", "")
	let rval = substitute(rval, "[Ss][Aa][Tt]", "土", "")
	let rval = substitute(rval, "[Ss][Uu][Nn]", "日", "")
	return rval
endfunction
" }}}
" function! s:GetFiletypes()  {{{
function! s:GetFiletypes()
	" Usage:
	"    Execute like `for f in GetFiletypes() | echo f | endfor`
	" Description:
    "    Get a list of all the runtime directories by taking the value of that
    "    option and splitting it using a comma as the separator.
    let rtps = split(&runtimepath, ",")
    " This will be the list of filetypes that the function returns
    let filetypes = []

    " Loop through each individual item in the list of runtime paths
    for rtp in rtps
        let syntax_dir = rtp . "/syntax"
        " Check to see if there is a syntax directory in this runtimepath.
        if (isdirectory(syntax_dir))
            " Loop through each vimscript file in the syntax directory
            for syntax_file in split(glob(syntax_dir . "/*.vim"), "\n")
                " Add this file to the filetypes list with its everything
                " except its name removed.
                call add(filetypes, fnamemodify(syntax_file, ":t:r"))
            endfor
        endif
    endfor

    " This removes any duplicates and returns the resulting list.
    " NOTE: This might not be the best way to do this, suggestions are welcome.
    return uniq(sort(filetypes))
endfunction
" }}}


" function! s:execute_ctags() abort  {{{
function! s:execute_ctags() abort
  " 探すタグファイル名
  let tag_name = '.tags'
  " ディレクトリを遡り、タグファイルを探し、パス取得
  let tags_path = findfile(tag_name, '.;')
  " タグファイルパスが見つからなかった場合
  if tags_path ==# ''
    return
  endif

  " タグファイルのディレクトリパスを取得
  " `:p:h`の部分は、:h filename-modifiersで確認
  let tags_dirpath = fnamemodify(tags_path, ':p:h')
  " 見つかったタグファイルのディレクトリに移動して、ctagsをバックグラウンド実行（エラー出力破棄）
  execute 'silent !cd' tags_dirpath '&& ctags -R -f' tag_name '2> /dev/null &'
endfunction
" }}}
" }}}
" filetype {{{

" DefineFiletype {{{
augroup DefineFiletype
  autocmd!
  autocmd BufRead,BufNewFile *.md	set filetype=markdown
  autocmd BufRead,BufNewFile *.txt set filetype=text
  autocmd BufRead,BufNewFile * if !did_filetype() && getline(1) =~# '@startuml\>'| setfiletype plantuml | endif
  autocmd BufRead,BufNewFile *.pu,*.uml,*.plantuml,*.puml,*.iuml set filetype=plantuml
  autocmd BufRead,BufNewFile *.tsx set filetype=typescript
  autocmd BufRead,BufNewFile *.jsx set filetype=javascript
  autocmd BufRead,BufNewFile .vimrc set filetype=vim
augroup END
" }}}
" Load settings for each filetype {{{
augroup LoadSettingsForEachFiletype
  autocmd!
  autocmd Filetype * call s:filetype(expand('<amatch>'))
augroup END

function! s:filetype(ftype) abort
  if !empty(a:ftype) && exists('*' . 's:filetype_' . a:ftype)
    execute 'call s:filetype_' . a:ftype . '()'
  endif
endfunction
" }}}
" function! s:set_indent(tab_length, is_hard_tab) abort  {{{
function! s:set_indent(tab_length, is_hard_tab) abort
  if a:is_hard_tab
    setlocal noexpandtab
  else
    setlocal expandtab
  endif
  let &l:shiftwidth  = a:tab_length
  let &l:softtabstop = a:tab_length
  let &l:tabstop     = a:tab_length
endfunction
" }}}
" javascript {{{
function! s:filetype_javascript() abort
  call s:set_indent(4, 0)
endfunction
" }}}
" typescript {{{
function! s:filetype_typescript() abort
  call s:filetype_javascript()
endfunction
" }}}
" ruby {{{
function! s:filetype_ruby() abort
  call s:set_indent(2, 0)
endfunction
" }}}
" python {{{
function! s:filetype_python() abort
  call s:set_indent(4, 1)
endfunction
" }}}
" gitconfig {{{
function! s:filetype_gitconfig() abort
  call s:set_indent(4, 1)
endfunction
" }}}
" gitcommit {{{
function! s:filetype_gitcommit() abort
  call s:set_indent(2, 0)
  setlocal spell
endfunction
" }}}
" vim {{{
function! s:filetype_vim() abort
  setlocal foldmethod=marker
  vnoremap <leader>vk :<c-u>call <SID>insTxtAroundSelection('" {{{','" }}}')<CR>yykkpI" <ESC>J$F"x
  vnoremap <leader>vf :<c-u>call <SID>insTxtAroundSelection('" {{{','" }}}')<CR>
endfunction
" }}}
" markdown {{{
" function! s:filetype_markdwon() abort  {{{
function! s:filetype_markdwon() abort
  " Make selected text Bold
  vnoremap <buffer> <localleader>* :<c-u>call <SID>insTxtAroundSelection('**' , '**')<CR>
  nnoremap <buffer> <localleader>u* F*hvldf*vld:nohlsearch<CR>
  " Make selected text inline code
  vnoremap <buffer> <localleader>` :<c-u>call <SID>insTxtAroundSelection((visualmode()==#'v' ? '`' : '```') , (visualmode()==#'v' ? '`' : '```') )<CR>
  nnoremap <buffer> <localleader>u` F`xf`x:nohlsearch<CR>
  " Make selected text color Blue/Red
  vnoremap <buffer> <localleader>tb :<c-u>call <SID>insTxtAroundSelection( '<span style="color: blue;">', '</span>')<CR>
  vnoremap <buffer> <localleader>tr :<c-u>call <SID>insTxtAroundSelection( '<span style="color: red;">', '</span>')<CR>
  " Delete color
  nnoremap <buffer> <localleader>uf vityvatp:nohlsearch<CR>
  " Make selected text List
  vnoremap <buffer> <localleader>- :<c-u>call <SID>MarkdownFormatList()<CR>:nohlsearch<CR>
  vnoremap <buffer> <localleader>u- :s/\(\t*\)[*+-] /\1/<CR>:nohlsearch<CR>
  " Make selected text List with numbers
  vnoremap <buffer> <localleader>n :s/\(^[^\d][^.]\)/1. \1/<CR>:nohlsearch<CR>
  vnoremap <buffer> <localleader>un :s/^\d. //<CR>:nohlsearch<CR>
  " Make selected or current line's text quote
  vnoremap <buffer> <localleader>> :<c-u>call <SID>commentOut('>')<CR>
  " Make tabel
  vnoremap <buffer> <localleader>t  :<c-u>call <SID>makeTable()<CR>
endfunction
" }}}

" function! s:MarkdownFormatList()  {{{
function! s:MarkdownFormatList()
    let [lineStart, columnStart] = getpos("'<")[1:2]
    let [lineEnd, columnEnd] = getpos("'>")[1:2]

	for lineNum in range(lineStart, lineEnd)
		let oldLine = getline(lineNum)
		if oldLine =~# '^- \S\S*'
			continue
		elseif oldLine =~# '^\t\{1,\}- \S\{1,\}' 
			continue
		elseif oldLine =~# '^\(    \)\{1,\}- \S\{1,\}'
			continue
		elseif oldLine =~# '^\d\. \S\{1,\}'
			continue
		elseif oldLine =~# '^\t\{1,\}\d\. \S\{1,\}' 
			continue
		elseif oldLine =~# '^\(    \)\{1,\}\d\. \S\{1,\}'
			continue
		endif
		let newLine = substitute(oldLine, '\(\S\{1,\}\)', '- \1', '')
		call setline(lineNum, newLine)
	endfor
endfunction
" }}}
" function! s:makeTable()  {{{
function! s:makeTable()
	call <SID>IAPipe()
	call <SID>appendTableHeader()
	call <SID>formatTable()
endfunction

function! s:IAPipe()
    let lineStart = getpos("'<")[1]
    let lineEnd   = getpos("'>")[1]
	for lineNum in range(lineStart, lineEnd)
		let oldLine = getline(lineNum)
		let newLine = oldLine
		if(matchstr(oldLine, '\S') !~# '|') 
			let newLine = '|' . newLine
		endif
		if(matchstr(oldLine, '\S$') !~# '|') 
			let newLine = newLine . '|'
		endif
		call setline(lineNum, newLine)
	endfor
endfunction

function! s:appendTableHeader()
    let lineStart = getpos("'<")[1]
	let firstLine = getline(lineStart+1)
	let secondLine = getline(lineStart+1)
	if(matchstr(secondLine, '---') ==# '') 
		let newLine = '|'
		let nCol = len(split(firstLine, '|', 1))-2
		for i in range(0,nCol-1)
			let newLine .= ':---:|'
		endfor
		call append(lineStart, newLine)
	endif
endfunction

function! s:formatTable()

	" Get Selected Text and assign it into a variable
    let lineStart = getpos("'<")[1]
    let lineEnd = getpos("'>")[1]
    let lines = getline(lineStart, lineEnd)
	let nLines = len(lines)

	" Prepare a list to store the maximum length of the string in each column.
	let cellLengths = []
	let nCellLengths = 0
	for i in range(0, nLines-1)
		if matchstr(lines[i], '|') ==# "" | continue | endif
		let thisCellLength = len(split(lines[i], '|', 1))
		if thisCellLength > nCellLengths
			let nCellLengths = thisCellLength
		endif
	endfor
	for i in range(0, nCellLengths-1)
		let cellLengths = add(cellLengths, 0)
	endfor

	for i in range(0, nLines-1)
		if matchstr(lines[i], '|') ==# "" | continue | endif

		let strList = split(lines[i], '|' , 1)
		let nStrList = len(split(lines[i], '|' , 1)) 

		for j in range(0, nStrList-1)
			let nStr = s:strlenX(strList[j])
			if nStr > cellLengths[j]
				let cellLengths[j] = nStr
			endif
		endfor
	endfor

	" Adds whitespace based on the 'cellLength' value. And write it to buffer. 
	for i in range(0, nLines-1)
		if matchstr(lines[i], '|') ==# "" | continue | endif

		let strList = split(lines[i], '|' , 1)
		let nStrList = len(split(lines[i], '|' , 1)) 

		for j in range(0, nStrList-1)
			let nAddSpace = cellLengths[j] - s:strlenX(strList[j]) 
			for k in range(0, nAddSpace-1)
				let strList[j] .= ' '
			endfor
		endfor
		let lines[i] = join(strList, '|')
		"let lines[i] = substitute(lines[i], '\\t', '\t', 'g')
		call setline(lineStart + i, lines[i])
	endfor
endfunction
" }}}
" function! s:strlenX(text) {{{
function! s:strlenX(text)
" Count 3byte-char as two 
	let single_multi_total = strlen(a:text)
	if &ambiwidth !=# 'double'
		return single_multi_total
	endif
	let total_by_byte = strlen(substitute(a:text, '.', 'x','g'))
	if (single_multi_total == total_by_byte)
		return total_by_byte
	else
		let n_multi_byte = (single_multi_total - total_by_byte) / 2
		let n_single_byte = single_multi_total - (n_multi_byte * 3)
		return n_single_byte + (n_multi_byte * 2)
	endif
endfunction
" }}}
" }}}
" plantuml  {{{
function! s:filetype_plantuml() abort
  nnoremap <localleader>ex :<c-u>!plantuml -tsvg %
endfunction
" }}}

" }}}
" " plugin {{{
 
if filereadable(expand('~/.vim/autoload/plug.vim'))
 call plug#begin('~/.vim/plugged')
 
 Plug 'vim-jp/vimdoc-ja'
 Plug 'tpope/vim-surround'
 Plug 'tpope/vim-commentary'
 Plug 'mattn/emmet-vim'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'preservim/nerdtree'
 Plug 'aklt/plantuml-syntax'
 
 call plug#end()

 " Plug 'vim-jp/vimdoc-ja' {{{
 set helplang=ja,en
 " }}}
 " Plug 'neoclide/coc.nvim', {'branch': 'release'} {{{
 " Set internal encoding of vim, not needed on neovim, since coc.nvim using some
 " unicode characters in the file autoload/float.vim
 set encoding=utf-8
 
 " TextEdit might fail if hidden is not set.
 set hidden
 
 " Some servers have issues with backup files, see #649.
 set nobackup
 set nowritebackup
 
 " Give more space for displaying messages.
 set cmdheight=2
 
 " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
 " delays and poor user experience.
 set updatetime=300
 
 " Don't pass messages to |ins-completion-menu|.
 set shortmess+=c
 
 " Always show the signcolumn, otherwise it would shift the text each time
 " diagnostics appear/become resolved.
 if has("nvim-0.5.0") || has("patch-8.1.1564")
   " Recently vim can merge signcolumn and number column into one
   set signcolumn=number
 else
   set signcolumn=yes
 endif
 
 " Use tab for trigger completion with characters ahead and navigate.
 " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
 " other plugin before putting this into your config.
 inoremap <silent><expr> <TAB>
       \ pumvisible() ? "\<C-n>" :
       \ <SID>check_back_space() ? "\<TAB>" :
       \ coc#refresh()
 inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
 
 function! s:check_back_space() abort
   let col = col('.') - 1
   return !col || getline('.')[col - 1]  =~# '\s'
 endfunction
 
 " Use <c-space> to trigger completion.
 if has('nvim')
   inoremap <silent><expr> <c-space> coc#refresh()
 else
   inoremap <silent><expr> <c-@> coc#refresh()
 endif
 
 " Make <CR> auto-select the first completion item and notify coc.nvim to
 " format on enter, <cr> could be remapped by other vim plugin
 inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
 
 " Use `[g` and `]g` to navigate diagnostics
 " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
 nmap <silent> [g <Plug>(coc-diagnostic-prev)
 nmap <silent> ]g <Plug>(coc-diagnostic-next)
 
 " GoTo code navigation.
 nmap <silent> gd <Plug>(coc-definition)
 nmap <silent> gy <Plug>(coc-type-definition)
 nmap <silent> gi <Plug>(coc-implementation)
 nmap <silent> gr <Plug>(coc-references)
 
 " Use K to show documentation in preview window.
 nnoremap <silent> K :call <SID>show_documentation()<CR>
 
 function! s:show_documentation()
   if (index(['vim','help'], &filetype) >= 0)
     execute 'h '.expand('<cword>')
   elseif (coc#rpc#ready())
     call CocActionAsync('doHover')
   else
     execute '!' . &keywordprg . " " . expand('<cword>')
   endif
 endfunction
 
 " Highlight the symbol and its references when holding the cursor.
 autocmd CursorHold * silent call CocActionAsync('highlight')
 
 " Symbol renaming.
 nmap <leader>rn <Plug>(coc-rename)
 
 " Formatting selected code.
 xmap <leader>f  <Plug>(coc-format-selected)
 nmap <leader>f  <Plug>(coc-format-selected)
 
 augroup mygroup
   autocmd!
   " Setup formatexpr specified filetype(s).
   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
   " Update signature help on jump placeholder.
   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
 augroup end
 
 " Applying codeAction to the selected region.
 " Example: `<leader>aap` for current paragraph
 xmap <leader>a  <Plug>(coc-codeaction-selected)
 nmap <leader>a  <Plug>(coc-codeaction-selected)
 
 " Remap keys for applying codeAction to the current buffer.
 nmap <leader>ac  <Plug>(coc-codeaction)
 " Apply AutoFix to problem on the current line.
 nmap <leader>qf  <Plug>(coc-fix-current)
 
 " Map function and class text objects
 " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
 xmap if <Plug>(coc-funcobj-i)
 omap if <Plug>(coc-funcobj-i)
 xmap af <Plug>(coc-funcobj-a)
 omap af <Plug>(coc-funcobj-a)
 xmap ic <Plug>(coc-classobj-i)
 omap ic <Plug>(coc-classobj-i)
 xmap ac <Plug>(coc-classobj-a)
 omap ac <Plug>(coc-classobj-a)
 
 " Remap <C-f> and <C-b> for scroll float windows/popups.
 if has('nvim-0.4.0') || has('patch-8.2.0750')
   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
 endif
 
 " Use CTRL-S for selections ranges.
 " Requires 'textDocument/selectionRange' support of language server.
 nmap <silent> <C-s> <Plug>(coc-range-select)
 xmap <silent> <C-s> <Plug>(coc-range-select)
 
 " Add `:Format` command to format current buffer.
 command! -nargs=0 Format :call CocAction('format')
 
 " Add `:Fold` command to fold current buffer.
 command! -nargs=? Fold :call     CocAction('fold', <f-args>)
 
 " Add `:OR` command for organize imports of the current buffer.
 command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
 
 " Add (Neo)Vim's native statusline support.
 " NOTE: Please see `:h coc-status` for integrations with external plugins that
 " provide custom statusline: lightline.vim, vim-airline.
 set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
 
 " Mappings for CoCList
 " Show all diagnostics.
 nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
 " Manage extensions.
 nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
 " Show commands.
 nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
 " Find symbol of current document.
 nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
 " Search workspace symbols.
 nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
 " Do default action for next item.
 nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
 " Do default action for previous item.
 nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
 " Resume latest coc list.
 nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
 " }}}
endif
" " }}}
