return {
  'sindrets/diffview.nvim',
  keys = {
    { '<leader>gD', '<cmd>lua toggle_diffview()<CR>', desc = 'Toggle Diff View' },
  },
  config = function()
    require('diffview').setup()

    -- Function to check if a Diffview buffer is open
    local function is_diffview_open()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_buf_get_option(buf, 'filetype') == 'DiffviewFiles' then
          return true
        end
      end
      return false
    end

    -- Global function to toggle Diffview
    function toggle_diffview()
      if is_diffview_open() then
        vim.cmd 'DiffviewClose'
      else
        vim.cmd 'DiffviewOpen'
      end
    end
  end,
}
