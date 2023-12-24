return {
  "tpope/vim-surround",
  keys = {

    -- Normal mode mappings
    {
      "<leader>ss",
      function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>Ysurround", true, true, true), "n", true)
      end,
      mode = "n", -- Normal mode
      desc = "Add surrounding",
    },
    {
      "<leader>sc",
      function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>Csurround", true, true, true), "n", true)
      end,
      mode = "n", -- Normal mode
      desc = "Change surrounding",
    },
    {
      "<leader>sd",
      function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>Dsurround", true, true, true), "n", true)
      end,
      mode = "n", -- Normal mode
      desc = "Delete surrounding",
    },
    -- Additional normal mode mappings...

    -- Visual mode mappings
    {
      "<leader>sS",
      function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>VSurround", true, true, true), "x", true)
      end,
      mode = "x", -- Visual mode
      desc = "Visual mode surround",
    },
    {
      "<leader>sG",
      function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>VgSurround", true, true, true), "x", true)
      end,
      mode = "x", -- Visual mode
      desc = "Visual mode surround (line)",
    },
  },
  config = function()
    -- Additional plugin-specific configurations can go here
  end,
}
