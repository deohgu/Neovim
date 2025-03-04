-- Currently only providing linting diagnostics. Auto-formatting is being done
-- by stevearc/conform.nvim
return {
  'nvimtools/none-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = { 'BufReadPre', 'BufNewFile' }, -- Lazy load to speed up startup
  config = function()
    local null_ls = require 'null-ls'
    null_ls.setup {
      -- debug = true, -- enable if you want logs via :NullLsLog
      sources = {
        -- JS/TS
        null_ls.builtins.diagnostics.eslint_d, -- Use eslint_d instead of eslint

        -- Python
        null_ls.builtins.diagnostics.ruff,

        -- YAML
        null_ls.builtins.diagnostics.yamllint,

        -- Terraform
        null_ls.builtins.diagnostics.tflint,

        -- Markdown
        null_ls.builtins.diagnostics.markdownlint,

        -- Docker
        null_ls.builtins.diagnostics.hadolint,

        -- Etc., add more built-ins if desired...

        debounce = 250, -- Reduce excessive linting calls
      },
      on_attach = function(client, bufnr) end,
    }
  end,
}
