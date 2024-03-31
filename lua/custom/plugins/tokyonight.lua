return {
  'folke/tokyonight.nvim',
  opts = {
    style = 'moon',
    transparent = vim.g.transparent_enabled,
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
    -- vim.cmd [[hi Normal ctermbg=none guibg=none]]
    -- vim.cmd [[hi Comment gui=none]]
  end,
}
