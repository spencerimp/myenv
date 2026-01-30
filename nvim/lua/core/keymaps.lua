--------------------------------------------------------------------------------
-- Key Bindings
--------------------------------------------------------------------------------
-- All keybindings in one place. Ported from .vimrc with modern additions.
--
-- NAVIGATION:
--   Space           Toggle fold
--   Ctrl+h/j/k/l    Window navigation
--   Ctrl+arrows     Window navigation (alternative)
--   H / L           Previous / Next buffer
--   B               Add buffer (:badd)
--   Ctrl+X          Delete buffer
--
-- FUNCTION KEYS:
--   F2              Reload config
--   F3              Run current Python file
--   F4              Toggle symbol outline (Aerial)
--   F5              Toggle file tree (nvim-tree)
--   F8              Show diagnostics (Telescope)
--   F9              Toggle diagnostics on/off
--
-- LSP (set in plugins/lsp.lua on_attach):
--   gd              Go to definition
--   gD              Go to declaration
--   gr              Find references
--   gi              Go to implementation
--   K               Hover documentation
--   ;rn             Rename symbol
--   ;ca             Code actions
--   ;f              Format file
--   ;d              Show diagnostic float
--   [d / ]d         Prev / Next diagnostic
--
-- TELESCOPE (set in plugins/telescope.lua):
--   Ctrl+p          Find files
--   ;ff             Find files
--   ;fg             Live grep
--   ;fb             Find buffers
--   ;fh             Help tags
--   ;fr             Recent files
--   ;fs             Document symbols
--   ;fw             Grep word under cursor
--
-- TERMINAL:
--   Esc             Exit terminal mode
--------------------------------------------------------------------------------

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Space to toggle fold
map("n", "<space>", "za", opts)

-- Window navigation with Ctrl + hjkl
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Window navigation with Ctrl + arrows
map("n", "<C-Right>", "<C-w><Right>", opts)
map("n", "<C-Left>", "<C-w><Left>", opts)
map("n", "<C-Up>", "<C-w><Up>", opts)
map("n", "<C-Down>", "<C-w><Down>", opts)

-- Window split
map("n", "<C-s>", "<C-w>s", opts)
-- Note: <C-v> conflicts with paste, using leader instead
map("n", "<leader>v", "<C-w>v", opts)

-- Buffer navigation
map("n", "H", ":bprevious<CR>", opts)
map("n", "L", ":bnext<CR>", opts)
map("n", "B", ":badd ", { noremap = true })
map("n", "<C-X>", ":bdelete<CR>", opts)

-- F2: Reload config
map("n", "<F2>", ":source $MYVIMRC<CR>", opts)

-- F3: Run Python (using shell utility)
map("n", "<F3>", function()
  require("utils.shell").run("python " .. vim.fn.expand("%"))
end, opts)

-- F4: Symbol outline (defined in plugins/editor.lua)

-- F5: File tree (nvim-tree)
map("n", "<F5>", ":NvimTreeToggle<CR>", opts)

-- F8: Show diagnostics
map("n", "<F8>", ":Telescope diagnostics<CR>", opts)

-- F9: Toggle diagnostics
local diagnostics_active = true
map("n", "<F9>", function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.enable()
    print("Diagnostics enabled")
  else
    vim.diagnostic.disable()
    print("Diagnostics disabled")
  end
end, opts)

-- Terminal escape
map("t", "<Esc>", "<C-\\><C-n>", opts)

-- Clear search highlight
map("n", "<leader>h", ":nohlsearch<CR>", opts)

-- LSP keybindings (set up in lsp.lua on_attach)
-- gd - Go to definition
-- gr - References
-- K - Hover docs
-- ;rn - Rename
-- ;ca - Code actions
-- ;f - Format

-- Telescope bindings (set up in telescope.lua)
-- Ctrl+p - Find files
-- ;fg - Live grep
-- ;fb - Find buffers
