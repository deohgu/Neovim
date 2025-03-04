return {
  'NeogitOrg/neogit',
  opts = {
    disable_commit_confirmation = false,
    auto_show_console = true,
  },
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration

    -- Only one of these is needed, not both.
    'nvim-telescope/telescope.nvim', -- optional
    'ibhagwan/fzf-lua', -- optional
  },
  config = true,
  keys = {
    {
      '<leader>gg',
      function()
        require('neogit').open {}
      end,
      desc = 'Status - Neogit',
    },
  },
}
