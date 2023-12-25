return {
  "tpope/vim-fugitive",
  event = "LazyFile",
  keys = {
    { "<leader>gg", ":Git<CR>", mode = "n", desc = "Status - Fugitive" },
    { "<leader>gb", ":Git blame<CR>", mode = "n", desc = "Blame" },
    { "<leader>gd", ":Gdiffsplit<CR>", mode = "n", desc = "Diff split" },
    -- Check if this is different from the above
    { "<leader>gx", ":Gvdiffsplit<CR>", mode = "n", desc = "Diff split for merge conflicts" },
  },
  opts = {
    -- Options for fugitive (if needed)
  },
  config = function() end,
}
