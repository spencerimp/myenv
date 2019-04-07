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
"set font"
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
"reload the modified buffers
set autoread
syntax on

"leader key
let mapleader = ";"
""""""PLUGINS"""""
syntax enable
filetype on
filetype plugin on
"taglist"
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

nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>

nnoremap <C-s> <C-w><C-s>
nnoremap <C-v> <C-w><C-v>

"Haskell"
au BufEnter *.hs compiler ghc

"Javacomplete"
"setlocal omnifunc=javacomplete#Complete

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
Plugin 'vim-scripts/pydiction'
"Plugin 'scrooloose/syntastic'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8' " pip install flake8, <F7> to launch
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdTree.git'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/SearchComplete'
"Plugin 'klen/pythen-mode'
"Plugin 'python-rope/ropevim'
"Plugin 'davidhalter/jedi-vim'
"Check manual at: https://github.com/ntpeters/vim-better-whitespace
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'majutsushi/tagbar' " ctags plugin
Plugin 'tpope/vim-fugitive' " git
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Check https://github.com/Valloric/YouCompleteMe#mac-os-x-super-quick-installation"
Plugin 'Valloric/YouCompleteMe'
Plugin 'djoshea/vim-matlab'
Plugin 'djoshea/vim-matlab-fold'
" colorschemes
Plugin 'morhetz/gruvbox'
Plugin 'w0ng/vim-hybrid'
" other languages
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'flazz/vim-colorschemes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'pangloss/vim-javascript'
"Plugin 'godlygeek/tabular'
"Plugin 'plasticboy/vim-markdown'
"Plugin 'tpope/vim-markdown'
"Plugin 'PProvost/vim-markdown-jekyll'
Plugin 'tpope/vim-liquid'
Plugin 'junegunn/goyo.vim'
Plugin 'elzr/vim-json'
Plugin 'keith/swift.vim'
Plugin 'lifepillar/pgsql.vim'
Plugin 'vim-scripts/SQLComplete.vim'
Plugin 'rizzatti/dash.vim' " works only in OSX
Plugin 'mattn/emmet-vim' " html: check http://vimawesome.com/plugin/emmet-vim
Plugin 'junegunn/vim-emoji'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'ervandew/supertab'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'w0rp/ale'
Plugin 'leafgarland/typescript-vim'
Plugin 'django.vim'
Plugin 'tweekmonster/django-plus.vim'
Plugin 'rstacruz/sparkup'
" React.js
Plugin 'mxw/vim-jsx'
Plugin 'vim-babel'

"Plugin 'avakhov/vim-yaml'
"All ef your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"pydiction (autocomplete python function)"
let g:pydiction_location='~/.vim/vimfiles/pydiction/complete-dict'
let g:pydiction_menu_height=20

set wildmenu
set wildmode=list:longest

" airline (the fancy tab bar)
let g:airline_theme='hybrid'
set laststatus=2
"NERDTred (tree structured hardy file browser) showcuts"
"see https://github.com/scroolose/nerdtree.git"
nnoremap <F5> :NERDTreeToggle<CR>
" quit vim if NERDTree is the last and only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" tagbar configuration
nmap <F4> :TagbarToggle<CR>
nmap <F9> :ALEToggle<CR>

" nerdcommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 0

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" automatically remove the trailing spaces upon read and save
au BufRead * :StripWhitespace
au BufWrite * :StripWhitespace

au BufNewFile,BufRead Jenkinsfile setf groovy

" ale
let g:ale_fix_on_save = 1
let g:ale_linters = {'jsx': ['stylelint', 'eslint'], 'python': ['pylint']}

" vim-instant-markdown
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 1
let g:instant_markdown_allow_unsafe_content = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_math = 1
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
"let g:UltiSnipsExpandTrigger = "<C-j>"
"let g:UltiSnipsJumpForwardTrigger = "<C-j>"
"let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

" YouCompleteMe settings
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'


let g:sql_type_default = 'pgsql'

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
let g:syntastic_loc_list_height = 5
let g:syntastic_check_on_open = 0
let g:syntastic_python_pylint_args = '-E' "only show error
let g:syntastic_check_on_wq = 0
" for JS
let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_javascript_eslint_exe = 'npm run lint --'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn


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

"Ultisnips
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets

" my favorite theme
" To use this in termial, append this to the shell configuration
" export TERM="xterm-256color"
colorscheme gruvbox
" other shutcuts
nnoremap <F3> :Shell python %<CR> "F3 to python <current.py>
nnoremap <S-F6> :pclose<CR> "Shift + F6 to close preview window
nnoremap <F2> :source ~/.vimrc<CR> "F2 to reload configuration
nnoremap T :tabe<CR> " Capital T to create new tab
nnoremap H :tabprevious<CR> " Capital H to previous tab
nnoremap L :tabnext<CR> " Capital L to next tab

" emet
"let g:user_emmet_expandabbr_key = '<Tab>'

" pymode
"let g:pymode_python = 'python3'
"let g:pymode_options_colorcolumn = 0

" emoji completion when editing Markdown files
"augroup emoji_complete
  "autocmd!
    "autocmd FileType markdown setlocal completefunc=emoji#complete
    "augroup END

" markdown and jekyll
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_folding_style_pythonic = 1
au BufNewFile,BufFilePre,BufRead *.md set syntax=markdown

" Apply JSX syntax in .js files
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
let g:syntastic_javascript_checkers = ['eslint']

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
