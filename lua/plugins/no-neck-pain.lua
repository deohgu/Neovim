return {
  "shortcuts/no-neck-pain.nvim",
  opts = {
    width = 100,
    mappings = {
      -- Enable the mappings set below.
      enabled = true,
      -- Toggle the width command on and off.
      toggle = "<Leader>bw",
    },
    autocmds = {
      -- When `true`, enables the plugin when you start Neovim.
      -- If the main window is  a side tree (e.g. NvimTree) or a dashboard, the command is delayed until it finds a valid window.
      -- The command is cleaned once it has successfuly ran once.
      -- !! Set to false until we figure out the wrapping - currently not doing so.
      enableOnVimEnter = false,
    },
  },
}
