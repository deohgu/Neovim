return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    -- add any options here
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    {
      'rcarriga/nvim-notify',
      config = function()
        require('notify').setup {
          -- Set background color for transparency
          background_colour = '#000000',

          -- Make notifications smaller and less intrusive
          max_width = 50, -- Maximum width of notification window
          max_height = 6, -- Maximum height of notification window

          -- Control notification behavior
          stages = 'fade', -- Animation style: fade, slide, static
          timeout = 3000, -- Time in milliseconds before notification disappears (3 seconds)

          -- Limit number of notifications
          max_notifications = 3, -- Maximum number of notifications to show at once

          -- Position and appearance
          top_down = true, -- Display notifications from top to bottom
          render = 'minimal', -- Display style: default, minimal, simple

          -- Merge duplicate notifications
          merge_duplicates = true, -- Merge notifications with the same content

          -- Icons for different notification levels (optional)
          icons = {
            ERROR = '',
            WARN = '',
            INFO = '',
            DEBUG = '',
            TRACE = '✎',
          },
        }
      end,
    },
  },
}
