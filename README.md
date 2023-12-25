# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Modifying default plugins and mappings

LazyVim starter Kit seems to come with plugins under the hood  
that are not exposed to a user. As such, to change the default  
behaviour we have to override said plugins by recreating them in  
the plugins folder.  

In order to override them without removing existing functionality  
we can simply copy paste the full spec shown in the LazyVim Website:  
https://www.lazyvim.org/plugins/ui

## Plugins to install

- [x] Git Signs
- [x] Git Fugitive
- [x] Which key
- [x] Telescope
  - [x] Grep with arguments
- [ ] rlane/pounce.nvim
- [ ] shortcuts/no-neck-pain.nvim
    - Look into adding a column to limit the width. colour column?

How should we organise the git mappings?  
Everything under `<leader>g`?  

### Examples 

https://www.reddit.com/r/neovim/comments/13wd1st/looking_for_some_configs_using_lazynvim_to_use_as/

## Troubleshooting

* Trouble installing telescope fzf.
  `Failed to run config for telescope-fzf-native.nvim`  
    * Run `cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim && make && cd -`.
    * This should be enough.
* Plugin names should not have extra commas, just the `.lua` one.
