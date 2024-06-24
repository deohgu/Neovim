return {
  'cbochs/portal.nvim',
  -- Optional dependencies
  dependencies = {
    'cbochs/grapple.nvim',
    'ThePrimeagen/harpoon',
  },
  opts = {},
  keys = {
    { '<A-o>', '<cmd>Portal jumplist backward<cr>', desc = 'Portal Jump backward' },
    { '<A-i>', '<cmd>Portal jumplist forward<cr>', desc = 'Portal Jump forward' },
  },
}
