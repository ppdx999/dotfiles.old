if exists('g:loaded_myUtil')
	finish
endif
let g:loaded_myUtil = 1

" 日本語は2バイトとしてカウントする。
function! myUtil#strlenX(text)
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

function! myUtil#padcutTextWith(text,padChar,maxLen)
	let lineLen = myUtil#strlenX(a:text)
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

function! myUtil#commentOut(commentChar)
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

function! myUtil#formatComment(commentChar)
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

		let newLine = myUtil#padcutTextWith(oldLine, lastChar, length)
		call setline(lineNum, newLine)
	endfor
endfunction

" Insert text at the current cursor position.
function! myUtil#insertTextAtCurrentCursor(text)
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

function! myUtil#substrX(text, s, e)
	return join(split(a:text, '\zs')[a:s:a:e], '')
endfunction

function! myUtil#insTxtAroundSelection(leftText, rightText)

    let [lineStart, columnStart] = getpos("'<")[1:2]
    let [lineEnd, columnEnd] = getpos("'>")[1:2]

	if lineStart ==# lineEnd
		let line = getline(lineStart)
		let newLine = (columnStart==#1 ? '' : line[0:columnStart-2]) . a:leftText . line[columnStart-1:columnEnd-(&selection == 'inclusive' ? 1 : 2)] . a:rightText . line[columnEnd-(&selection == 'inclusive' ? 0 : 1):]
		"let newLine = (columnStart==#1 ? '' : myUtil#substrX(line, 0, columnStart-2) ) . a:leftText . myUtil#substrX(line, columnStart-1, columnEnd-(&selection == 'inclusive' ? 1 : 2)) . a:rightText . myUtil#substrX(line, columnEnd-(&selection == 'inclusive' ? 0 : 1), '')
		call setline(lineStart, newLine)
	else
		call append(lineStart-1, a:leftText)
		call append(lineEnd+1, a:rightText)
	endif

endfunction

function! myUtil#En2JpDate(text)
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


" 読み込んでいる.tagsファイルパスと同じ場所でタグファイルを生成するための関数
function! myUtil#execute_ctags() abort
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
