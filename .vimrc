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
Plug 'lyokha/vim-xkbswitch'

call plug#end()

"vimwiki open vfiles in vim tab
  function! VimwikiLinkHandler(link)
    " Use Vim to open external files with the 'vfile:' scheme.  E.g.:
    "   1) [[vfile:~/Code/PythonProject/abc123.py]]
    "   2) [[vfile:./|Wiki Home]]
    let link = a:link
    if link =~# '^vfile:'
      let link = link[1:]
    else
      return 0
    endif
    let link_infos = vimwiki#base#resolve_link(link)
    if link_infos.filename == ''
      echomsg 'Vimwiki Error: Unable to resolve link!'
      return 0
    else
      exe 'tabnew ' . fnameescape(link_infos.filename)
      return 1
    endif
  endfunction

"switch layouts
	let g:XkbSwitchEnabled = 1
	let g:XkbSwitchIMappings = ['ru']

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

	"Meta-test
		nnoremap <M-H> ihype<Esc>

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

	"get out of brackets
		inoremap <C-G> <Esc>/)\\|}\\|]\\|'\\|"\\|><Enter>a

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
