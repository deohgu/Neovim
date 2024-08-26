return { -- Autoformat
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      python = { 'isort', 'black' },
      -- Using the new syntax for JavaScript formatters
      javascript = {
        'prettierd',
        'prettier',
      },
    },
    -- New option to replace the deprecated nested {} syntax
    javascript = {
      formatters = { 'prettierd', 'prettier' },
      -- This replaces the old { { 'prettierd', 'prettier' } } syntax
      stop_after_first = true,
    },
  },
}
