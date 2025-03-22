return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    local lint = require 'lint'

    -- Define linters for different filetypes
    lint.linters_by_ft = {
      python = { 'ruff' },
      yaml = { 'yamllint' },
      terraform = { 'tflint' },
      markdown = { 'markdownlint' },
      dockerfile = { 'hadolint' },
    }

    -- Cache filetype lint config lookups
    local lint_config_cache = {}

    -- Optimize eslint_d for performance
    -- Cache this configuration to avoid rebuilding the table on every lint
    local eslint_args = {
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
    lint.linters.eslint_d.args = eslint_args

    -- Helper function to determine if we should lint a buffer - with caching
    local function should_lint(bufnr)
      local ft = vim.bo[bufnr].filetype

      -- Check cache first
      if lint_config_cache[ft] ~= nil then
        return lint_config_cache[ft]
      end

      -- Determine if this filetype has a linter and cache the result
      local has_linter = lint.linters_by_ft[ft] ~= nil or lint.linters_by_ft['*'] ~= nil or lint.linters_by_ft['_'] ~= nil

      lint_config_cache[ft] = has_linter
      return has_linter
    end

    -- Create an augroup for our autocommands
    local lint_augroup = vim.api.nvim_create_augroup('nvim-lint', { clear = true })

    -- Debounce times per OS (higher for Windows)
    local debounce_ms = vim.fn.has 'win32' == 1 and 250 or 100

    -- File patterns to optimize the checks
    local lint_file_patterns = {}
    for ft, _ in pairs(lint.linters_by_ft) do
      if ft ~= '*' and ft ~= '_' then
        table.insert(lint_file_patterns, '*.' .. ft)
      end
    end

    -- Lint on specific file save with debouncing and patterns
    vim.api.nvim_create_autocmd('BufWritePost', {
      group = lint_augroup,
      pattern = lint_file_patterns,
      callback = function(ev)
        if should_lint(ev.buf) then
          lint.try_lint(nil, {
            ignore_errors = true,
            debounce = debounce_ms,
          })
        end
      end,
    })

    -- Lint on file open with a delay and patterns
    vim.api.nvim_create_autocmd('BufReadPost', {
      group = lint_augroup,
      pattern = lint_file_patterns,
      callback = function(ev)
        if should_lint(ev.buf) then
          -- Defer linting to avoid slowing down file opening
          vim.defer_fn(function()
            -- Check if buffer still exists before linting
            if vim.api.nvim_buf_is_valid(ev.buf) then
              lint.try_lint(nil, { ignore_errors = true })
            end
          end, 500) -- Increased from 400ms for better perceived performance
        end
      end,
    })

    -- Add a user command to manually trigger linting
    vim.api.nvim_create_user_command('Lint', function()
      lint.try_lint(nil, { ignore_errors = true })
    end, {})
  end,
}
