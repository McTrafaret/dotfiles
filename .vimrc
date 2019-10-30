call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vimwiki/vimwiki'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tmhedberg/SimpylFold'
"Plug 'vim-syntastic/syntastic' (for some reason don't work for python3)
Plug 'nvie/vim-flake8'
"Plug 'ycm-core/YouCompleteMe' (too heavy and slow)
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'

call plug#end()

"line numbers
	set nu
	set relativenumber

"colorscheme
	colorscheme molokai

" Enable folding
	set foldmethod=indent
	set foldlevel=99

"python PEP8 formatting
	au BufNewFile,BufRead *.py
	    \ set tabstop=4|
	    \ set softtabstop=4|
	    \ set shiftwidth=4|
	    \ set textwidth=79|
	    \ set expandtab|
	    \ set autoindent|
	    \ set fileformat=unix

"mapping

	"NerdTree
		map <C-N> : NERDTreeToggle

	"moving between splits
		nnoremap <C-J> <C-W><C-J>
		nnoremap <C-K> <C-W><C-K>
		nnoremap <C-L> <C-W><C-L>
		nnoremap <C-H> <C-W><C-H>

	"folding
		nnoremap <space> za

	"navigating with <++>
		nnoremap ,, /<++><Enter>ca>
		inoremap ,, <Esc>/<++><Enter>ca>

"python syntax highligting
let python_highlight_all=1
syntax on

"highlight extra whitespaces
	highlight ExtraWhitespace ctermbg=red guibg=red
	match ExtraWhitespace /\s\+$/
	autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
	autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
	autocmd InsertLeave * match ExtraWhitespace /\s\+$/
	autocmd BufWinLeave * call clearmatches()

"C++
	autocmd FileType cpp nnoremap ,s i#include <iostream><Esc>2o<Esc>iusing namespace std;<Esc>2o<Esc>iint main()<Enter>{<Enter><++><Enter>}<Esc>2gg

	autocmd FileType cpp inoremap ,f for(<++>;<++>;<++>)<Enter>{<Enter><++><Enter>}<Esc>3k0f<ca>
	autocmd FileType cpp inoremap ,d do <Enter>{<Enter><Enter>}<Enter>while(<++>);<Esc>2ki
	autocmd FileType cpp inoremap ,w while(<++>)<Enter>{<Enter><++><Enter>}<Esc>3k0f<ca>
	autocmd FileType cpp inoremap ,i if(<++>)<Enter>{<Enter><++><Enter>}<Esc>3k0f<ca>
