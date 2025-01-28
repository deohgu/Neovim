return {
  'MagicDuck/grug-far.nvim',
  cmd = 'GrugFar',
  opts = {},
  keys = {
    {
      '<leader>rr',
      function()
        require('grug-far').open()
      end,
      desc = 'Replace and Replace',
    },
  },
}
