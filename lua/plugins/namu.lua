return {
  'bassamsdata/namu.nvim',
  config = function()
    require('namu').setup {
      -- Enable the modules you want
      namu_symbols = {
        enable = true,
        options = {
          movement = {
            next = { '<DOWN>', '<C-n>' }, -- Down arrow first for priority
            previous = { '<UP>', '<C-p>' }, -- Up arrow first for priority
            close = { '<ESC>' },
            select = { '<CR>' },
          },
        },
      },
      -- Optional: Enable other modules if needed
      ui_select = { enable = false }, -- vim.ui.select() wrapper
      colorscheme = {
        enable = false,
        options = {
          persist = true,
          write_shada = false,
        },
      },
    }
    -- === Suggested Keymaps: ===
    vim.keymap.set('n', '<leader>fs', ':Namu symbols<cr>', {
      desc = 'Jump to LSP symbol',
      silent = true,
    })
  end,
}
