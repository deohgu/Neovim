return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'

    -- Define linters for different filetypes
    lint.linters_by_ft = {
      -- Remove eslint_d entries since it will be handled by the language server
      python = { 'ruff' },
      yaml = { 'yamllint' },
      terraform = { 'tflint' },
      markdown = { 'markdownlint' },
      dockerfile = { 'hadolint' },
      -- Use the "*" filetype to run linters on all filetypes.
      -- ["*"] = { "global_linter" },
      -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
      -- ["_"] = { "fallback_linter" },
    }

    -- Optimize eslint_d for performance
    lint.linters.eslint_d.args = {
      '--cache',
      '--quiet',
      '--format',
      'json',
      '--stdin',
      '--stdin-filename',
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
    }

    -- Helper function to determine if we should lint a buffer
    local function should_lint(bufnr)
      -- Check if the buffer has a valid filetype that has a configured linter
      local ft = vim.bo[bufnr].filetype
      if ft and lint.linters_by_ft[ft] then
        return true
      end
      -- Check for fallback linters
      if lint.linters_by_ft['*'] or lint.linters_by_ft['_'] then
        return true
      end
      return false
    end

    -- Create an augroup for our autocommands
    local lint_augroup = vim.api.nvim_create_augroup('nvim-lint', { clear = true })

    -- Lint on file save with debouncing
    vim.api.nvim_create_autocmd('BufWritePost', {
      group = lint_augroup,
      callback = function()
        if should_lint(0) then
          local debounce = vim.fn.has 'win32' == 1 and 250 or 100
          lint.try_lint(nil, { ignore_errors = true, debounce = debounce })
        end
      end,
    })

    -- Lint on file open with a delay to avoid slowing down file opening
    vim.api.nvim_create_autocmd('BufReadPost', {
      group = lint_augroup,
      callback = function()
        if should_lint(0) then
          vim.defer_fn(function()
            lint.try_lint(nil, { ignore_errors = true })
          end, 400)
        end
      end,
    })

    -- Optionally, add this back if you really need linting when leaving insert mode
    -- But be aware it can cause performance issues during rapid editing
    -- vim.api.nvim_create_autocmd('InsertLeave', {
    --   group = lint_augroup,
    --   callback = function()
    --     if should_lint(0) then
    --                 local debounce = vim.fn.has('win32') == 1 and 250 or 100
    --       lint.try_lint(nil, { ignore_errors = true, debounce = debounce })
    --     end
    --   end,
    -- })

    -- Add a user command to manually trigger linting
    vim.api.nvim_create_user_command('Lint', function()
      lint.try_lint(nil, { ignore_errors = true })
    end, {})
  end,
}
