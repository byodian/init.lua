require("byodian.set")
require("byodian.remap")
require("byodian.lazy")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local autogroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local highlight_group = autogroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
  group = highlight_group,
  pattern = '*',
})

-- Uncomment the following to have Vim jump to the last position when
-- reopening a file
-- https://stackoverflow.com/questions/774560/in-vim-how-do-i-get-a-file-to-open-at-the-same-line-number-i-closed-it-at-last
autocmd('BufReadPost', {
  callback = function()
    vim.cmd([[
      if line("'\"") > 0 && line("'\"") <= line("$")
        exe "normal! g'\""
      endif
    ]])
  end
})

vim.cmd("command! TSLspRename lua require'byodian.rename-file'.manual()")

-- netrw file exporer
vim.g.netrw_browser_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 50
