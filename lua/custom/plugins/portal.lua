return {
  'cbochs/portal.nvim',
  -- Optional dependencies
  dependencies = {
    'cbochs/grapple.nvim',
    'ThePrimeagen/harpoon',
  },
  opts = {},
  keys = {
    { '<leader>po', '<cmd>Portal jumplist backward<cr>', desc = 'Portal Jump backward' },
    { '<leader>pi', '<cmd>Portal jumplist forward<cr>', desc = 'Portal Jump forward' },
  },
}
