-- Display LSP-based breadcrumbs
return {
  'utilyre/barbecue.nvim',
  event = { 'BufEnter', 'BufNewFile', 'BufReadPre' },
  name = 'barbecue',
  version = '*',
  dependencies = {
    'SmiteshP/nvim-navic',
    'nvim-tree/nvim-web-devicons', -- optional dependency
  },
  opts = {},
}
