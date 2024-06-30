local neotest_jest = require('neotest-jest')({
  jestCommand = 'npm test --',
  jestConfigFile = 'custom.jest.config.ts',
  env = { CI = true },
  cwd = function(path)
    return vim.fn.getcwd()
  end,
})

neotest_jest.filter_dir = function(name)
  return name ~= 'node_modules' and name ~= '__snapshots__'
end

require('neotest').setup({
  adapters = {
    require('neotest-python')({
      -- dap = { justMyCode = false },
      runner = 'unittest',
    }),
    neotest_jest,
    require('neotest-vitest'),
    require('neotest-go')
  },
  output_panel = {
    enabled = true,
    open = 'botright split | resize 15'
  },
  quickfix = {
    open = false
  }
})
