--------------------------------------------------------------------------------
-- Plugin Manager (lazy.nvim)
--------------------------------------------------------------------------------
-- Plugins are organized into separate files under lua/plugins/
--
-- COMMANDS:
--   :Lazy           Open plugin manager UI
--   :Lazy sync      Update all plugins
--   :Lazy clean     Remove unused plugins
--   :Lazy health    Check plugin health
--
-- PLUGIN FILES:
--   ui.lua          Theme, statusline, file tree, icons
--   treesitter.lua  Syntax highlighting
--   lsp.lua         Language servers + Mason
--   completion.lua  Autocompletion + snippets
--   telescope.lua   Fuzzy finder
--   editor.lua      Surround, comment, which-key, etc.
--   git.lua         Fugitive, gitsigns
--------------------------------------------------------------------------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
  -- Import plugin specs from separate files
  { import = "plugins.ui" },
  { import = "plugins.treesitter" },
  -- LSP disabled for Neovim 0.10 compatibility
  -- Uncomment when you upgrade to Neovim 0.11+:
  -- { import = "plugins.lsp" },
  { import = "plugins.completion" },
  { import = "plugins.telescope" },
  { import = "plugins.editor" },
  { import = "plugins.git" },
}, {
  -- lazy.nvim configuration
  install = {
    colorscheme = { "gruvbox" },
  },
  checker = {
    enabled = false, -- Don't auto-check for updates
  },
  change_detection = {
    notify = false,
  },
})
