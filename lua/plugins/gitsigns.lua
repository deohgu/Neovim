return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  keys = {
    { ']g', "<cmd>lua require('gitsigns').next_hunk()<CR>", mode = 'n', desc = 'Next Git Hunk' },
    { '[g', "<cmd>lua require('gitsigns').prev_hunk()<CR>", mode = 'n', desc = 'Prev Git Hunk' },
    { '<leader>gs', "<cmd>lua require('gitsigns').stage_hunk()<CR>", mode = 'n', desc = 'Stage Git Hunk' },
    { '<leader>gu', "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>", mode = 'n', desc = 'Unstage Git Hunk' },
    { '<leader>gr', "<cmd>lua require('gitsigns').reset_hunk()<CR>", mode = 'n', desc = 'Revert Git Hunk' },
    { '<leader>gS', "<cmd>lua require('gitsigns').stage_buffer()<CR>", mode = 'n', desc = 'Stage Buffer' },
    { '<leader>gR', "<cmd>lua require('gitsigns').reset_buffer()<CR>", mode = 'n', desc = 'Reset Buffer' },
  },
  opts = {
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
      untracked = { text = '▎' },
    },
    -- Performance optimizations
    watch_gitdir = {
      interval = 2000, -- Check for git changes every 2 seconds instead of default 1
      follow_files = true,
    },
    attach_to_untracked = false, -- Don't attach to untracked files
    update_debounce = 500, -- Increase debounce time to 500ms (default is 100ms)
    max_file_length = 40000, -- Skip files with more than 40,000 lines
    preview_config = {
      border = 'rounded',
      style = 'minimal',
    },
    -- Limit number of signs
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    -- Only update on specific events
    _threaded_diff = true, -- Use background thread for diff calculation
    _extmark_signs = true, -- Use extmarks for signs (better performance)
    on_attach = function(buffer)
      -- Your existing on_attach function
    end,
  },
}
