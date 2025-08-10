return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile' },
  build = function()
    -- Only update parsers that are already installed
    require('nvim-treesitter.install').update { with_sync = false }
  end,
  dependencies = {
    -- Add incremental selection - more efficient than reloading all features
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      init = function()
        -- Defer loading to improve startup time
        -- PERF: no need to load the plugin until we actually use it
        local plugin = require('lazy.core.config').spec.plugins['nvim-treesitter-textobjects']
        local ts_loader = require 'lazy.core.loader'
        ts_loader.disable_rtp_plugin 'nvim-treesitter-textobjects'
        ts_loader.load(plugin, { event = 'VeryLazy' }, { force = true })
      end,
    },
  },
  opts = {
    -- Performance tweaks
    sync_install = false, -- Don't install parsers synchronously
    auto_install = false, -- Don't auto install missing parsers

    highlight = {
      enable = true,
      -- Disable for large files
      disable = function(_, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      -- Only highlight visible text (huge performance improvement)
      additional_vim_regex_highlighting = false,
    },

    indent = {
      enable = true,
      -- Disable indentation for these file types due to performance issues
      disable = { 'yaml', 'python' },
    },

    -- Add incremental selection
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = '<nop>',
        node_decremental = '<bs>',
      },
    },

    -- Only include parsers you actually use regularly
    ensure_installed = {
      -- Core languages in your config
      'lua',
      'python',
      'yaml',
      'json',
      'bash',
      'markdown',
      -- Secondary languages you use frequently
      'typescript',
      'javascript',
      'go',
      'rust',
      'terraform',
      'prisma',
      -- Minimal required parsers
      'vim',
      'vimdoc',
      'query',
    },

    -- Module-specific performance tuning
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Prefetch nodes, more efficient but slightly slower
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- Update the jump list
        goto_next_start = {
          [']f'] = '@function.outer',
          [']c'] = '@class.outer',
        },
        goto_previous_start = {
          ['[f'] = '@function.outer',
          ['[c'] = '@class.outer',
        },
      },
    },
  },
  config = function(_, opts)
    -- Cache the treesitter configs to avoid rebuilding them
    local treesitter_configs = require 'nvim-treesitter.configs'

    -- Load the configurations
    treesitter_configs.setup(opts)

    -- Performance optimization for large files
    vim.api.nvim_create_autocmd('BufReadPre', {
      callback = function(event)
        local buf = event.buf
        local file_size = vim.fn.getfsize(vim.api.nvim_buf_get_name(buf))

        -- For large files, disable certain features
        if file_size > 1024 * 1024 then -- 1MB
          -- Disable treesitter for very large files
          vim.cmd 'TSBufDisable highlight'
          -- Also disable other heavy features
          vim.b[buf].large_buf = true
          vim.opt_local.syntax = 'off'
          vim.opt_local.swapfile = false
        end
      end,
    })
  end,
}
