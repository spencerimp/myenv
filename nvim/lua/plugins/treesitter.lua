--------------------------------------------------------------------------------
-- Treesitter Configuration (Neovim 0.10 compatible)
--------------------------------------------------------------------------------

return {
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "f197a15b0d1e8d555263af20add51450e5aaa1f0", -- v0.9.2
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "python",
          "javascript",
          "typescript",
          "tsx",
          "html",
          "css",
          "json",
          "yaml",
          "markdown",
          "markdown_inline",
          "lua",
          "vim",
          "vimdoc",
          "bash",
          "c",
          "cpp",
          "go",
          "rust",
          "dockerfile",
        },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })
    end,
  },
}
