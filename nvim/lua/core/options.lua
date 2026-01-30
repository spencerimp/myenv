--------------------------------------------------------------------------------
-- Vim Options
--------------------------------------------------------------------------------
-- Core editor settings ported from .vimrc
--
-- INDENTATION: 4 spaces by default (see after/ftplugin/ for per-language)
-- LEADER KEY:  ; (semicolon)
-- CLIPBOARD:   Uses system clipboard (unnamed)
-- FOLDING:     Indent-based, use Space to toggle
--------------------------------------------------------------------------------

local opt = vim.opt

-- Line numbers
opt.number = true

-- Indentation
opt.cindent = true
opt.shiftround = true
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Display
opt.ruler = true
opt.laststatus = 2
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Clipboard
opt.clipboard = "unnamed"

-- Backspace behavior
opt.backspace = "indent,eol,start"

-- Buffer behavior
opt.autoread = true
opt.hidden = true

-- No swap files
opt.swapfile = false

-- Folding
opt.foldmethod = "indent"
opt.foldlevel = 99

-- Wild menu
opt.wildmenu = true
opt.wildmode = "list:longest"

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Split behavior
opt.splitbelow = true
opt.splitright = true

-- Update time for faster completion
opt.updatetime = 300

-- Leader key
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

-- Python highlighting
vim.g.python_highlight_all = 1

-- Disable netrw (we use nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
