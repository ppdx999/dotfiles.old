if !filereadable(expand('~/.vim/autoload/plug.vim')) || has("gui_running")
	finish
endif

call plug#begin('~/.vim/plugged')

Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'junegunn/vim-easy-align'
Plug 'ppdx999/vim-alignby'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'

call plug#end()
