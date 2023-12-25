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
-- fugitive plugin setup
{
  keys = {
    { "<leader>gs", ":Git<CR>", mode = "n", desc = "Git status" },
    { "<leader>gb", ":Gblame<CR>", mode = "n", desc = "Git blame" },
    { "<leader>gd", ":Gdiffsplit<CR>", mode = "n", desc = "Git diff split" },
    { "<leader>gc", ":Git commit<CR>", mode = "n", desc = "Git commit" },
    { "<leader>gl", ":Git log<CR>", mode = "n", desc = "Git log" },
  },
}
```

```
-- gitsigns plugin setup
{
  keys = {
    { "]h", function() gs.next_hunk() end, mode = "n", desc = "Next Hunk" },
    { "[h", function() gs.prev_hunk() end, mode = "n", desc = "Prev Hunk" },
    { "<leader>hs", ":Gitsigns stage_hunk<CR>", mode = "n", desc = "Stage Hunk" },
    { "<leader>hr", ":Gitsigns reset_hunk<CR>", mode = "n", desc = "Reset Hunk" },
    { "<leader>hS", gs.stage_buffer, mode = "n", desc = "Stage Buffer" },
    { "<leader>hu", gs.undo_stage_hunk, mode = "n", desc = "Undo Stage Hunk" },
    { "<leader>hR", gs.reset_buffer, mode = "n", desc = "Reset Buffer" },
    { "<leader>hp", gs.preview_hunk, mode = "n", desc = "Preview Hunk" },
    { "<leader>hb", function() gs.blame_line({ full = true }) end, mode = "n", desc = "Blame Line" },
  },
}

```

### Examples 

https://www.reddit.com/r/neovim/comments/13wd1st/looking_for_some_configs_using_lazynvim_to_use_as/
