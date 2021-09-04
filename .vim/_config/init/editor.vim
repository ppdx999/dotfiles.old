"######### gvim Settings ##########
if has("gui_running")
	set guifont=Nsimsun:h12
	set backspace=indent,eol,start
endif

"#########  set vim's env var  ##########

if v:version >= 600
  filetype plugin on
  filetype indent on
else
  filetype on
endif

set nocompatible

set keywordprg=:help

set textwidth=0 " Disable automatic line break feature.

" Settings about Chracter
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac " newline character
set ambiwidth=double " To display □ and ○ correctly

" Setting about tab
"set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=4 " 画面上でタブ文字が占める幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
"set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=4 " smartindentで増減する幅

" Settings about Search
set incsearch " Perform a search everytime you type a single character.
set ignorecase
set smartcase " Make the search pattern case-sensitive if it contains uppercase letters.
set hlsearch " Highlighting search results.

" Settings about Command Completion
set wildmenu " Completion in command mode.
set history=5000 " Number of command histories to save.

set laststatus=2 "最下ウィンドウにステータスを常に表示する
syntax on "構文ハイライトを有効にする
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number
set nowrap
set completeopt=menu


" Clipboard setting
if has("win64") || has("win32") || has("win16")
	if has("gui_running")
		set clipboard=unnamed
	endif
elseif substitute(system("expr substr $(uname -s) 1 10"), "\n", "", "") ==# 'MINGW64_NT'
	set clipboard=unnamed
elseif substitute(system("expr substr $(uname -s) 1 5"), "\n", "", "") ==# 'Linux'
	set clipboard=unnamedplus
endif

" Align auto indent when paste from clipborad
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" Completion using a syntax file
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
          \	if &omnifunc == "" |
          \		setlocal omnifunc=syntaxcomplete#Complete |
          \	endif
endif

" 本当は、c.vim python.vim　みたいにファイルを作成してその中のそれぞれにこれを書きたい。
if has("autocmd")
	" Change the background color of columns 80 and beyond.
	autocmd FileType c,cpp,python,java,ruby,javascript,sh let &colorcolumn=join(range(81,999),",")
	autocmd FileType c,cpp,python,java,ruby,javascript,sh hi ColorColumn ctermbg=235 guibg=#2c2d27 
endif
