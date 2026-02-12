--------------------------------------------------------------------------------
-- UI Configuration
--------------------------------------------------------------------------------
-- Visual elements: theme, statusline, file tree, icons
--
-- COLORSCHEME: gruvbox (dark, hard contrast)
--   :colorscheme <name>     Change theme
--
-- STATUSLINE: lualine
--   Shows: mode, branch, diff, diagnostics, filename, encoding, filetype, position
--   Tabline shows open buffers
--
-- FILE TREE: nvim-tree (replaces NERDTree)
--   F5                      Toggle file tree
--   :NvimTreeToggle         Toggle file tree
--   :NvimTreeFindFile       Find current file in tree
--
--   Inside nvim-tree (NERDTree-style):
--     Enter     Open file
--     o         Open file
--     s / S     Open in vertical split
--     v / V     Open in horizontal split
--     a         Create new file/directory
--     d         Delete
--     r         Rename
--     y         Copy name
--     Y         Copy path
--     c         Copy
--     p         Paste
--     R         Refresh
--     q         Close tree
--------------------------------------------------------------------------------

return {
  -- Gruvbox colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        transparent_mode = false,
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },

  -- Lualine statusline (replaces vim-airline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",
          icons_enabled = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        tabline = {
          lualine_a = { "buffers" },
          lualine_z = { "tabs" },
        },
      })
    end,
  },

  -- nvim-tree file explorer (replaces NERDTree)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Custom keymaps to match NERDTree behavior
      local function on_attach(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- NERDTree-style: s/S = vertical split, v/V = horizontal split
        pcall(vim.keymap.del, "n", "s", { buffer = bufnr })
        pcall(vim.keymap.del, "n", "v", { buffer = bufnr })
        vim.keymap.set("n", "s", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "S", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "v", api.node.open.horizontal, opts("Open: Horizontal Split"))
        vim.keymap.set("n", "V", api.node.open.horizontal, opts("Open: Horizontal Split"))
      end

      require("nvim-tree").setup({
        on_attach = on_attach,
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        filters = {
          dotfiles = false,
          custom = { ".git", "node_modules", ".cache", "__pycache__" },
        },
        git = {
          enable = true,
          ignore = false,
        },
        actions = {
          open_file = {
            quit_on_open = false,
            resize_window = true,
          },
        },
      })

      -- Auto close if nvim-tree is the last window
      vim.api.nvim_create_autocmd("QuitPre", {
        callback = function()
          local wins = vim.api.nvim_list_wins()
          local tree_wins = {}
          local floating_wins = {}
          for _, w in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(w)
            if vim.bo[buf].ft == "NvimTree" then
              table.insert(tree_wins, w)
            end
            if vim.api.nvim_win_get_config(w).relative ~= "" then
              table.insert(floating_wins, w)
            end
          end
          if #wins - #floating_wins - #tree_wins == 1 then
            for _, w in ipairs(tree_wins) do
              vim.api.nvim_win_close(w, true)
            end
          end
        end,
      })
    end,
  },

  -- Web devicons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = { char = "│" },
        scope = { enabled = true },
      })
    end,
  },

  -- Better whitespace (replaces vim-better-whitespace)
  {
    "ntpeters/vim-better-whitespace",
    config = function()
      vim.g.better_whitespace_enabled = 1
      vim.g.strip_whitespace_on_save = 0 -- We handle this in autocmds
    end,
  },
}
