" import files
source ~/.vim/_config/init/myUtil.vim

setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4
setlocal expandtab

" Make selected text Bold
vnoremap <buffer> <localleader>* :<c-u>call myUtil#insTxtAroundSelection('**' , '**')<CR>
nnoremap <buffer> <localleader>u* F*hvldf*vld
" Make selected text inline code
vnoremap <buffer> <localleader>` :<c-u>call myUtil#insTxtAroundSelection((visualmode()==#'v' ? '`' : '```') , (visualmode()==#'v' ? '`' : '```') )<CR>
nnoremap <buffer> <localleader>u` F`xf`x
" Make selected text color Blue/Red
vnoremap <buffer> <localleader>tb :<c-u>call myUtil#insTxtAroundSelection( '<span style="color: blue;">', '</span>')<CR>
vnoremap <buffer> <localleader>tr :<c-u>call myUtil#insTxtAroundSelection( '<span style="color: red;">', '</span>')<CR>
" Delete color
nnoremap <buffer> <localleader>uf vityvatp
" Append CR
nnoremap <buffer> <localleader>r m`A<br><ESC>``
nnoremap <buffer> <localleader>ur :s/<br>$//<CR> 
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
" Open Plantuml File under cursor
nnoremap <buffer> <localleader>pwe vi(:<c-u>call <SID>OpenPlantumlUnderCursor("e")<CR>
nnoremap <buffer> <localleader>pwv vi(:<c-u>call <SID>OpenPlantumlUnderCursor("vsplit")<CR>
" Mapping for PlantUml Swap Left to Right
nnoremap <buffer> <localleader>ps :s/\([^-<>:]*\)\s\s*\([ox<*\|//]*--*[ox>*\|\\]*\)\s\s*\([^-<>:]*\)\s*/\3 \2 \1 /<CR>:nohlsearch<CR>

if filereadable(expand('~/format/fmt.md'))
	nnoremap <buffer> <localleader>zz :r !cat ~/format/fmt.md<CR>
endif
