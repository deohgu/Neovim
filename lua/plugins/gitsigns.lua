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
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function visual_stage()
        local first_line = vim.fn.line 'v'
        local last_line = vim.fn.getpos('.')[2]
        gs.stage_hunk { first_line, last_line }
        -- Switch back to normal mode, there may be a cleaner way to do this
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 't', false)
      end

      -- Add visual mode mapping for staging part of a hunk
      vim.keymap.set('v', '<leader>gs', function()
        visual_stage()
      end, { desc = 'Stage selected hunk' })

      local function visual_unstage()
        local first_line = vim.fn.line 'v'
        local last_line = vim.fn.getpos('.')[2]
        gs.undo_stage_hunk { first_line, last_line }
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 't', false)
      end

      -- Add visual mode mapping for unstaging part of a hunk
      vim.keymap.set('v', '<leader>gu', function()
        visual_unstage()
      end, { desc = 'Unstage selected hunk' })

      local function visual_revert()
        local first_line = vim.fn.line 'v'
        local last_line = vim.fn.getpos('.')[2]
        gs.reset_hunk { first_line, last_line }
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 't', false)
      end

      -- Add visual mode mapping for reverting part of a hunk
      vim.keymap.set('v', '<leader>gr', function()
        visual_revert()
      end, { desc = 'Revert selected hunk' })
    end,
  },
}
