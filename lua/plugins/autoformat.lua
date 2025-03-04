-- Pre-define the disable_filetypes table outside function to avoid recreation on every save
local disable_filetypes = { c = true, cpp = true }

-- Create a cache for formatter lookup
local formatter_cache = {}

return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre', 'BufReadPost' }, -- More aggressive lazy loading
  cmd = { 'ConformInfo', 'FormatToggle', 'FormatEnable', 'FormatDisable' },

  -- Only define key mapping if formatters are available
  keys = function()
    if #vim.tbl_keys(require('conform').formatters_by_ft) > 0 then
      return {
        {
          '<leader>F',
          function()
            require('conform').format { async = true, lsp_fallback = true, quiet = true }
          end,
          mode = '',
          desc = '[F]ormat buffer',
        },
      }
    end
    return {}
  end,

  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local ft = vim.bo[bufnr].filetype

      -- Use cached result if available
      if formatter_cache[ft] == nil then
        formatter_cache[ft] = not disable_filetypes[ft]
      end

      return {
        timeout_ms = 2000,
        lsp_fallback = formatter_cache[ft],
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
        timeout_ms = 5000, -- Increased timeout for this specific formatter
      },
    },
  },
}
