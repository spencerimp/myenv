--------------------------------------------------------------------------------
-- Editor Enhancements
--------------------------------------------------------------------------------
-- Plugins that improve editing experience
--
-- SURROUND (nvim-surround):
--   ys{motion}{char}    Add surround (e.g., ysiw" adds quotes around word)
--   ds{char}            Delete surround (e.g., ds" removes quotes)
--   cs{old}{new}        Change surround (e.g., cs"' changes " to ')
--   S{char}             Surround selection (visual mode)
--
-- COMMENT (Comment.nvim):
--   gcc                 Toggle line comment
--   gbc                 Toggle block comment
--   gc{motion}          Comment motion (e.g., gcap comments paragraph)
--   gc                  Comment selection (visual mode)
--
-- EMMET (HTML expansion):
--   Ctrl+y ,            Expand abbreviation (e.g., div>ul>li*3)
--------------------------------------------------------------------------------

return {
  -- Surround (replaces vim-surround)
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- Comment.nvim (replaces nerdcommenter)
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("Comment").setup({
        padding = true,
      })
    end,
  },

  -- Multiple cursors
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
  },

  -- Emmet for HTML (replaces emmet-vim)
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" },
    config = function()
      vim.g.user_emmet_leader_key = "<C-y>"
    end,
  },
}
