if exists("g:vimrc_loaded_fern")
  finish
endif

let g:vimrc_loaded_nerdtree = 1
let g:fern#default_hidden=1

" nnoremap <silent> <Space>f :Fern . -reveal=% -drawer -toggle -width=40<CR>
nnoremap <silent> <Space>f :Fern . -reveal=%<CR>
