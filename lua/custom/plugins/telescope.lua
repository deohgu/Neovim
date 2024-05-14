return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    {
      'nvim-telescope/telescope-live-grep-args.nvim',
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = '^1.0.0',
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    {
      'aaronhallaert/advanced-git-search.nvim',
      dependencies = {
        'nvim-telescope/telescope.nvim',
        'tpope/vim-fugitive',
        'tpope/vim-rhubarb',
      },
    },
    'nvim-telescope/telescope-frecency.nvim',
  },

  keys = {
    -- disable the keymap to grep files
    { '<leader>/', false },
    { '<leader>s', false },
    { '<leader>sa', false },
    { '<leader>s"', false },
    { '<leader>sb', false },
    { '<leader>sc', false },
    { '<leader>sC', false },
    { '<leader>sd', false },
    { '<leader>sD', false },
    { '<leader>sg', false },
    { '<leader>sG', false },
    { '<leader>sh', false },
    { '<leader>sH', false },
    { '<leader>sk', false },
    { '<leader>sm', false },
    { '<leader>sM', false },
    { '<leader>so', false },
    { '<leader>sr', false },
    { '<leader>sR', false },
    { '<leader>ss', false },
    { '<leader>sS', false },
    { '<leader>st', false },
    { '<leader>sT', false },
    { '<leader>sw', false },
    { '<leader>sW', false },
    { '<leader>gs', false },

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

    {
      '<leader>ff',
      function()
        require('telescope.builtin').find_files {
          prompt_title = 'Find Files',
          attach_mappings = function(prompt_bufnr, map)
            map('i', '<C-t>', function()
              local prompt_bufnr = vim.api.nvim_get_current_buf()
              local prompt_text = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, 1, false)[1]
              vim.api.nvim_buf_set_text(prompt_bufnr, 0, #prompt_text, 0, #prompt_text, { ' .$' })
              vim.api.nvim_win_set_cursor(0, { 1, #prompt_text + 2 })
            end)

            return true
          end,
        }
      end,
      desc = 'Find Files',
    },

    -- Mapping for searching hidden files
    {
      '<leader>fF', -- Change the keymap as needed
      function()
        require('telescope.builtin').find_files { hidden = true }
      end,
      desc = 'Find Files + Hidden',
    },

    -- Key mapping for live_grep_args
    {
      '<leader>fg',
      function()
        require('telescope').extensions.live_grep_args.live_grep_args {
          mappings = {
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

                vim.api.nvim_buf_set_text(prompt_bufnr, 0, #prompt_text, 0, #prompt_text, { ' -g**' })
                vim.api.nvim_win_set_cursor(0, { 1, #prompt_text + 4 })
              end,
              ['<C-h>'] = function()
                local prompt_bufnr = vim.api.nvim_get_current_buf()
                local prompt_text = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, 1, false)[1]

                if not string.find(prompt_text, '--hidden') then
                  vim.api.nvim_buf_set_text(prompt_bufnr, 0, #prompt_text, 0, #prompt_text, { ' --hidden' })
                end
              end,
            },
          },
        }
      end,
      desc = 'Live Grep with Arguments',
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

    -- add a keymap to browse plugin files
    -- {
    -- "<leader>fp",
    -- function()
    -- require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
    -- end,
    -- desc = "Find Plugin File",
    -- },
  },
  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions' -- Ensure actions is required
    local lga_actions = require 'telescope-live-grep-args.actions'
    local builtin = require 'telescope.builtin'
    -- local vim = require("telescope-live-grep-args.actions")

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            -- Not working ,the sreen just flashes for some reason?
            ['<c-f>'] = actions.to_fuzzy_refine,
          },
        },
      },

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
    -- require("telescope").load_extension("advanced-git-search")
  end,
}
