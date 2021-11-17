" import file
source ~/.vim/_config/init/myUtil.vim

" map leader
let mapleader = ","
let maplocalleader = ";"

" completion of parentheses
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>


if isdirectory(expand('~/.vim/plugged/nerdtree'))
	" Quickly Open NERDTree
	nnoremap <leader>f :NERDTree<CR>
endif

" Move around faster
nnoremap <leader>w <C-w>w<CR>
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
vnoremap s( :<c-u>call myUtil#insTxtAroundSelection( '(', ')')<CR>
vnoremap s' :<c-u>call myUtil#insTxtAroundSelection( "'", "'")<CR>
vnoremap s" :<c-u>call myUtil#insTxtAroundSelection( '"', '"')<CR>
nnoremap <leader>u( vi(yva(p
nnoremap <leader>u' vi'yva'p
nnoremap <leader>u" vi"yva"p

" Append a char.
nnoremap <leadrer>a, A,<ESC>
nnoremap <leadrer>a; A;<ESC>

" Quickly open a file under cursor as vsplit
nnoremap gb :vertical wincmd f<CR>

" Quickly move cursor in insert mode.
inoremap <C-a> <left>
inoremap <C-s> <down>
inoremap <C-d> <right>
inoremap <C-w> <up>
inoremap <C-q> <home>
inoremap <C-e> <end>


" Easily add date 
" inoremap <C-s> <C-r>=myUtil#En2JpDate(strftime("%Y/%m/%d (%a)"))<CR>
" nnoremap <C-s> :call myUtil#insertTextAtCurrentCursor(myUtil#En2JpDate(strftime("%Y/%m/%d (%a)")))<CR>

" Copy clipboard in Cygwin
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
