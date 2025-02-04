return {
  {
    'FabijanZulj/blame.nvim',
    lazy = false,
    config = function()
      require('blame').setup()
      vim.keymap.set('n', '<leader>gb', ':BlameToggle<CR>', { noremap = true, silent = true })
    end,
  },
}
