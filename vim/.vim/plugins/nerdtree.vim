if exists("g:vimrc_loaded_nerdtree")
  finish
endif

let g:vimrc_loaded_nerdtree = 1

nnoremap <silent> <expr> <Space>f g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : "\:NERDTree<CR>"
" close NERDTree after open a file
" let NERDTreeQuitOnOpen=1
