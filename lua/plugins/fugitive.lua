return {
  'tpope/vim-fugitive',
  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  keys = {
    { '<leader>gd', ':Gdiffsplit<CR>', mode = 'n', desc = 'Diff split' },
    { '<leader>gD', ':Gvdiffsplit<CR>', mode = 'n', desc = 'Diff split vertical' },

    -- Moves cursor to the right split
    -- { '<leader>gd', ':Gdiffsplit<CR>:wincmd l<CR>', mode = 'n', desc = 'Diff' },
    { '<leader>gxx', ':Gvdiff!<CR>', mode = 'n', desc = 'Diff Merge Conflict' },
    { '<leader>gxh', ':diffget //2<CR>', mode = 'n', desc = 'Get changes from left' },
    { '<leader>gxl', ':diffget //3<CR>', mode = 'n', desc = 'Get changes from right' },

    { '<leader>gh', ':Git log -- %<CR>', mode = 'n', desc = 'Git history - this file' },
    { '<leader>gH', ':Git log<CR>', mode = 'n', desc = 'Git history - all' },
  },
  opts = {
    -- Options for fugitive (if needed)
  },
  config = function() end,
}
