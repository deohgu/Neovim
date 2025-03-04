return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo', 'FormatToggle', 'FormatEnable', 'FormatDisable' },
  keys = {
    {
      '<leader>F',
      function()
        require('conform').format { async = true, lsp_fallback = true, quiet = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 2000,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_fix', 'ruff_format' }, -- Run fix first, then format
      terraform = { 'terraform_fmt' },
      tf = { 'terraform_fmt' },
      ['terraform-vars'] = { 'terraform_fmt' },
      javascript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      html = { 'prettierd' },
      rust = {},
    },
    formatters = {
      ruff_fix = {
        command = 'ruff',
        args = { 'check', '--select', 'I', '--fix', '-e', '-n', '--stdin-filename', '$FILENAME', '-' },
        stdin = true,
      },
    },
  },
}
