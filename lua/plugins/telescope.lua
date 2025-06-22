-- Create a utility function for the common mappings
local function add_telescope_mappings(mappings)
  -- Return the standard mappings that can be reused
  return {
    i = {
      ['<C-t>'] = function()
        local prompt_bufnr = vim.api.nvim_get_current_buf()
        local prompt_text = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, 1, false)[1]
        vim.api.nvim_buf_set_text(prompt_bufnr, 0, #prompt_text, 0, #prompt_text, { ' -t' })
        vim.api.nvim_win_set_cursor(0, { 1, #prompt_text + 3 })
      end,
      -- Add the filter out / exclude glob pattern
      ['<C-x>'] = function()
        local prompt_bufnr = vim.api.nvim_get_current_buf()
        local prompt_text = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, 1, false)[1]
        vim.api.nvim_buf_set_text(prompt_bufnr, 0, #prompt_text, 0, #prompt_text, { ' -g!**' })
        vim.api.nvim_win_set_cursor(0, { 1, #prompt_text + 5 })
      end,
      -- Add the filter / include only glob pattern
      ['<C-i>'] = function()
        local prompt_bufnr = vim.api.nvim_get_current_buf()
        local prompt_text = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, 1, false)[1]
        vim.api.nvim_buf_set_text(prompt_bufnr, 0, #prompt_text, 0, #prompt_text, { ' -g**/*/**' })
        vim.api.nvim_win_set_cursor(0, { 1, #prompt_text + 6 })
      end,
      -- Add double quotes around text and append -F at the end
      ['<C-f>'] = function()
        local prompt_bufnr = vim.api.nvim_get_current_buf()
        local prompt_text = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, 1, false)[1]
        -- Move cursor to the beginning of the line and insert the opening double quote
        vim.api.nvim_win_set_cursor(0, { 1, 1 })
        vim.api.nvim_put({ '"' }, 'c', true, true)
        -- Move cursor to the end of the line and insert the closing double quote and -F
        local end_pos = #prompt_text + 2 -- Adjusting position to account for the opening quote
        vim.api.nvim_win_set_cursor(0, { 1, end_pos })
        vim.api.nvim_put({ '"' }, 'c', true, true)
        vim.api.nvim_put({ ' -F' }, 'c', true, true)
      end,
    },
  }
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    {
      'aaronhallaert/advanced-git-search.nvim',
      dependencies = {
        'nvim-telescope/telescope.nvim',
        'tpope/vim-fugitive',
        'tpope/vim-rhubarb',
      },
    },

    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    {
      -- frecency algorithm for sorting results
      'danielfalk/smart-open.nvim',
      branch = '0.2.x',
      dependencies = {
        'kkharji/sqlite.lua',
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          build = 'make',
        },
        { 'nvim-telescope/telescope-fzy-native.nvim' },
      },
      opts = {
        result_limit = 50,
      },
    },
    -- 'debugloop/telescope-undo.nvim',
    {
      'nvim-telescope/telescope-live-grep-args.nvim',
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = '^1.0.0',
    },
  },

  keys = {
    {
      '<leader>fb',
      function()
        require('telescope.builtin').buffers {
          initial_mode = 'normal',
          sort_mru = true,
          sort_lastused = true,
        }
      end,
      desc = 'Buffers',
    },

    {
      '<leader>fj',
      function()
        require('telescope.builtin').jumplist {}
      end,
      desc = 'Jumplist',
    },

    -- Mapping for searching hidden files
    {
      '<leader>fu', -- Change the keymap as needed
      function()
        require('telescope.builtin').find_files {
          find_command = { 'rg', '--ignore', '--hidden', '--files', '-u' },
        }
      end,
      desc = 'Find Unrestricted (.env)',
    },

    -- git
    {
      '<leader>gc',
      function()
        require('telescope.builtin').git_commits {
          initial_mode = 'normal',
        }
      end,
      desc = 'Commits',
    },

    -- NOTE: Telescope native file search
    -- {
    --   '<leader>ff',
    --   function()
    --     require('telescope.builtin').find_files {
    --       prompt_title = 'Find Files',
    --       attach_mappings = function(prompt_bufnr, map)
    --         map('i', '<C-t>', function()
    --           local prompt_bufnr = vim.api.nvim_get_current_buf()
    --           local prompt_text = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, 1, false)[1]
    --           vim.api.nvim_buf_set_text(prompt_bufnr, 0, #prompt_text, 0, #prompt_text, { ' .$' })
    --           vim.api.nvim_win_set_cursor(0, { 1, #prompt_text + 2 })
    --         end)
    --
    --         return true
    --       end,
    --     }
    --   end,
    --   desc = 'Find Files',
    -- },

    -- Mapping for searching hidden files
    {
      '<leader>fF', -- Change the keymap as needed
      function()
        require('telescope.builtin').find_files { hidden = true }
      end,
      desc = 'Find Files + Hidden',
    },

    {
      '<leader>ff', -- Change the keymap as needed
      function()
        -- require('telescope.builtin').find_files { hidden = true }
        require('telescope').extensions.smart_open.smart_open {
          cwd_only = true,
          filename_first = true,
          show_scores = false,
          match_algorithm = 'fzf',
        }
      end,
      desc = 'Find Files + Hidden',
    },

    -- Key mapping for live_grep_args
    {
      '<leader>fg',
      function()
        require('telescope').extensions.live_grep_args.live_grep_args {
          mappings = add_telescope_mappings(),
        }
      end,
      desc = 'Live Grep with Arguments',
    },

    {
      '<leader>fG',
      function()
        require('telescope').extensions.live_grep_args.live_grep_args {
          additional_args = function()
            return { '--no-ignore' }
          end,
          mappings = add_telescope_mappings(),
        }
      end,
      desc = 'Live Grep with Arguments (Unrestricted)',
    },

    -- Add the mapping for grep_word_under_cursor
    {
      '<leader>fc',
      function()
        require('telescope-live-grep-args.shortcuts').grep_word_under_cursor {
          initial_mode = 'normal',
        }
      end,
      mode = 'n', -- This specifies the mapping is for normal mode
      desc = 'Grep Word Under Cursor',
    },

    -- Mapping for grep_visual_selection (for visual mode)
    {
      '<leader>fc',
      function()
        require('telescope-live-grep-args.shortcuts').grep_visual_selection {
          initial_mode = 'normal',
        }
      end,
      mode = 'v', -- This specifies the mapping is for visual mode
      desc = 'Grep Visual Selection',
    },

    -- Resume the previous query
    {
      '<leader>fr',
      function()
        require('telescope.builtin').resume {
          initial_mode = 'normal',
        }
      end,
      mode = 'n', -- This specifies the mapping is for visual mode
      desc = 'Resume previous query',
    },

    {
      '<leader>fd',
      function()
        require('telescope.builtin').diagnostics {
          initial_mode = 'normal',
        }
      end,
      mode = 'n', -- This specifies the mapping is for visual mode
      desc = 'Show diagnostics',
    },
  },

  -- { '<leader>fu', '<cmd>Telescope undo<cr>', desc = 'undo history' },
  -- { -- lazy style key map
  --   '<leader>u',
  --   '<cmd>Telescope undo<cr>',
  --   desc = 'undo history',
  -- },

  -- TODO: Could not get to work
  -- {
  --   '<leader>fu',
  --   function()
  --     require('telescope').extensions.undo.undo {}
  --   end,
  --   desc = 'Find Files + Hidden',
  -- },

  config = function()
    local telescope = require 'telescope'

    telescope.setup {
      extensions = {
        live_grep_args = {
          auto_quoting = false, -- disable auto-quoting
          mappings = {
            i = {},
          },
        },
      },
    }

    require('telescope').load_extension 'fzf'
    require('telescope').load_extension 'live_grep_args'
    -- require('telescope').load_extension 'undo'
    require('telescope').load_extension 'smart_open'
  end,
}
