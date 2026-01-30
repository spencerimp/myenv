--------------------------------------------------------------------------------
-- Git Integration
--------------------------------------------------------------------------------
-- Git support with fugitive and gitsigns
--
-- FUGITIVE COMMANDS:
--   :Git                Open git status (or :G)
--   :Git blame          Show blame
--   :Git diff           Show diff
--   :Git log            Show log
--   :Gdiffsplit         Open diff in split
--   :Gread              Checkout file (revert changes)
--   :Gwrite             Stage file
--
-- GITSIGNS KEY BINDINGS:
--   ]c / [c             Next / Previous hunk
--   ;hs                 Stage hunk
--   ;hr                 Reset hunk
--   ;hS                 Stage buffer
--   ;hu                 Undo stage hunk
--   ;hR                 Reset buffer
--   ;hp                 Preview hunk
--   ;hb                 Blame line (full)
--   ;tb                 Toggle current line blame
--   ;hd                 Diff this
--   ;hD                 Diff this ~
--   ;td                 Toggle deleted
--   ih                  Select hunk (text object)
--------------------------------------------------------------------------------

return {
  -- Fugitive (keep the classic)
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
  },

  -- Gitsigns for git decorations
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Can toggle with :Gitsigns toggle_current_line_blame
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 500,
          ignore_whitespace = false,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local map = vim.keymap.set
          local opts = { buffer = bufnr }

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, buffer = bufnr })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, buffer = bufnr })

          -- Actions
          map("n", "<leader>hs", gs.stage_hunk, opts)
          map("n", "<leader>hr", gs.reset_hunk, opts)
          map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, opts)
          map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, opts)
          map("n", "<leader>hS", gs.stage_buffer, opts)
          map("n", "<leader>hu", gs.undo_stage_hunk, opts)
          map("n", "<leader>hR", gs.reset_buffer, opts)
          map("n", "<leader>hp", gs.preview_hunk, opts)
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, opts)
          map("n", "<leader>tb", gs.toggle_current_line_blame, opts)
          map("n", "<leader>hd", gs.diffthis, opts)
          map("n", "<leader>hD", function()
            gs.diffthis("~")
          end, opts)
          map("n", "<leader>td", gs.toggle_deleted, opts)

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", opts)
        end,
      })
    end,
  },
}
