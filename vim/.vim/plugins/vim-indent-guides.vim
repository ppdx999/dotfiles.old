if exists("g:vimrc_loaded_vim_indent_guides")
  finish
endif

let g:vimrc_loaded_vim_indent_guides = 1

let g:indent_guides_enable_on_vim_startup = 1


let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235
