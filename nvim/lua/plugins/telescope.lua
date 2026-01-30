--------------------------------------------------------------------------------
-- Telescope (Fuzzy Finder)
--------------------------------------------------------------------------------
-- Powerful fuzzy finder for files, text, buffers, and more
-- Replaces ctrlp.vim with more features
--
-- KEY BINDINGS:
--   Ctrl+p      Find files (same as old ctrlp)
--   ;ff         Find files
--   ;fg         Live grep (search text in all files)
--   ;fb         Find buffers
--   ;fh         Help tags
--   ;fr         Recent files (oldfiles)
--   ;fc         Commands
--   ;fs         Document symbols (LSP)
--   ;fw         Grep word under cursor
--
-- INSIDE TELESCOPE:
--   Ctrl+j/k    Move selection up/down
--   Enter       Open selected
--   Ctrl+q      Send selected to quickfix
--   Esc         Close telescope
--
-- COMMANDS:
--   :Telescope              Open picker list
--   :Telescope find_files   Find files
--   :Telescope live_grep    Search text
--   :Telescope buffers      List buffers
--------------------------------------------------------------------------------

return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<Esc>"] = actions.close,
            },
          },
          file_ignore_patterns = {
            "node_modules",
            ".git/",
            "__pycache__",
            "%.pyc",
            ".venv",
            "venv",
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            follow = true,
          },
          live_grep = {
            additional_args = function()
              return { "--hidden" }
            end,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      -- Load fzf extension
      telescope.load_extension("fzf")

      -- Keymaps
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Ctrl+p for find files (same as ctrlp)
      map("n", "<C-p>", builtin.find_files, opts)

      -- Leader mappings
      map("n", "<leader>ff", builtin.find_files, opts)
      map("n", "<leader>fg", builtin.live_grep, opts)
      map("n", "<leader>fb", builtin.buffers, opts)
      map("n", "<leader>fh", builtin.help_tags, opts)
      map("n", "<leader>fr", builtin.oldfiles, opts)
      map("n", "<leader>fc", builtin.commands, opts)
      map("n", "<leader>fs", builtin.lsp_document_symbols, opts)
      map("n", "<leader>fw", builtin.grep_string, opts)
    end,
  },
}
