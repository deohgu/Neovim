return {
  "tpope/vim-fugitive",
  event = "LazyFile",
  keys = {
    {
      "<leader>gx",
      function()
        vim.cmd("Git blame")
      end,
      mode = "n", -- Normal mode
      desc = "Git Blame",
    },
    {
      "<leader>gd",
      function()
        vim.cmd("Gdiff")
      end,
      mode = "n", -- Normal mode
      desc = "Git Diff", -- Description of the key mapping
    },
  },
  opts = {
    -- Options for fugitive (if needed)
  },
  config = function()
    -- Your configuration and key mappings for fugitive
    vim.cmd([[ nnoremap <leader>gss :Git<CR> ]]) -- Example key mapping to open git status
    -- vim.cmd([[ nnoremap <leader>gd :Gdiff<CR> ]])
  end,
}
