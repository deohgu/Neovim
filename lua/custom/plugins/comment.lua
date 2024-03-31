return {
  'numToStr/Comment.nvim',
  opts = {
    -- add any options here
    toggler = {
      ---Line-comment toggle keymap
      line = '<leader>/',
      ---Block-comment toggle keymap
      block = 'gbc',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      ---Line-comment keymap
      line = '<leader>/',
      ---Block-comment keymap
      block = 'gb',
    },
  },
  keys = {},
  lazy = false,
}
