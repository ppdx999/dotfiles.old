" import files
source ~/.vim/_config/init/myUtil.vim

setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4
setlocal expandtab

" Make selected text Bold
vnoremap <buffer> <localleader>* :<c-u>call myUtil#insTxtAroundSelection('**' , '**')<CR>
nnoremap <buffer> <localleader>u* F*hvldf*vld:nohlsearch<CR>
" Make selected text inline code
vnoremap <buffer> <localleader>` :<c-u>call myUtil#insTxtAroundSelection((visualmode()==#'v' ? '`' : '```') , (visualmode()==#'v' ? '`' : '```') )<CR>
nnoremap <buffer> <localleader>u` F`xf`x:nohlsearch<CR>
" Make selected text color Blue/Red
vnoremap <buffer> <localleader>tb :<c-u>call myUtil#insTxtAroundSelection( '<span style="color: blue;">', '</span>')<CR>
vnoremap <buffer> <localleader>tr :<c-u>call myUtil#insTxtAroundSelection( '<span style="color: red;">', '</span>')<CR>
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

" Mapping for PlantUml Swap Left to Right
nnoremap <buffer> <localleader>ps :s/\([^-<>:]*\)\s\s*\([ox<*\|//]*--*[ox>*\|\\]*\)\s\s*\([^-<>:]*\)\s*/\3 \2 \1 /<CR>:nohlsearch<CR>

if filereadable(expand('~/format/fmt.md'))
	nnoremap <buffer> <localleader>zz :r !cat ~/format/fmt.md<CR>
endif

if filereadable(expand('~/bin/gh_md_preview.sh'))
	nnoremap <buffer> <localleader>pp :execute '!~/bin/gh_md_preview.sh '. expand('%:p')<CR>
endif

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

" Count 3byte-char as two 
function! s:strlenX(text)
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

