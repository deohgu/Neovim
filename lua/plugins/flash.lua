return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  vscode = true,
  ---@type Flash.Config
  opts = {
    modes = {
      search = {
        enabled = true, -- Replaces the "/" search with flash
        search = {
          incremental = true,
          -- trigger = ';',
        },
      },
    },
    jump = {
      autojump = false,
    },
    label = {
      uppercase = true,
    },
  },
  -- stylua: ignore
  keys = {
    -- Unecessary if we replace the default search.
    -- { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },

    { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  },
}
