return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  keys = {
    { '<leader>i', '<cmd>Neotree toggle<cr>', desc = 'Alt File Tree for extra Info' },
  },
  opts = {
    filesystem = {
      follow_current_file = { enabled = true },
    },
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)
  end,
}
