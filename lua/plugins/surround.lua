return {
  "tpope/vim-surround",
  keys = {
    -- Prefix all surround mappings with <leader>s
    { "n", "<leader>ss", "<Plug>Ysurround", desc = "Add surrounding" },
    { "n", "<leader>sc", "<Plug>Csurround", desc = "Change surrounding" },
    { "n", "<leader>sd", "<Plug>Dsurround", desc = "Delete surrounding" },
    { "n", "<leader>sS", "<Plug>YSurround", desc = "Add surrounding (line)" },
    { "n", "<leader>sC", "<Plug>CSurround", desc = "Change surrounding (line)" },
    { "n", "<leader>sD", "<Plug>DSurround", desc = "Delete surrounding (line)" },
    { "n", "<leader>sss", "<Plug>Yssurround", desc = "Add surrounding (whole line)" },
    { "n", "<leader>ssc", "<Plug>Cssurround", desc = "Change surrounding (whole line)" },
    { "n", "<leader>ssd", "<Plug>Dssurround", desc = "Delete surrounding (whole line)" },
    { "v", "<leader>sS", "<Plug>VSurround", desc = "Visual mode surround" },
    { "v", "<leader>sG", "<Plug>VgSurround", desc = "Visual mode surround (line)" },
  },
  config = function()
    -- Additional plugin-specific configurations can go here
  end,
}
