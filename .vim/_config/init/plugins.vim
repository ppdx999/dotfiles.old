if !filereadable(expand('~/.vim/autoload/plug.vim')) || has("gui_running")
	finish
endif

call plug#begin('~/.vim/plugged')

Plug 'mattn/emmet-vim'

Plug 'tpope/vim-surround'

Plug 'preservim/nerdtree'

Plug 'junegunn/vim-easy-align'
Plug 'ppdx999/vim-alignby'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/ayncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'

call plug#end()
