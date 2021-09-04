" Change the background color of columns 80 and beyond.
let &colorcolumn=join(range(81,999),",")
hi ColorColumn ctermbg=235 guibg=#2c2d27 

setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4
setlocal noexpandtab

vnoremap <localleader>// :<c-u>call myUtil#commentOut('//')<cr>

