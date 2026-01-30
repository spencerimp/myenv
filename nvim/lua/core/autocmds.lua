-- Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- General settings group
local general = augroup("General", { clear = true })

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = general,
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Close completion popup on cursor movement or leaving insert mode
autocmd({ "CursorMovedI", "InsertLeave" }, {
  group = general,
  callback = function()
    if vim.fn.pumvisible() == 0 then
      vim.cmd("pclose")
    end
  end,
})

-- Jenkinsfile as groovy
autocmd({ "BufNewFile", "BufRead" }, {
  group = general,
  pattern = "Jenkinsfile",
  callback = function()
    vim.bo.filetype = "groovy"
  end,
})

-- Markdown syntax
autocmd({ "BufNewFile", "BufFilePre", "BufRead" }, {
  group = general,
  pattern = "*.md",
  callback = function()
    vim.bo.syntax = "markdown"
  end,
})

-- Haskell compiler
autocmd("BufEnter", {
  group = general,
  pattern = "*.hs",
  command = "compiler ghc",
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = general,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Auto-resize splits when window is resized
autocmd("VimResized", {
  group = general,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
