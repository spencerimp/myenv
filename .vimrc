set nu
set cindent
"Round indent to nearest shiftwidth multiple"
set shiftround
"replace tab with spaces"
set expandtab
"highlighted the search result"
set hlsearch
"show temp result before complete the search query"
set incsearch
"set fond"
set gfn=Monaco:h14
"show config"
set ruler
"show position"
set ru
filetype indent on
"fix the backspace"
set backspace=indent,eol,start
"Use UTF8 encoding"
set encoding=utf-8
"Use the sysyem clipboard"
set clipboard=unnamed
let python_highlight_all=1
set background=dark
syntax on
filetype on
"""""Identiations"""""
"Python identationfollowing PEP 8 standards"
au BufNewFile,BufRead *.py
  \set tabstop=4
  \set softtabstop=4
  \set shiftwidth=4
  \set textwidth=79
  \set expandtab
  \set autoindent
  \set fileformat=unix
  \set colorcolumn=+1
  \set wrap

""Other files"
"au BufNewFile,BufRead *.js, *.html, *.css
    "\set tabstop=2
    "\set softtabstop=2
    "\set shiftwidth=2

""""""PLUGINS"""""
"taglist"
filetype on
filetype plugin on
"exuberant-ctag config
"On osx, install using brew install ctags-exuberant
let Tlist_Ctags_Cmd='/opt/local/bin/ctags'

"On Ubuntu, install it from source code, not apt-get
" ./configure --prefix=$HOME
" make && make install
" export PATH=$HOME:$PATH
let Tlist_Ctags_Cmd='~/bin/ctags'

nnoremap <F6> :TlistToggle<CR>

"Pathogen: see https://github.com/tpope/vim-pathogen"
execute pathogen#infect()

"pydiction (autocomplete python function)"
let g:pydiction_location='~/.vim/vimfiles/pydiction/complete-dict'
let g:pydiction_menu_height=20

"Enable folding"
set foldmethod=indent
set foldlevel=99
"Use space to fold/unfold"
nnoremap <space> za

"Move curve into different windows
nnoremap <C-Right> <C-w><Right>
nnoremap <C-Left> <C-w><Left>
nnoremap <C-Up> <C-w><Up>
nnoremap <C-Down> <C-w><Down>

"Haskell"
au BufEnter *.hs compiler ghc

"Javacomplete"
setlocal omnifunc=javacomplete#Complete

"Configuration of Vundle: type :PluginInstall in vim to install them"
"Vundle: pip-like packages management system for vim"
set nocompatible              " required
filetype off                  " required

"Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"Alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Add all your plugins here
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdTree.git'
Plugin 'kien/ctrlp.vim'
"Check manual at: https://github.com/ntpeters/vim-better-whitespace
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'vim-scripts/pydiction'
Plugin 'vim-scripts/taglist.vim'
Plugin 'tpope/vim-fugitive' " git
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Check https://github.com/Valloric/YouCompleteMe#mac-os-x-super-quick-installation"
Bundle 'Valloric/YouCompleteMe'
Plugin 'djoshea/vim-matlab'
Plugin 'djoshea/vim-matlab-fold'
" colorschemes
Plugin 'morhetz/gruvbox'
Plugin 'w0ng/vim-hybrid'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'flazz/vim-colorschemes'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-markdown'
Plugin 'elzr/vim-json'
Plugin 'keith/swift.vim'
Plugin 'lifepillar/pgsql.vim'
Plugin 'mattn/emmet-vim' " html: check http://vimawesome.com/plugin/emmet-vim
"All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" airline (the fancy tab bar)
set laststatus=2
"NERDTred (tree structured hardy file browser) showcuts"
"see https://github.com/scroolose/nerdtree.git"
nnoremap <F5> :NERDTreeToggle<CR>


" automatically remove the trailing spaces upon read and save
au BufRead * :StripWhitespace
au BufWrite * :StripWhitespace

" ------------------- Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" YouCompleteMe settings
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

" python version check
if has('python')
        let g:jedi#force_py_version = 2
        let g:syntastic_python_python_exec = 'python2'
        let g:pymode_python = 'python2'
elseif has('python3')
        let g:jedi#force_py_version = 3
        let g:syntastic_python_python_exec = 'python3'
        let g:pymode_python = 'python3'
else
        let g:loaded_jedi = 1
endif

" my favorite them
colorscheme gruvbox

