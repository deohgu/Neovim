return {
  'fannheyward/telescope-coc.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('telescope').setup {
      extensions = {
        coc = {
          theme = 'ivy',
          prefer_locations = true,
          push_cursor_on_edit = true,
          timeout = 8000,
        },
      },
    }
  end,
}
