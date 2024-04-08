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
    -- vim.cmd [[hi Normal ctermbg=none guibg=none]]
    -- vim.cmd [[hi Comment gui=none]]

    -- Example of targetting specific plugins - https://github.com/shaunsingh/nord.nvim/blob/e0f536da5716288021bb53d6167a36434b11ba79/lua/nord/theme.lua#L426-L428
    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE', ctermbg = 'NONE' })
    vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = 'NONE', ctermbg = 'NONE' })
    vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { bg = 'NONE', ctermbg = 'NONE' })

    vim.g.tokyonight_dark_float = false
  end,
}
