return {
  {
    'chrisgrieser/nvim-spider',
    lazy = true,
    keys = { 'w', 'e', 'b', 'ge' },
    config = function()
      vim.keymap.set({ 'n', 'x' }, 'W', 'w', { desc = 'Normal w' })
      vim.keymap.set({ 'n', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>", { desc = 'Spider-w' })
      vim.keymap.set({ 'n', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<CR>", { desc = 'Spider-e' })
      vim.keymap.set({ 'n', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>", { desc = 'Spider-b' })
    end,
  },
}
