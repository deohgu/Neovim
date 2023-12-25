return {
  "lewis6991/gitsigns.nvim",
  event = "LazyFile",
  keys = {
    { "]h", "<cmd>lua require('gitsigns').next_hunk()<CR>", mode = "n", desc = "Next Hunk" },
    { "[h", "<cmd>lua require('gitsigns').prev_hunk()<CR>", mode = "n", desc = "Prev Hunk" },
    { "<leader>ghs", "<cmd>lua require('gitsigns').stage_hunk()<CR>", mode = "n", desc = "Stage Hunk" },
    { "<leader>ghu", "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>", mode = "n", desc = "Unstage Hunk" },
    { "<leader>ghr", "<cmd>lua require('gitsigns').reset_hunk()<CR>", mode = "n", desc = "Revert Hunk" },
    { "<leader>gS", "<cmd>lua require('gitsigns').stage_buffer()<CR>", mode = "n", desc = "Stage Buffer" },
    { "<leader>gR", "<cmd>lua require('gitsigns').reset_buffer()<CR>", mode = "n", desc = "Reset Buffer" },
  },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end
    end,
  },
}
