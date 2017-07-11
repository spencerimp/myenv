set nu
set cindent
"Round indent to nearest shiftwidth multiple"
set shiftround
"replace tab with spaces"
set expandtab
"highlighten the search result"
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
""""""PLUGINS"""""
"taglist"
filetype on
filetype plugin on
"exuberant-ctag config
"In OSX, install using brew
"brew install ctags-exuberant

"In Ubuntu, install it from source code
" wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz
" tar -xvf ctags-5.8.tar.gz
" cd ctags-5.8
" ./configure --prefix=$HOME
" make && make install
" export PATH=$HOME:$PATH

"pydiction (autocomplete python function)"
let g:pydiction_location='~/.vim/vimfiles/pydiction/complete-dict'
let g:pydiction_menu_height=20

"Enable folding"
set foldmethod=indent
set foldlevel=99
"Use space to fold/unfold"
nnoremap <space> za

"Move cursor into different windows
nnoremap <C-Right> <C-w><Right>
nnoremap <C-Left> <C-w><Left>
nnoremap <C-Up> <C-w><Up>
nnoremap <C-Down> <C-w><Down>
nnoremap <C-j> <C-w><j>
nnoremap <C-k> <C-w><k>
nnoremap <C-h> <C-w><h>
nnoremap <C-l> <C-w><l>

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
Plugin 'Vundle/Vundle.vim'
" Add all your plugins here
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8' " pip install flake8, <F7> to launch
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdTree.git'
Plugin 'kien/ctrlp.vim'
"Check manual at: https://github.com/ntpeters/vim-better-whitespace
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'vim-scripts/pydiction'
Plugin 'majutsushi/tagbar' " ctags plugin
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
" other languages
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'flazz/vim-colorschemes'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-markdown'
Plugin 'elzr/vim-json'
Plugin 'keith/swift.vim'
Plugin 'lifepillar/pgsql.vim'
Plugin 'rizzatti/dash.vim' " works only in OSX
Plugin 'mattn/emmet-vim' " html: check http://vimawesome.com/plugin/emmet-vim
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
"All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" airline (the fancy tab bar)
set laststatus=2
"NERDTred (tree structured hardy file browser) showcuts"
"see https://github.com/scroolose/nerdtree.git"
nnoremap <F5> :NERDTreeToggle<CR>

" tagbar configuration
nmap <F4> :TagbarToggle<CR>

" automatically remove the trailing spaces upon read and save
au BufRead * :StripWhitespace
au BufWrite * :StripWhitespace

" ------------------- Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" ultisnipis setting
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"


" YouCompleteMe settings
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

" python version check
if has('python')
        let g:jedi#force_py_version = 2
        let g:syntastic_python_python_exec = 'python2'
        let g:pymode_python = 'python2'
        let snipsUsePythonVersion = 2
elseif has('python3')
        let g:jedi#force_py_version = 3
        let g:syntastic_python_python_exec = 'python3'
        let g:pymode_python = 'python3'
        let g:loaded_jedi = 1
        let snipsUsePythonVersion = 3
endif

" syntastic (https://github.com/scrooloose/syntastic)
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


let g:syntastic_mode_map = {'mode': 'passive', 'active_filetypes':[],'passive_filetypes':[]}
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_python_pylint_args = '-E' "only show error
let g:syntastic_check_on_wq = 0

" pylint: could be the state-of-the-art python checker
" pip install pylint
" check or create ~/.pylintrc
let g:syntastic_python_checkers = ['pylint']
nnoremap <F8> :SyntasticCheck<CR> "F8 to launch pylint check
nnoremap <F6> :SyntasticToggleMode<CR> "F6 to toggle off the message
"nnoremap <C-t> :let syntastic_python_pylint_args=''<CR> "Ctrl + t to show all types of message
"nnoremap <C-e> :let syntastic_python_pylint_args='-E'<CR> "Ctrl + e to show only the error

" check or create ~/.config/flake8 for flake8 configuration
" [flake8]
" ignore = E402

" my favorite theme
" To use this in termial, append this to the shell configuration
" export TERM="xterm-256color"
colorscheme gruvbox
" other shutcuts
nnoremap <F3> :Shell python %<CR> "F3 to python <current.py>
nnoremap <S-F6> :pclose<CR> "Shift + F6 to clese preview window
nnoremap <F2> :source ~/.vimrc<CR> "F2 to reload configuration

" emet
let g:user_emmet_expandabbr_key = '<Tab>'

"" Execute the shell command and show the result in a new buffer/window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  let isfirst = 1
  let words = []
  for word in split(a:cmdline)
    if isfirst
      let isfirst = 0  " don't change first word (shell command)
    else
      if word[0] =~ '\v[%#<]'
        let word = expand(word)
      endif
      let word = shellescape(word, 1)
    endif
    call add(words, word)
  endfor
  let expanded_cmdline = join(words)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  "call setline(1, 'You entered:  ' . a:cmdline)
  "call setline(2, 'Expanded to:  ' . expanded_cmdline)
  "call append(line('$'), substitute(getline(2), '.', '=', 'g'))
  silent execute '$read !'. expanded_cmdline
  1
endfunction
