local api = vim.api
local lsp = vim.lsp

local M = {}

M.tsserver_extension_pattern = '[.][tj][s]x?$'

M.get_tsserver_client = function()
  for _, client in ipairs(lsp.get_active_clients()) do
    if client.name == 'tsserver' or client.name == 'typescript' then
      return client
    end
  end
end

M.echo_warning = function(msg)
  api.nvim_echo({ { 'Warning: ' .. msg, 'WarningMsg' } }, true, {})
end

M.file = {
  dir_file = function(dir, depth)
    return require('plenary.scandir').scan_dir(dir, {
      depth = depth or 5,
      search_pattern = M.tsserver_extension_pattern,
    })[1]
  end,

  extension = function(filename)
    return vim.fn.fnamemodify(filename, ':e')
  end
}

return M
