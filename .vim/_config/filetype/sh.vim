setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2
setlocal expandtab

vnoremap <localleader>// :<c-u>call myUtil#commentOut('#')<cr>


if filereadable(expand('~/format/fmt.sh'))
	nnoremap <buffer> <localleader>zz :r !cat ~/format/fmt.sh<CR>
endif

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
