return {
  'folke/tokyonight.nvim',
  opts = {
    style = 'moon',
    transparent = true,
    styles = {
      comments = { italic = true },
      keywords = {},
      functions = { italic = true },
      variables = {},
      sidebars = 'transparent',
      -- floats = 'dark',
      floats = 'transparent',
    },
  },
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'tokyonight-night'
  end,
}
