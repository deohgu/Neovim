return {
  "nvim-pack/nvim-spectre",
  build = false,
  cmd = "Spectre",
  opts = { open_cmd = "noswapfile vnew" },
  -- stylua: ignore
  keys = {
    { "<leader>sr", false },
    { "<leader>rr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    { "<leader>rg", function() require("spectre").open_visual({select_word=true}) end, desc = "Global Search (Spectre)" },
  },
}
