return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = "^1.0.0",
    },
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
  },
  keys = {
    -- disable the keymap to grep files
    { "<leader>/", false },

    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },

    -- Mapping for searching hidden files
    {
      "<leader>fF", -- Change the keymap as needed
      function()
        require("telescope.builtin").find_files({ hidden = true })
      end,
      desc = "Find Files + Hidden",
    },

    -- Key mapping for live_grep_args
    {
      "<leader>fg",
      function()
        require("telescope").extensions.live_grep_args.live_grep_args()
      end,
      desc = "Live Grep with Arguments",
    },

    -- Mapping for grep search including hidden files
    {
      "<leader>fG", -- Change the keymap as needed
      function()
        require("telescope.builtin").live_grep({
          additional_args = function()
            return { "--hidden" }
          end,
        })
      end,
      desc = "Live Grep + Hidden",
    },

    -- Add the mapping for grep_word_under_cursor
    {
      "<leader>fc",
      function()
        require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
      end,
      mode = "n", -- This specifies the mapping is for normal mode
      desc = "Grep Word Under Cursor",
    },

    -- Mapping for grep_visual_selection (for visual mode)
    {
      "<leader>fc",
      function()
        require("telescope-live-grep-args.shortcuts").grep_visual_selection()
      end,
      mode = "v", -- This specifies the mapping is for visual mode
      desc = "Grep Visual Selection",
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
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("live_grep_args")
  end,
}
