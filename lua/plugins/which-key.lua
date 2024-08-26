return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    plugins = { spelling = true },
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts)

    wk.add({
      -- {"<leader><tab>", name = "+tabs"},
      { '<leader>b', name = '+buffer' },
      { '<leader>c', name = '+coc' },
      { '<leader>d', name = '+debugger' },
      { '<leader>f', name = '+file/find' },
      { '<leader>g', name = '+git' },
      { '<leader>gx', name = '+merge conflicts' },
      -- {"<leader>p", name = "+portal"},
      { '<leader>r', name = '+replace' },
      { '<leader>s', name = '+surround' },
      { '<leader>u', name = '+ui' },
      { '<leader>w', name = '+windows' },
      { '<leader>x', name = '+diagnostics/quickfix' },
      { '[', name = '+prev' },
      { ']', name = '+next' },
      { 'g', name = '+goto' },
      { 'gs', name = '+surround' },
      {
        '<leader>?',
        function()
          wk.show { mode = 'n', auto = true }
        end,
        desc = 'Show Keymaps',
      },
    }, { mode = { 'n', 'v' } })

    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
}
