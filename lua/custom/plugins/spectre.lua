return {
  'nvim-pack/nvim-spectre',
  build = false,
  cmd = 'Spectre',
  opts = { open_cmd = 'noswapfile vnew' },
  -- stylua: ignore
  keys = {
    -- Needs brew install gnu-sed
    { "<leader>rr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    { "<leader>rg", function() require("spectre").open_visual({select_word=true}) end, desc = "Global Search (Spectre)" },
    { "<leader>rg", function() require("spectre").open_visual({select_word=true}) end, desc = "Search current word" },
    { "<leader>rg", function() vim.cmd([[<esc>]]) require("spectre").open_visual() end, mode = 'v', desc = "Search in visual mode" },
    { "<leader>rr", function() require("spectre").open_file_search({select_word=true}) end, desc = "Search on current file" },
  },
}
