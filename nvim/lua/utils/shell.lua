-- Shell command utility (ported from .vimrc)
local M = {}

-- Run a shell command and display output in a new buffer
function M.run(cmdline)
  local words = {}
  local isfirst = true

  for word in cmdline:gmatch("%S+") do
    if not isfirst then
      -- Expand vim special characters
      if word:match("^[%%#<]") then
        word = vim.fn.expand(word)
      end
      word = vim.fn.shellescape(word, 1)
    end
    isfirst = false
    table.insert(words, word)
  end

  local expanded_cmdline = table.concat(words, " ")

  -- Create new buffer at bottom
  vim.cmd("botright new")
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.buflisted = false
  vim.bo.swapfile = false
  vim.wo.wrap = false

  -- Execute command and read output
  vim.cmd("silent $read !" .. expanded_cmdline)

  -- Go to first line
  vim.cmd("1")
end

-- Create the :Shell command
vim.api.nvim_create_user_command("Shell", function(opts)
  M.run(opts.args)
end, { nargs = "+", complete = "shellcmd" })

return M
