--------------------------------------------------------------------------------
-- Neovim Configuration
--------------------------------------------------------------------------------
-- A modern Lua-based neovim setup with LSP, treesitter, and lazy.nvim
--
-- QUICK START:
--   1. First launch auto-installs plugins via lazy.nvim
--   2. :Lazy        - Manage plugins
--   3. :Mason       - Manage LSP servers
--   4. :checkhealth - Verify setup
--
-- KEY BINDINGS:
--   Leader key: ;
--   Space      - Toggle fold
--   Ctrl+p     - Find files (telescope)
--   F5         - Toggle file tree
--   gd         - Go to definition
--   K          - Hover docs
--   ;rn        - Rename symbol
--   ;ca        - Code actions
--
-- See lua/core/keymaps.lua for all keybindings
--------------------------------------------------------------------------------

-- Load core modules (options, keymaps, autocmds)
require("core")

-- Load plugins (lazy.nvim bootstrap and plugin specs)
require("plugins")
