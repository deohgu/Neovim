return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },

  {
    "tpope/vim-fugitive",
    -- By default we have Lazy.nvim enabling lazy loading for plugins. Because of this make sure to either include conditions for plugins to be loaded or make sure to add lazy = false to the plugin definition.
    lazy = false,
    config = function()
      -- Add any specific configurations here
      -- Example: Set a custom command or key binding
      vim.api.nvim_set_keymap('n', '<leader>gf', ':Git Fugitive<CR>', { noremap = true, silent = true })
    end,
  },
}
