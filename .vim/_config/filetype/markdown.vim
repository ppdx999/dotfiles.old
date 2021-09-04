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
vnoremap <buffer> <localleader>l :<c-u>call <SID>MarkdownFormatList()<CR>:nohlsearch<CR>
vnoremap <buffer> <localleader>ul :s/\(\t*\)[*+-] /\1/<CR>:nohlsearch<CR>
" Make selected text List with numbers
vnoremap <buffer> <localleader>n :s/\(^[^\d][^.]\)/1. \1/<CR>:nohlsearch<CR>
vnoremap <buffer> <localleader>un :s/^\d. //<CR>:nohlsearch<CR>
" Make selected or current line's text quote
nnoremap <buffer> <localleader>q :s/\(^[^>]\)/> \1/<CR>:nohlsearch<CR>
vnoremap <buffer> <localleader>q :s/\(^[^>]\)/> \1/<CR>:nohlsearch<CR>
nnoremap <buffer> <localleader>uq :s/^> //<CR>:nohlsearch<CR>
vnoremap <buffer> <localleader>uq :s/^> //<CR>:nohlsearch<CR>
" Mapping for PlantUml Swap Left to Right
nnoremap <buffer> <localleader>ps :s/\([^-<>:]*\)\s\s*\([ox<*\|//]*--*[ox>*\|\\]*\)\s\s*\([^-<>:]*\)\s*/\3 \2 \1 /<CR>:nohlsearch<CR>

if filereadable(expand('~/format/fmt.md'))
	nnoremap <buffer> <localleader>zz :r !cat ~/format/fmt.md<CR>
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
