# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Plugins to install

- [ ] Git Signs
- [ ] Git Fugitive
    - https://www.reddit.com/r/vim/s/h9GJ6QYgZR
    -
- [x] Which key
- [x] Telescope
  - [x] Grep with arguments
- [ ] rlane/pounce.nvim
- [ ] shortcuts/no-neck-pain.nvim
    - Look into adding a column to limit the width. colour column?

How should we organise the git mappings?  
Everything under `<leader>g`?  
```
{
  'tpope/vim-fugitive',
  keys = {
    { "<leader>gs", ":Git<CR>", mode = "n", desc = "Git status" },
    { "<leader>gb", ":Gblame<CR>", mode = "n", desc = "Git blame" },
    { "<leader>gd", ":Gdiffsplit<CR>", mode = "n", desc = "Git diff split" },
    { "<leader>gc", ":Git commit<CR>", mode = "n", desc = "Git commit" },
    { "<leader>gl", ":Git log<CR>", mode = "n", desc = "Git log" },
    { "<leader>gw", ":Gwrite<CR>", mode = "n", desc = "Write to work tree and index (stage)" },
    -- Additional Fugitive commands as needed
  },
  -- other configurations
}
```

```
{
  'lewis6991/gitsigns.nvim',
  keys = {
    { "<leader>gn", function() gs.next_hunk() end, mode = "n", desc = "Next Hunk" },
    { "<leader>gp", function() gs.prev_hunk() end, mode = "n", desc = "Prev Hunk" },
    { "<leader>ghs", ":Gitsigns stage_hunk<CR>", mode = "n", desc = "Stage Hunk" },
    { "<leader>ghr", ":Gitsigns reset_hunk<CR>", mode = "n", desc = "Reset Hunk" },
    { "<leader>ghp", gs.preview_hunk, mode = "n", desc = "Preview Hunk" },
    { "<leader>ghb", function() gs.blame_line({ full = true }) end, mode = "n", desc = "Blame Line" },
    -- Additional Gitsigns hunk-related commands as needed
  },
  -- other configurations
}
```

### useful merge conflicts 

```
{ "<leader>gdm", ":Gvdiffsplit<CR>", mode = "n", desc = "Git diff split for merge conflicts" }
```

### reviewed setup with telescope

Fugitive.vim Configuration

Fugitive will handle specific Git commands and detailed operations:

```
-- fugitive plugin setup
{
  'tpope/vim-fugitive',
  keys = {
    { "<leader>gb", ":Gblame<CR>", mode = "n", desc = "Git blame" },
    { "<leader>gd", ":Gdiffsplit<CR>", mode = "n", desc = "Git diff split" },
    { "<leader>gc", ":Git commit<CR>", mode = "n", desc = "Git commit" },
    { "<leader>gw", ":Gwrite<CR>", mode = "n", desc = "Write to work tree and index (stage)" },
    { "<leader>gdm", ":Gvdiffsplit<CR>", mode = "n", desc = "Git diff split for merge conflicts" },
    -- Additional Fugitive commands as needed
  },
  -- other configurations
}
```

Gitsigns.nvim Configuration

Gitsigns will be used for in-buffer, real-time hunk actions:

```
local gs = require('gitsigns')

-- gitsigns plugin setup
{
  'lewis6991/gitsigns.nvim',
  keys = {
    { "<leader>gn", function() gs.next_hunk() end, mode = "n", desc = "Next Hunk" },
    { "<leader>gp", function() gs.prev_hunk() end, mode = "n", desc = "Prev Hunk" },
    { "<leader>ghs", ":Gitsigns stage_hunk<CR>", mode = "n", desc = "Stage Hunk" },
    { "<leader>ghr", ":Gitsigns reset_hunk<CR>", mode = "n", desc = "Reset Hunk" },
    { "<leader>ghp", gs.preview_hunk, mode = "n", desc = "Preview Hunk" },
    -- Additional Gitsigns hunk-related commands as needed
  },
  -- other configurations
}
```

Telescope.nvim Configuration

Telescope will provide interactive UIs for branch operations, file history, and status checks:

```
-- telescope plugin setup
{
  'nvim-telescope/telescope.nvim',
  keys = {
    { "<leader>gco", "<cmd>Telescope git_branches<cr>", mode = "n", desc = "Checkout Git branch" },
    { "<leader>gh", "<cmd>Telescope git_commits<cr>", mode = "n", desc = "View Git file history" },
    { "<leader>gst", "<cmd>Telescope git_status<cr>", mode = "n", desc = "View Git status" },
    { "<leader>gsh", "<cmd>Telescope git_stash<cr>", mode = "n", desc = "View Git stash" },
    -- Additional Telescope Git-related commands as needed
  },
  -- other configurations
}
```

fuzzy search for commit

```
{
  'nvim-telescope/telescope.nvim',
  keys = {
    { "<leader>gf", "<cmd>Telescope git_commits<cr>", mode = "n", desc = "Search Git commits" },
    -- other mappings...
  },
  -- other configurations...
}
```

***

### Examples 

https://www.reddit.com/r/neovim/comments/13wd1st/looking_for_some_configs_using_lazynvim_to_use_as/
